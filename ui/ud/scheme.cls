VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CScheme"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Public Enum MiceLinesModeConsts
    MiceLinesFull = 0
    MiceLinesHalf
    MiceLinesFullWithCoords
    MiceLinesHalfWithCoords
    MaxMiceLineMode
End Enum

Public Enum FileIOresults
    IOErrOK = 0
    IOErrInvalidFile
    IOErrWrongSignature
    IOErrVersionMismatch
    IOErrSystem
End Enum

Public Enum CursorIndex
    ciCross = 1
    ciSpot
    ciCursorCount
End Enum

Private Type ScmHead
    Sign(1 To 4) As Byte            ' 4
    Version(1 To 4) As Byte         ' 8
    Cols As Long                    ' 12
    Rows As Long                    ' 16
    dScale As Double                ' 24
    bShowGrid As Boolean            ' 26
    bShowRules As Boolean           ' 28
    bShowMiceLines As Boolean       ' 30
    MiceLineMode As Integer         ' 32
    rcDisplay As CRect              ' 48
    rcAll As CRect                  ' 64
    rcItem As CRect                 ' 80
    vCol As Long                    ' 84
    vColNum As Long                 ' 88
    vRow As Long                    ' 92
    vRowNum As Long                 ' 96
    begY As Long                    ' 100
    endY As Long                    ' 104
    begX As Long                    ' 108
    endX As Long                    ' 112
    hotCol As Long                  ' 116
    hotRow As Long                  ' 120
    offsetX As Long                 ' 124
    offsetY As Long                 ' 128
    lReserver As Long               ' 132
    Reserved(1 To 124) As Byte      ' must be 256!!!
End Type

Public StatusText As String

Private Const clItemCx As Long = 64
Private Const clItemCy As Long = 64
Private Const clCols As Long = 64
Private Const clRows As Long = 48

Private Const cdMinScale As Double = 0.01
Private Const cdMaxScale As Double = 40.96
Private Const cdScaleMul As Double = 0.02
Private Const cdScaleMul2 As Double = 0.5

Private Const clRuleCx As Long = 16
Private Const clRuleCy As Long = 16
Private Const clRuleCx2 As Long = clRuleCx \ 2
Private Const clRuleCy2 As Long = clRuleCy \ 2

Private Scm As ScmHead
Private Item() As CellDesc

' Drag
Private lastLeft As Long
Private lastTop As Long
Private dragX As Long
Private dragY As Long

' Appearance
Private penGrid As Long
Private penRulesLine As Long
Private penRulesMark As Long
Private penMiceLine As Long
Private penCell As Long
Private brushCell As Long

' Fonts
Private fontHelpers As Long
Private fontCell As Long

' Cursors
Private Cursor(1 To ciCursorCount - 1) As Long

Public Sub DoDebugStuff()
    Clear
    
    Item(32, 22) = CreateVoltmeter()
    Item(30, 24) = CreateAmpermeter()
    Item(32, 24) = CreateResistor()
End Sub

Public Sub Class_Initialize()
    Scm.Sign(1) = Asc("W")
    Scm.Sign(2) = Asc("C")
    Scm.Sign(3) = Asc("D")
    Scm.Sign(4) = Asc("X")
    Scm.Version(1) = 1
    Scm.Version(2) = 0
    Scm.Version(3) = 0
    Scm.Version(4) = 0
    Scm.lReserver = &HEEEEEE0E
    Scm.Reserved(UBound(Scm.Reserved)) = Asc("Z")
    
    penGrid = CreatePen(DocGridPenStyle, 1, DocGridColor)
    penRulesLine = CreatePen(DocRulesPenStyle, 1, DocRulesColor)
    penRulesMark = CreatePen(DocRulesPenStyle, 2, DocRulesColor)
    penMiceLine = CreatePen(DocMiceLinePenStyle, 1, DocMiceLineColor)
    penCell = CreatePen(DonCellPenStyle, DonCellPenWidth, DocCellPenColor)
    brushCell = GetStockObject(NULL_BRUSH)
    fontHelpers = CreateFontA(-9, 0, 0, 0, FW_NORMAL, False, False, False, 0, 0, 0, PROOF_QUALITY, 0, "Small fonts")
    fontCell = CreateFontA(-32, 0, 0, 0, FW_NORMAL, False, False, False, 0, 0, 0, PROOF_QUALITY, 0, "Arial Narrow")
    
    Cursor(ciCross) = LoadCursorA(UdMain.hInstance, 101)
    Cursor(ciSpot) = LoadCursorA(UdMain.hInstance, 102)

    ResetView
    
    Scm.bShowGrid = True
    Scm.bShowRules = True
    Scm.bShowMiceLines = True
    Scm.MiceLineMode = MiceLinesFull
    
    Alloc clCols, clRows
End Sub

Private Sub Class_Terminate()
    Dim i As Integer
    
    For i = ciCursorCount - 1 To 1 Step -1
        DeleteObject Cursor(i)
    Next i
    
    DeleteObject fontCell
    DeleteObject fontHelpers
    DeleteObject brushCell
    DeleteObject penCell
    DeleteObject penMiceLine
    DeleteObject penRulesMark
    DeleteObject penRulesLine
    DeleteObject penGrid
End Sub

Public Function GetCursor(dex As Integer) As Long
    GetCursor = Cursor(dex)
End Function

Public Sub ResetView()
    Scm.dScale = 1#
    Scm.offsetX = 0
    Scm.offsetY = 0
    Scm.hotCol = -1
    Scm.hotRow = -1
End Sub

Public Sub ToggleGridOnOff()
    Scm.bShowGrid = Not Scm.bShowGrid
End Sub

Public Sub ToggleRulesOnOff()
    Scm.bShowRules = Not Scm.bShowRules
End Sub

Public Sub BeginDrag(keys As Integer, xp As Long, yp As Long)
    lastLeft = Scm.offsetX
    lastTop = Scm.offsetY
    dragX = xp
    dragY = yp
End Sub

Public Sub Drag(keys As Integer, xp As Long, yp As Long)
    Scm.offsetX = lastLeft + (xp - dragX)
    Scm.offsetY = lastTop + (yp - dragY)
End Sub

Public Sub EndDrag(keys As Integer, xp As Long, yp As Long)
End Sub

Public Sub IncrementScale(val As Double, keys As Integer)
    If keys And MK_CONTROL <> 0 Then
        val = val * cdScaleMul2
    Else
        val = val * cdScaleMul
    End If
    
    Scm.dScale = Scm.dScale + val
    
    If Scm.dScale < cdMinScale Then Scm.dScale = cdMinScale Else If Scm.dScale > cdMaxScale Then Scm.dScale = cdMaxScale
End Sub

Public Sub SetMousePointer()
    SetCursor Cursor(ciCross)
End Sub

Public Sub IncrementMiceMode(ByVal bshift As Integer)
    If bshift <> 0 Then
        Scm.bShowMiceLines = Not Scm.bShowMiceLines
    Else
        If Scm.bShowMiceLines = True Then
            Scm.MiceLineMode = Scm.MiceLineMode + 1
            If Scm.MiceLineMode < 0 Then Scm.MiceLineMode = MaxMiceLineMode - 1
            If Scm.MiceLineMode > MaxMiceLineMode - 1 Then Scm.MiceLineMode = 0
        End If
    End If
End Sub

Public Function GetScale() As Double
    GetScale = Scm.dScale
End Function

Public Sub Clear()
    Scm.Cols = UBound(Item, 2)
    Scm.Rows = UBound(Item, 1)

    Dim row As Long, col As Long
    For row = 0 To Scm.Rows
        For col = 0 To Scm.Cols
            Item(row, col) = ZeroCell
        Next col
    Next row
End Sub

Private Sub ReAlloc(cn As Long, rn As Long)
    ReDim Preserve Item(0 To rn, 0 To cn) As CellDesc
    
    Scm.Cols = UBound(Item, 2)
    Scm.Rows = UBound(Item, 1)
End Sub

Private Sub Alloc(cn As Long, rn As Long)
    ReDim Item(0 To rn, 0 To cn) As CellDesc
    
    Scm.Cols = UBound(Item, 2)
    Scm.Rows = UBound(Item, 1)
End Sub

Public Function GetActualFileExt() As String
    GetActualFileExt = ".scheme." + CStr(Scm.Cols) + "x" + CStr(Scm.Rows) + ".udscheme"
End Function

Private Function CheckFileHeader(ByRef tempScm As ScmHead) As Integer
    Dim i As Integer
    
    For i = 1 To UBound(tempScm.Sign)
        If tempScm.Sign(i) <> Scm.Sign(i) Then
            CheckFileHeader = 0
            Exit Function
        End If
    Next i
    
    CheckFileHeader = 1
End Function

Private Function CheckFileVersion(ByRef tempScm As ScmHead) As Integer
    Dim i As Integer
    
    For i = 1 To UBound(tempScm.Version)
        If tempScm.Version(i) <> Scm.Version(i) Then
            CheckFileVersion = 0
            Exit Function
        End If
    Next i
    
    CheckFileVersion = 1
End Function

Public Function LoadScheme(fName As String) As Integer
    On Error GoTo IOErr
    Dim hr As Long
    
    Dim secAttr As SECURITY_ATTRIBUTES
    secAttr = CreateEmptySECURITY_ATTRIBUTES()
   
    Dim hScheme As Long
    hScheme = CreateFileA(fName, GENERIC_READ, FILE_SHARE_READ, secAttr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
    hr = GetLastError()
    If hScheme = INVALID_HANDLE_VALUE Then
        Err.Raise hr
    End If
    
    Dim tempScm As ScmHead
    Dim fileSize As Long, fileSizeHigh As Long
    
    fileSize = GetFileSize(hScheme, fileSizeHigh)
    If fileSize < Len(tempScm) Then
        CloseHandle hScheme
        StatusText = "`" + fName + "`" + vbCrLf + " invalid file size (" + CStr(fileSize) + ")"
        Debug.Print StatusText
        LoadScheme = IOErrInvalidFile
        Exit Function
    End If
    
    Dim read As Long
    ReadFile hScheme, VarPtr(tempScm), Len(tempScm), read, 0
    If read <> Len(tempScm) Then Err.Raise GetLastError()
    
    If CheckFileHeader(tempScm) <> 1 Then
        CloseHandle hScheme
        StatusText = "`" + fName + "`" + vbCrLf + " file has wrong signature (" + BytesToPlaneString(tempScm.Sign, 1, 4) + ")"
        Debug.Print StatusText
        LoadScheme = IOErrWrongSignature
        Exit Function
    Else
        If CheckFileVersion(tempScm) <> 1 Then
            CloseHandle hScheme
            
            StatusText = "`" + fName + "`" + vbCrLf _
                       + " incompatible version (" + BytesToPlaneString(tempScm.Version, 1, 4) + ")" + vbCrLf _
                       + "v" + BytesToPlaneString(Scm.Version, 1, 4) + " required "
                       
            Debug.Print StatusText
            LoadScheme = IOErrVersionMismatch
            Exit Function
        Else
            Alloc tempScm.Cols, tempScm.Rows
            
            Dim itemsLen As Long
            itemsLen = Len(Item(0, 0)) * Scm.Cols * Scm.Rows
            ReadFile hScheme, VarPtr(Item(0, 0)), itemsLen, read, 0
            If read <> itemsLen Then
                Clear
                Err.Raise GetLastError()
            End If
            
            Scm = tempScm
        End If
    End If
    
    CloseHandle hScheme
    LoadScheme = IOErrOK
    Exit Function
IOErr:
    CloseHandle hScheme
    
    StatusText = "LoadScheme failed: " + CStr(Err.Number) + " `" + fName + "` " + vbCrLf + Err.Description
    Debug.Print StatusText
    
    LoadScheme = IOErrSystem
End Function

Public Function SaveScheme(fName As String) As Integer
    On Error GoTo IOErr
    
    Dim secAttr As SECURITY_ATTRIBUTES
    secAttr = CreateEmptySECURITY_ATTRIBUTES()
   
    Dim hScheme As Long
    hScheme = CreateFileA(fName, GENERIC_WRITE, FILE_SHARE_READ, secAttr, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0)
    If hScheme = INVALID_HANDLE_VALUE Then Err.Raise GetLastError()
    
    Dim written As Long
    WriteFile hScheme, VarPtr(Scm), Len(Scm), written, 0
    If written <> Len(Scm) Then Err.Raise GetLastError()
    
    Dim itemsLen As Long
    itemsLen = Len(Item(0, 0)) * Scm.Cols * Scm.Rows
    
    WriteFile hScheme, VarPtr(Item(0, 0)), itemsLen, written, 0
    If written <> itemsLen Then Err.Raise GetLastError()
    
    CloseHandle hScheme
    
    SaveScheme = IOErrOK
    Exit Function
IOErr:
    CloseHandle hScheme
    
    StatusText = "SaveScheme failed: " + CStr(Err.Number) + " `" + fName + "` " + vbCrLf + Err.Description
    Debug.Print StatusText

    SaveScheme = IOErrSystem
End Function

Private Sub CalcItemRect()
    With Scm.rcItem
        .Left = 0
        .Top = 0
        .Width = clItemCx * Scm.dScale
        .Height = clItemCy * Scm.dScale
    End With
End Sub

Private Sub CalcAllRect()
    With Scm.rcAll
        .Width = Scm.Cols * Scm.rcItem.Width
        .Height = Scm.Rows * Scm.rcItem.Height
        .Left = Scm.offsetX + Scm.rcDisplay.Left + (Scm.rcDisplay.Width - .Width) \ 2
        .Top = Scm.offsetY + Scm.rcDisplay.Top + (Scm.rcDisplay.Height - .Height) \ 2
    End With
End Sub

Private Function CalcVisibleStuff(ByRef count As Long, maxCount As Long _
                                , iw As Long _
                                , x1 As Long, w1 As Long _
                                , x2 As Long, w2 As Long _
                                ) As Long
    Dim rv As Long
    
    rv = ((x2 - x1) \ iw) - 1
    count = (w2 \ iw) + 2
    count = count + rv
    
    If count > maxCount Then count = maxCount
    If rv < 0 Then rv = 0
   
    CalcVisibleStuff = rv
End Function

Private Sub CalcVisibleIndexes()
    Scm.vCol = CalcVisibleStuff(Scm.vColNum, Scm.Cols, Scm.rcItem.Width, Scm.rcAll.Left, Scm.rcAll.Width, Scm.rcDisplay.Left, Scm.rcDisplay.Width)
    Scm.vRow = CalcVisibleStuff(Scm.vRowNum, Scm.Rows, Scm.rcItem.Height, Scm.rcAll.Top, Scm.rcAll.Height, Scm.rcDisplay.Top, Scm.rcDisplay.Height)
    
    StatusText = "<" + CStr(Scm.vCol) + "-" + CStr(Scm.vColNum) + "  " + CStr(Scm.vRow) + "-" + CStr(Scm.vRowNum) + ">"
End Sub

Private Sub CalcLimits()
    Scm.begY = Scm.rcAll.Top
    Scm.endY = RBottom(Scm.rcAll)
   
    Scm.begX = Scm.rcAll.Left
    Scm.endX = RRight(Scm.rcAll)
End Sub

Public Sub DrawGrid(ByVal dc As Long)
    On Error Resume Next
    
    Dim lastPen As Long
    Dim row As Long, col As Long
    Dim y As Long
    
    lastPen = SelectObject(dc, penGrid)
    
    If Scm.begY >= Scm.rcDisplay.Top Then ALine dc, Scm.begX, Scm.begY, Scm.endX, Scm.begY
    
    For row = Scm.vRow To Scm.vRowNum - 1
        y = Scm.rcAll.Top + (row * Scm.rcItem.Height) + Scm.rcItem.Height

        If y >= Scm.rcDisplay.Top Then
            ALine dc, Scm.begX, y, Scm.endX, y
        End If
    Next row
    
    If Scm.begX >= Scm.rcDisplay.Left Then ALine dc, Scm.begX, Scm.begY, Scm.begX, Scm.endY
    
    For col = Scm.vCol To Scm.vColNum - 1
        y = Scm.rcAll.Left + (col * Scm.rcItem.Width) + Scm.rcItem.Width
        If y >= Scm.rcDisplay.Left Then
            ALine dc, y, Scm.begY, y, Scm.endY
        End If
    Next col
    
    SelectObject dc, lastPen
End Sub

Private Sub DrawRules(ByVal dc As Long)
    On Error Resume Next
    
    Dim lastPen As Long
    Dim y As Long
    Dim i As Long
    Dim rcHRule As RECT
    Dim rcVRule As RECT
    Dim rcText As RECT
    Dim text As String
    
    With rcHRule
        .Left = Scm.rcDisplay.Left - clRuleCx
        .Top = Scm.rcDisplay.Top - clRuleCy
        .Right = .Left + Scm.rcDisplay.Width + clRuleCx
        .Bottom = .Top + clRuleCy
    End With
    
    With rcVRule
        .Left = Scm.rcDisplay.Left - clRuleCx
        .Top = Scm.rcDisplay.Top
        .Right = .Left + clRuleCx
        .Bottom = .Top + Scm.rcDisplay.Height
    End With
    
    FillSolidRect dc, rcHRule, DocRuleBgColor
    FillSolidRect dc, rcVRule, DocRuleBgColor
    
    lastPen = SelectObject(dc, penRulesMark)
    
    For i = Scm.vCol To Scm.vColNum
        y = Scm.rcAll.Left + (i * Scm.rcItem.Width)

        If y >= Scm.rcDisplay.Left Then
            ALine dc, y, rcHRule.Top, y, rcHRule.Top + clRuleCy - 4

#If DrawTextOnRules Then
            If i <> Scm.vColNum Then
                With rcText
                    .Left = y + 1
                    .Top = rcHRule.Top + 1
                    .Right = .Left + Scm.rcItem.Width - 2
                    .Bottom = rcHRule.Bottom - 2
                End With

                text = CStr(i)
                DrawTextA dc, text, Len(text), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
            End If
#End If
        End If
    Next i
    
    For i = Scm.vRow To Scm.vRowNum
        y = Scm.rcAll.Top + (i * Scm.rcItem.Height)

        If y >= Scm.rcDisplay.Top Then
            ALine dc, rcVRule.Left, y, rcVRule.Left + clRuleCx - 4, y

#If DrawTextOnRules Then
            If i <> Scm.vRowNum Then
                With rcText
                    .Left = rcVRule.Left + 1
                    .Top = y + 1
                    .Right = rcVRule.Right - 2
                    .Bottom = .Top + Scm.rcItem.Height
                End With

                text = CStr(i)
                DrawTextA dc, text, Len(text), rcText, DT_CENTER + DT_VCENTER + DT_SINGLELINE
            End If
#End If
        End If
    Next i
    
    lastPen = SelectObject(dc, penRulesLine)
    
    ALine dc, rcHRule.Left, rcHRule.Bottom, rcHRule.Right, rcHRule.Bottom
    ALine dc, rcVRule.Right, rcVRule.Top, rcVRule.Right, rcVRule.Bottom
    
    lastPen = SelectObject(dc, penGrid)
    
    ALine dc, Scm.rcAll.Left + (Scm.vCol * Scm.rcItem.Width), rcHRule.Top, Scm.rcAll.Left + ((Scm.vCol + Scm.vColNum) * Scm.rcItem.Width), rcHRule.Top
    ALine dc, rcVRule.Left, Scm.rcAll.Top + (Scm.vRow * Scm.rcItem.Height) _
            , rcVRule.Left, Scm.rcAll.Top + ((Scm.vRow + Scm.vRowNum) * Scm.rcItem.Height)
    
    SelectObject dc, lastPen
End Sub

Private Sub DrawFullMiceLines(ByVal dc As Long, ByRef mp As APOINT)
    ALine dc, mp.x, Scm.rcDisplay.Top, mp.x, RBottom(Scm.rcDisplay)
    ALine dc, Scm.rcDisplay.Left, mp.y, RRight(Scm.rcDisplay), mp.y
End Sub

Private Sub DrawHalfMiceLines(ByVal dc As Long, ByRef mp As APOINT)
    ALine dc, mp.x, Scm.rcDisplay.Top, mp.x, mp.y
    ALine dc, Scm.rcDisplay.Left, mp.y, mp.x, mp.y
End Sub

Public Function GetIndexFromPoint(ByVal x As Long, ByVal y As Long, ByRef row As Long) As Long
    On Error Resume Next
    Dim col As Long
    
    col = (x - Scm.rcAll.Left) \ Scm.rcItem.Width
    row = (y - Scm.rcAll.Top) \ Scm.rcItem.Height
    
    GetIndexFromPoint = col
End Function

Private Sub DrawMiceCoords(ByVal dc As Long, ByRef mp As APOINT)
    Dim rcText As RECT
    Dim text As String
    Dim row As Long, col As Long, lastTextColor As Long
    
    With rcText
        .Left = mp.x + 2
        .Top = mp.y + 2
        .Right = .Left + (clRuleCx * 3)
        .Bottom = .Top + (clRuleCy + 3)
    End With
    
    col = GetIndexFromPoint(mp.x, mp.y, row)
   
    FillSolidRect dc, rcText, DocCoordHintBgColor

    text = "[" + CStr(col) + ", " + CStr(row) + "]"
    lastTextColor = SetTextColor(dc, DocCoordHintFgColor)
    DrawTextA dc, text, Len(text), rcText, DT_CENTER + DT_VCENTER + DT_SINGLELINE
    SetTextColor dc, lastTextColor
End Sub

Public Sub DrawMiceLines(ByVal dc As Long, ByVal hWnd As Long)
    Dim mp As APOINT
    If GetCursorPos(mp) <> 0 Then
        Dim lastPen As Long, lastFont As Long
        
        ScreenToClient hWnd, mp

        lastPen = SelectObject(dc, penMiceLine)
        
        Select Case Scm.MiceLineMode
        Case 0
            DrawFullMiceLines dc, mp
        Case 1
            DrawHalfMiceLines dc, mp
        Case 2
            DrawFullMiceLines dc, mp
            DrawMiceCoords dc, mp
        Case 3
            DrawHalfMiceLines dc, mp
            DrawMiceCoords dc, mp
        End Select
        
        SelectObject dc, lastPen
    End If
End Sub

Public Sub DrawHot(ByVal dc As Long)
    If Scm.hotCol >= 0 And Scm.hotRow >= 0 And Scm.hotCol < Scm.Cols And Scm.hotRow < Scm.Rows Then
        Dim rcHot As RECT

        With rcHot
            .Left = Scm.rcAll.Left + (Scm.hotCol * Scm.rcItem.Width)
            .Top = Scm.rcAll.Top + (Scm.hotRow * Scm.rcItem.Height)
            .Right = .Left + Scm.rcItem.Width
            .Bottom = .Top + Scm.rcItem.Height
        End With

        FillSolidRect dc, rcHot, DocHotBgColor
    End If
End Sub

Public Sub HighlightByCoords(x As Long, y As Long)
    On Error Resume Next
    
    Dim row As Long, col As Long
    col = GetIndexFromPoint(x, y, row)
    
    Scm.hotCol = col
    Scm.hotRow = row
End Sub

Public Sub Draw(ByVal dc As Long, ByVal hWnd As Long, x As Long, y As Long, cx As Long, cy As Long)
    On Error Resume Next
    
    If Scm.bShowRules = True Then
        Scm.rcDisplay = RInit(x + clRuleCx, y + clRuleCy, cx - clRuleCx, cy - clRuleCy)
    Else
        Scm.rcDisplay = RInit(x, y, cx, cy)
    End If
    
    CalcItemRect
    CalcAllRect
    CalcVisibleIndexes
    CalcLimits
    
    DrawHot dc
    
    Dim lastBkMode As Long, lastTextColor As Long
    lastBkMode = SetBkMode(dc, TRANSPARENT)
    lastTextColor = SetTextColor(dc, DocFgColor)
    
    Dim row As Long, col As Long, lastFont As Long, lastPen As Long, lastBrush As Long
    
    lastFont = SelectObject(dc, fontCell)
    lastPen = SelectObject(dc, penCell)
    lastBrush = SelectObject(dc, brushCell)
    
    For row = Scm.vRow To Scm.vRowNum - 1
        Scm.rcItem.Top = Scm.rcAll.Top + (row * Scm.rcItem.Height)
        For col = Scm.vCol To Scm.vColNum - 1
            Scm.rcItem.Left = Scm.rcAll.Left + (col * Scm.rcItem.Width)
            DrawCell Item(col, row), dc, Scm.rcItem.Left, Scm.rcItem.Top, Scm.rcItem.Width, Scm.rcItem.Height
            
#If DrawCellCoordText Then
            Dim itemText As String
            itemText = "(" + CStr(col) + ", " + CStr(row) + ")"
            Dim rcTemp As RECT
            rcTemp = ToRECT(rcItem)
            Dim rcText As RECT
            rcText = rcTemp
            DrawTextA dc, itemText, Len(itemText), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
#End If
        Next col
    Next row

    SelectObject dc, lastBrush
    SelectObject dc, lastPen
    SelectObject dc, lastFont

    lastFont = SelectObject(dc, fontHelpers)

    If Scm.bShowGrid = True Then DrawGrid dc
    If Scm.bShowRules = True Then DrawRules dc
    If Scm.bShowMiceLines = True Then DrawMiceLines dc, hWnd
    
    SelectObject dc, lastFont

    SetTextColor dc, lastTextColor
    SetBkMode dc, lastBkMode
End Sub

