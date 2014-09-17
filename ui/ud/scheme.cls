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
    mmLinesFull = 0
    mmLinesHalf
    mmLinesFullCoords
    mmLinesHalfCoords
    mmCount
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
Private Const cdScaleMul As Double = 0.05
Private Const cdScaleMul2 As Double = 0.5

Private Const clRuleCx As Long = 8
Private Const clRuleCy As Long = 7
Private Const clRuleCx2 As Long = clRuleCx \ 2
Private Const clRuleCy2 As Long = clRuleCy \ 2

Private scm As ScmHead
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
    scm.Sign(1) = Asc("W")
    scm.Sign(2) = Asc("C")
    scm.Sign(3) = Asc("D")
    scm.Sign(4) = Asc("X")
    scm.Version(1) = 1
    scm.Version(2) = 0
    scm.Version(3) = 0
    scm.Version(4) = 0
    scm.lReserver = &HEEEEEE0E
    scm.Reserved(UBound(scm.Reserved)) = Asc("Z")
    
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

    Call ResetView(True, True)
    
    scm.bShowGrid = True
    scm.bShowRules = True
    scm.bShowMiceLines = True
    scm.MiceLineMode = mmLinesFull
    
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

Public Sub ResetView(ByVal bResetOffset As Boolean, Optional ByVal bResetHot As Boolean = False)
    scm.dScale = 1#
    
    If bResetOffset Then
        scm.offsetX = 0
        scm.offsetY = 0
    End If
    
    If bResetHot Then
        scm.hotCol = -1
        scm.hotRow = -1
    End If
End Sub

Public Sub ToggleGridOnOff()
    scm.bShowGrid = Not scm.bShowGrid
End Sub

Public Sub ToggleRulesOnOff()
    scm.bShowRules = Not scm.bShowRules
End Sub

Public Sub BeginDrag(iKey As Integer, xp As Long, yp As Long)
    lastLeft = scm.offsetX
    lastTop = scm.offsetY
    dragX = xp
    dragY = yp
End Sub

Public Sub Drag(iKey As Integer, xp As Long, yp As Long)
    scm.offsetX = lastLeft + (xp - dragX)
    scm.offsetY = lastTop + (yp - dragY)
End Sub

Public Sub EndDrag(iKey As Integer, xp As Long, yp As Long)
End Sub

Public Sub IncrementScale(dAmount As Double, iKey As Integer)
    If (iKey And MK_CONTROL) <> 0 Then
        dAmount = dAmount * cdScaleMul2
    Else
        dAmount = dAmount * cdScaleMul
    End If
    
    scm.dScale = scm.dScale + dAmount
    
    If scm.dScale < cdMinScale Then scm.dScale = cdMinScale Else If scm.dScale > cdMaxScale Then scm.dScale = cdMaxScale
End Sub

Public Sub SetMousePointer()
    SetCursor Cursor(ciCross)
End Sub

Public Sub IncrementMiceMode(ByVal bshift As Integer)
    If bshift <> 0 Then
        scm.bShowMiceLines = Not scm.bShowMiceLines
    Else
        If scm.bShowMiceLines = True Then
            scm.MiceLineMode = scm.MiceLineMode + 1
            If scm.MiceLineMode < 0 Then scm.MiceLineMode = mmCount - 1
            If scm.MiceLineMode > mmCount - 1 Then scm.MiceLineMode = 0
        End If
    End If
End Sub

Public Function GetScale() As Double
    GetScale = scm.dScale
End Function

Public Sub Clear()
    scm.Cols = UBound(Item, 2)
    scm.Rows = UBound(Item, 1)

    Dim row As Long, col As Long
    For row = 0 To scm.Rows
        For col = 0 To scm.Cols
            Item(row, col) = ZeroCell
        Next col
    Next row
End Sub

Private Sub ReAlloc(cn As Long, rn As Long)
    ReDim Preserve Item(0 To rn, 0 To cn) As CellDesc
    
    scm.Cols = UBound(Item, 2)
    scm.Rows = UBound(Item, 1)
End Sub

Private Sub Alloc(cn As Long, rn As Long)
    ReDim Item(0 To rn, 0 To cn) As CellDesc
    
    scm.Cols = UBound(Item, 2)
    scm.Rows = UBound(Item, 1)
End Sub

Public Function GetActualFileExt() As String
    GetActualFileExt = ".scheme." + CStr(scm.Cols) + "x" + CStr(scm.Rows) + ".udscheme"
End Function

Private Function CheckFileHeader(ByRef tempScm As ScmHead) As Integer
    Dim i As Integer
    
    For i = 1 To UBound(tempScm.Sign)
        If tempScm.Sign(i) <> scm.Sign(i) Then
            CheckFileHeader = 0
            Exit Function
        End If
    Next i
    
    CheckFileHeader = 1
End Function

Private Function CheckFileVersion(ByRef tempScm As ScmHead) As Integer
    Dim i As Integer
    
    For i = 1 To UBound(tempScm.Version)
        If tempScm.Version(i) <> scm.Version(i) Then
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
                       + "v" + BytesToPlaneString(scm.Version, 1, 4) + " required "
                       
            Debug.Print StatusText
            LoadScheme = IOErrVersionMismatch
            Exit Function
        Else
            Alloc tempScm.Cols, tempScm.Rows
            
            Dim itemsLen As Long
            itemsLen = Len(Item(0, 0)) * scm.Cols * scm.Rows
            ReadFile hScheme, VarPtr(Item(0, 0)), itemsLen, read, 0
            If read <> itemsLen Then
                Clear
                Err.Raise GetLastError()
            End If
            
            scm = tempScm
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
    WriteFile hScheme, VarPtr(scm), Len(scm), written, 0
    If written <> Len(scm) Then Err.Raise GetLastError()
    
    Dim itemsLen As Long
    itemsLen = Len(Item(0, 0)) * scm.Cols * scm.Rows
    
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
    With scm.rcItem
        .Left = 0
        .Top = 0
        .Width = clItemCx * scm.dScale
        .Height = clItemCy * scm.dScale
    End With
End Sub

Private Sub CalcAllRect()
    With scm.rcAll
        .Width = scm.Cols * scm.rcItem.Width
        .Height = scm.Rows * scm.rcItem.Height
        .Left = scm.offsetX + scm.rcDisplay.Left + (scm.rcDisplay.Width - .Width) \ 2
        .Top = scm.offsetY + scm.rcDisplay.Top + (scm.rcDisplay.Height - .Height) \ 2
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
    scm.vCol = CalcVisibleStuff(scm.vColNum, scm.Cols, scm.rcItem.Width, scm.rcAll.Left, scm.rcAll.Width, scm.rcDisplay.Left, scm.rcDisplay.Width)
    scm.vRow = CalcVisibleStuff(scm.vRowNum, scm.Rows, scm.rcItem.Height, scm.rcAll.Top, scm.rcAll.Height, scm.rcDisplay.Top, scm.rcDisplay.Height)
    
    StatusText = "<" + CStr(scm.vCol) + "-" + CStr(scm.vColNum) + "  " + CStr(scm.vRow) + "-" + CStr(scm.vRowNum) + ">"
End Sub

Private Sub CalcLimits()
    scm.begY = scm.rcAll.Top
    scm.endY = RBottom(scm.rcAll)
   
    scm.begX = scm.rcAll.Left
    scm.endX = RRight(scm.rcAll)
End Sub

Public Sub DrawGrid(ByVal dc As Long)
    On Error Resume Next
    
    Dim lastPen As Long
    Dim row As Long, col As Long
    Dim y As Long
    
    lastPen = SelectObject(dc, penGrid)
    
    If scm.begY >= scm.rcDisplay.Top Then ALine dc, scm.begX, scm.begY, scm.endX, scm.begY
    
    For row = scm.vRow To scm.vRowNum - 1
        y = scm.rcAll.Top + (row * scm.rcItem.Height) + scm.rcItem.Height

        If y >= scm.rcDisplay.Top Then
            ALine dc, scm.begX, y, scm.endX, y
        End If
    Next row
    
    If scm.begX >= scm.rcDisplay.Left Then ALine dc, scm.begX, scm.begY, scm.begX, scm.endY
    
    For col = scm.vCol To scm.vColNum - 1
        y = scm.rcAll.Left + (col * scm.rcItem.Width) + scm.rcItem.Width
        If y >= scm.rcDisplay.Left Then
            ALine dc, y, scm.begY, y, scm.endY
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
        .Left = scm.rcDisplay.Left - clRuleCx
        .Top = scm.rcDisplay.Top - clRuleCy
        .Right = .Left + scm.rcDisplay.Width + clRuleCx
        .Bottom = .Top + clRuleCy
    End With
    
    With rcVRule
        .Left = scm.rcDisplay.Left - clRuleCx
        .Top = scm.rcDisplay.Top
        .Right = .Left + clRuleCx
        .Bottom = .Top + scm.rcDisplay.Height
    End With
    
    FillSolidRect dc, rcHRule, DocRuleBgColor
    FillSolidRect dc, rcVRule, DocRuleBgColor
    
    lastPen = SelectObject(dc, penRulesMark)
    
    For i = scm.vCol To scm.vColNum
        y = scm.rcAll.Left + (i * scm.rcItem.Width)

        If y >= scm.rcDisplay.Left Then
            ALine dc, y, rcHRule.Top, y, rcHRule.Top + clRuleCy - 4

#If DrawTextOnRules Then
            If i <> scm.vColNum Then
                With rcText
                    .Left = y + 1
                    .Top = rcHRule.Top + 1
                    .Right = .Left + scm.rcItem.Width - 2
                    .Bottom = rcHRule.Bottom - 2
                End With

                text = CStr(i)
                DrawTextA dc, text, Len(text), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
            End If
#End If
        End If
    Next i
    
    For i = scm.vRow To scm.vRowNum
        y = scm.rcAll.Top + (i * scm.rcItem.Height)

        If y >= scm.rcDisplay.Top Then
            ALine dc, rcVRule.Left, y, rcVRule.Left + clRuleCx - 4, y

#If DrawTextOnRules Then
            If i <> scm.vRowNum Then
                With rcText
                    .Left = rcVRule.Left + 1
                    .Top = y + 1
                    .Right = rcVRule.Right - 2
                    .Bottom = .Top + scm.rcItem.Height
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
    
    Call ALine(dc, scm.rcAll.Left + (scm.vCol * scm.rcItem.Width), rcHRule.Top, scm.rcAll.Left + ((scm.vCol + scm.vColNum) * scm.rcItem.Width), rcHRule.Top)
    Call ALine(dc, rcVRule.Left, scm.rcAll.Top + (scm.vRow * scm.rcItem.Height) _
                 , rcVRule.Left, scm.rcAll.Top + ((scm.vRow + scm.vRowNum) * scm.rcItem.Height))
    
    Call SelectObject(dc, lastPen)
End Sub

Private Sub DrawFullMiceLines(ByVal dc As Long, ByRef mp As APOINT)
    Call ALine(dc, mp.x, scm.rcDisplay.Top, mp.x, RBottom(scm.rcDisplay))
    Call ALine(dc, scm.rcDisplay.Left, mp.y, RRight(scm.rcDisplay), mp.y)
End Sub

Private Sub DrawHalfMiceLines(ByVal dc As Long, ByRef mp As APOINT)
    Call ALine(dc, mp.x, scm.rcDisplay.Top, mp.x, mp.y)
    Call ALine(dc, scm.rcDisplay.Left, mp.y, mp.x, mp.y)
End Sub

Public Function GetIndexFromPoint(ByVal x As Long, ByVal y As Long, ByRef row As Long) As Long
    On Error Resume Next
    Dim col As Long
    
    col = (x - scm.rcAll.Left) \ scm.rcItem.Width
    row = (y - scm.rcAll.Top) \ scm.rcItem.Height
    
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
   
    Call FillSolidRect(dc, rcText, DocCoordHintBgColor)

    text = "[" + CStr(col) + ", " + CStr(row) + "]"
    lastTextColor = SetTextColor(dc, DocCoordHintFgColor)
    Call DrawTextA(dc, text, Len(text), rcText, DT_CENTER + DT_VCENTER + DT_SINGLELINE)
    Call SetTextColor(dc, lastTextColor)
End Sub

Public Sub DrawMiceLines(ByVal dc As Long, ByVal hWnd As Long)
    Dim mp As APOINT
    If GetCursorPos(mp) <> 0 Then
        Dim lastPen As Long, lastFont As Long
        
        Call ScreenToClient(hWnd, mp)

        lastPen = SelectObject(dc, penMiceLine)
        
        Select Case scm.MiceLineMode
        Case mmLinesFull
            Call DrawFullMiceLines(dc, mp)
        Case mmLinesHalf
            Call DrawHalfMiceLines(dc, mp)
        Case mmLinesFullCoords
            Call DrawFullMiceLines(dc, mp)
            Call DrawMiceCoords(dc, mp)
        Case mmLinesHalfCoords
            Call DrawHalfMiceLines(dc, mp)
            Call DrawMiceCoords(dc, mp)
        End Select
        
        Call SelectObject(dc, lastPen)
    End If
End Sub

Public Function IsIndexValid(ByVal lCol As Long, ByVal lRow As Long) As Boolean
    IsIndexValid = (lCol >= 0) And (lRow >= 0) And (lCol < scm.Cols) And (lRow < scm.Rows)
End Function

Public Sub DrawHot(ByVal dc As Long)
    If IsIndexValid(scm.hotCol, scm.hotRow) Then
        Dim rcHot As RECT

        With rcHot
            .Left = scm.rcAll.Left + (scm.hotCol * scm.rcItem.Width)
            .Top = scm.rcAll.Top + (scm.hotRow * scm.rcItem.Height)
            .Right = .Left + scm.rcItem.Width
            .Bottom = .Top + scm.rcItem.Height
        End With

        'Call FillSolidRect(dc, rcHot, DocHotBgColor)
        Call InvertRect(dc, rcHot)
    End If
End Sub

Public Sub HighlightByCoords(x As Long, y As Long)
    On Error Resume Next
    
    Dim row As Long, col As Long
    col = GetIndexFromPoint(x, y, row)
    
    scm.hotCol = col
    scm.hotRow = row
End Sub

Public Sub Draw(ByVal dc As Long, ByVal hWnd As Long, x As Long, y As Long, cx As Long, cy As Long, ByRef pTool As ITool)
    On Error Resume Next
    
    If scm.bShowRules = True Then
        scm.rcDisplay = RInit(x + clRuleCx, y + clRuleCy, cx - clRuleCx, cy - clRuleCy)
    Else
        scm.rcDisplay = RInit(x, y, cx, cy)
    End If
    
    Call CalcItemRect
    Call CalcAllRect
    Call CalcVisibleIndexes
    Call CalcLimits
    
    Dim lastBkMode As Long, lastTextColor As Long
    lastBkMode = SetBkMode(dc, TRANSPARENT)
    lastTextColor = SetTextColor(dc, DocFgColor)
    
    Dim row As Long, col As Long, lastFont As Long, lastPen As Long, lastBrush As Long
    
    lastFont = SelectObject(dc, fontCell)
    lastPen = SelectObject(dc, penCell)
    lastBrush = SelectObject(dc, brushCell)
    
    For row = scm.vRow To scm.vRowNum - 1
        scm.rcItem.Top = scm.rcAll.Top + (row * scm.rcItem.Height)
        For col = scm.vCol To scm.vColNum - 1
            scm.rcItem.Left = scm.rcAll.Left + (col * scm.rcItem.Width)
            Call DrawCell(Item(col, row), dc, scm.rcItem.Left, scm.rcItem.Top, scm.rcItem.Width, scm.rcItem.Height)
            
#If DrawCellCoordText Then
            Dim itemText As String
            itemText = "(" + CStr(col) + ", " + CStr(row) + ")"
            Dim rcTemp As RECT
            rcTemp = ToRECT(rcItem)
            Dim rcText As RECT
            rcText = rcTemp
            Call DrawTextA(dc, itemText, Len(itemText), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE)
#End If
        Next col
    Next row
    
    If pTool.InProgress() Then
        Call pTool.OnDraw(dc, Me)
    End If

    Call SelectObject(dc, lastBrush)
    Call SelectObject(dc, lastPen)
    Call SelectObject(dc, lastFont)

    lastFont = SelectObject(dc, fontHelpers)

    If scm.bShowGrid = True Then Call DrawGrid(dc)
    If scm.bShowRules = True Then Call DrawRules(dc)
    If scm.bShowMiceLines = True Then Call DrawMiceLines(dc, hWnd)
    
    Call SelectObject(dc, lastFont)

    Call SetTextColor(dc, lastTextColor)
    Call SetBkMode(dc, lastBkMode)

    Call DrawHot(dc)
End Sub

Public Sub ConnectByWyre(ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long)
End Sub
