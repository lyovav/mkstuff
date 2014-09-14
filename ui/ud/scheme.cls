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

Private Const DefItemWidth As Long = 32
Private Const DefItemHeight As Long = 24
Private Const DefItemCols As Long = 32
Private Const DefItemRows As Long = 24

Private Const cdMinScale As Double = 0.01
Private Const cdMaxScale As Double = 40.96
Private Const cdScaleMul As Double = 0.02
Private Const cdScaleMul2 As Double = 0.5

Private Const ruleCx As Long = 16
Private Const ruleCy As Long = 16
Private Const ruleHalfCx As Long = ruleCx \ 2
Private Const ruleHalfCy As Long = ruleCy \ 2

Public DebugString As String

Private dScale As Double
Private Item() As Cell

Private bShowGrid As Boolean
Private bShowRules As Boolean
Private bShowMiceLines As Boolean
Private MiceLineMode As Integer
Private Cols As Long
Private Rows As Long
Private rcDisplay As CRect
Private rcAll As CRect
Private rcItem As CRect
Private vCol As Long
Private vColNum As Long
Private vRow As Long
Private vRowNum As Long
Private begY As Long
Private endY As Long
Private begX As Long
Private endX As Long
Private lastLeft As Long
Private lastTop As Long
Private dragX As Long
Private dragY As Long
Private offsetX As Long
Private offsetY As Long
Private hotCol As Long
Private hotRow As Long

' Appearance
Private penGrid As Long
Private penRulesLine As Long
Private penRulesMark As Long
Private fontHelpers As Long
Private penMiceLine As Long

Public Sub Class_Initialize()
    penGrid = CreatePen(DocGridPenStyle, 1, DocGridColor)
    penRulesLine = CreatePen(DocRulesPenStyle, 1, DocRulesColor)
    penRulesMark = CreatePen(DocRulesPenStyle, 2, DocRulesColor)
    penMiceLine = CreatePen(DocMiceLinePenStyle, 1, DocMiceLineColor)
    fontHelpers = CreateFontA(-9, 0, 0, 0, FW_NORMAL, False, False, False, 0, 0, 0, PROOF_QUALITY, 0, "Small fonts")

    ResetView
    
    bShowGrid = True
    bShowRules = True
    bShowMiceLines = True
    MiceLineMode = MiceLinesFull
    
    Allocate DefItemRows, DefItemCols
End Sub

Private Sub Class_Terminate()
    DeleteObject fontHelpers
    DeleteObject penMiceLine
    DeleteObject penRulesMark
    DeleteObject penRulesLine
    DeleteObject penGrid
End Sub

Public Sub ResetView()
    dScale = 1#
    offsetX = 0
    offsetY = 0
    hotCol = -1
    hotRow = -1
End Sub

Public Sub ToggleGridOnOff()
    bShowGrid = Not bShowGrid
End Sub

Public Sub ToggleRulesOnOff()
    bShowRules = Not bShowRules
End Sub

Public Sub BeginDrag(keys As Integer, xp As Long, yp As Long)
    lastLeft = offsetX
    lastTop = offsetY
    dragX = xp
    dragY = yp
End Sub

Public Sub Drag(keys As Integer, xp As Long, yp As Long)
    offsetX = lastLeft + (xp - dragX)
    offsetY = lastTop + (yp - dragY)
End Sub

Public Sub EndDrag(keys As Integer, xp As Long, yp As Long)
End Sub

Public Sub IncrementScale(val As Double, keys As Integer)
    If keys And MK_CONTROL <> 0 Then
        val = val * cdScaleMul2
    Else
        val = val * cdScaleMul
    End If
    
    dScale = dScale + val
    
    If dScale < cdMinScale Then dScale = cdMinScale Else If dScale > cdMaxScale Then dScale = cdMaxScale
End Sub

Public Sub IncrementMiceMode(ByVal bshift As Integer)
    If bshift <> 0 Then
        bShowMiceLines = Not bShowMiceLines
    Else
        If bShowMiceLines = True Then
            MiceLineMode = MiceLineMode + 1
            If MiceLineMode < 0 Then MiceLineMode = MaxMiceLineMode - 1
            If MiceLineMode > MaxMiceLineMode - 1 Then MiceLineMode = 0
        End If
    End If
End Sub

Public Function GetScale() As Double
    GetScale = dScale
End Function

Public Sub Allocate(cn As Long, rn As Long)
    ReDim Item(0 To cn, 0 To rn) As Cell
    
    Cols = UBound(Item, 2)
    Rows = UBound(Item, 1)

    Dim row As Long, col As Long
    For row = 0 To Rows
        For col = 0 To Cols
            Item(row, col) = ZeroCell
        Next col
    Next row
End Sub

Private Sub CalcItemRect()
    With rcItem
        .Left = 0
        .Top = 0
        .Width = DefItemWidth * dScale
        .Height = DefItemHeight * dScale
    End With
End Sub

Private Sub CalcAllRect()
    With rcAll
        .Width = Cols * rcItem.Width
        .Height = Rows * rcItem.Height
        .Left = offsetX + rcDisplay.Left + (rcDisplay.Width - .Width) \ 2
        .Top = offsetY + rcDisplay.Top + (rcDisplay.Height - .Height) \ 2
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
    vCol = CalcVisibleStuff(vColNum, Cols, rcItem.Width, rcAll.Left, rcAll.Width, rcDisplay.Left, rcDisplay.Width)
    vRow = CalcVisibleStuff(vRowNum, Rows, rcItem.Height, rcAll.Top, rcAll.Height, rcDisplay.Top, rcDisplay.Height)
    
    DebugString = "<" + CStr(vCol) + "-" + CStr(vColNum) + "  " + CStr(vRow) + "-" + CStr(vRowNum) + ">"
End Sub

Private Sub CalcLimits()
    begY = rcAll.Top
    endY = RBottom(rcAll)
   
    begX = rcAll.Left
    endX = RRight(rcAll)
End Sub

Public Sub DrawGrid(ByVal dc As Long)
    On Error Resume Next
    
    Dim lastPen As Long
    Dim row As Long, col As Long
    Dim y As Long
    
    lastPen = SelectObject(dc, penGrid)
    
    If begY >= rcDisplay.Top Then ALine dc, begX, begY, endX, begY
    
    For row = vRow To vRowNum - 1
        y = rcAll.Top + (row * rcItem.Height) + rcItem.Height
        
        If y >= rcDisplay.Top Then
            ALine dc, begX, y, endX, y
        End If
    Next row
    
    If begX >= rcDisplay.Left Then ALine dc, begX, begY, begX, endY
    
    For col = vCol To vColNum - 1
        y = rcAll.Left + (col * rcItem.Width) + rcItem.Width
        If y >= rcDisplay.Left Then
            ALine dc, y, begY, y, endY
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
        .Left = rcDisplay.Left - ruleCx
        .Top = rcDisplay.Top - ruleCy
        .Right = .Left + rcDisplay.Width + ruleCx
        .Bottom = .Top + ruleCy
    End With
    
    With rcVRule
        .Left = rcDisplay.Left - ruleCx
        .Top = rcDisplay.Top
        .Right = .Left + ruleCx
        .Bottom = .Top + rcDisplay.Height
    End With
    
    FillSolidRect dc, rcHRule, DocRuleBgColor
    FillSolidRect dc, rcVRule, DocRuleBgColor
    
    lastPen = SelectObject(dc, penRulesMark)
    
    For i = vCol To vColNum
        y = rcAll.Left + (i * rcItem.Width)
        
        If y >= rcDisplay.Left Then
            ALine dc, y, rcHRule.Top, y, rcHRule.Top + ruleCy - 4
            
            If i <> vColNum Then
                With rcText
                    .Left = y + 1
                    .Top = rcHRule.Top + 1
                    .Right = .Left + rcItem.Width - 2
                    .Bottom = rcHRule.Bottom - 2
                End With
                
                text = CStr(i)
                DrawTextA dc, text, Len(text), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
            End If
        End If
    Next i
    
    For i = vRow To vRowNum
        y = rcAll.Top + (i * rcItem.Height)
        
        If y >= rcDisplay.Top Then
            ALine dc, rcVRule.Left, y, rcVRule.Left + ruleCx - 4, y
            
            If i <> vRowNum Then
                With rcText
                    .Left = rcVRule.Left + 1
                    .Top = y + 1
                    .Right = rcVRule.Right - 2
                    .Bottom = .Top + rcItem.Height
                End With
                
                text = CStr(i)
                DrawTextA dc, text, Len(text), rcText, DT_CENTER + DT_VCENTER + DT_SINGLELINE
            End If
        End If
    Next i
    
    lastPen = SelectObject(dc, penRulesLine)
    
    ALine dc, rcHRule.Left, rcHRule.Bottom, rcHRule.Right, rcHRule.Bottom
    ALine dc, rcVRule.Right, rcVRule.Top, rcVRule.Right, rcVRule.Bottom
    
    lastPen = SelectObject(dc, penGrid)
    
    ALine dc, rcAll.Left + (vCol * rcItem.Width), rcHRule.Top, rcAll.Left + ((vCol + vColNum) * rcItem.Width), rcHRule.Top
    ALine dc, rcVRule.Left, rcAll.Top + (vRow * rcItem.Height), rcVRule.Left, rcAll.Top + ((vRow + vRowNum) * rcItem.Height)
    
    SelectObject dc, lastPen
End Sub

Private Sub DrawFullMiceLines(ByVal dc As Long, ByRef mp As APOINT)
    ALine dc, mp.x, rcDisplay.Top, mp.x, RBottom(rcDisplay)
    ALine dc, rcDisplay.Left, mp.y, RRight(rcDisplay), mp.y
End Sub

Private Sub DrawHalfMiceLines(ByVal dc As Long, ByRef mp As APOINT)
    ALine dc, mp.x, rcDisplay.Top, mp.x, mp.y
    ALine dc, rcDisplay.Left, mp.y, mp.x, mp.y
End Sub

Public Function GetIndexFromPoint(ByVal x As Long, ByVal y As Long, ByRef row As Long) As Long
    On Error Resume Next
    Dim col As Long
    
    col = (x - rcAll.Left) \ rcItem.Width
    row = (y - rcAll.Top) \ rcItem.Height
    
    GetIndexFromPoint = col
End Function

Private Sub DrawMiceCoords(ByVal dc As Long, ByRef mp As APOINT)
    Dim rcText As RECT
    Dim text As String
    Dim row As Long, col As Long, lastTextColor As Long
    
    With rcText
        .Left = mp.x + 2
        .Top = mp.y + 2
        .Right = .Left + (ruleCx * 3)
        .Bottom = .Top + (ruleCy + 3)
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
        
        Select Case MiceLineMode
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
    If hotCol >= 0 And hotRow >= 0 And hotCol < Cols And hotRow < Rows Then
        Dim rcHot As RECT
        
        With rcHot
            .Left = rcAll.Left + (hotCol * rcItem.Width)
            .Top = rcAll.Top + (hotRow * rcItem.Height)
            .Right = .Left + rcItem.Width
            .Bottom = .Top + rcItem.Height
        End With
        
        FillSolidRect dc, rcHot, DocHotBgColor
    End If
End Sub

Public Sub Draw(ByVal dc As Long, ByVal hWnd As Long, x As Long, y As Long, cx As Long, cy As Long)
    On Error Resume Next
    
    If bShowRules = True Then
        rcDisplay = RInit(x + ruleCx, y + ruleCy, cx - ruleCx, cy - ruleCy)
    Else
        rcDisplay = RInit(x, y, cx, cy)
    End If
    
    CalcItemRect
    CalcAllRect
    CalcVisibleIndexes
    CalcLimits
    
    DrawHot dc
    
    Dim lastBkMode As Long, lastTextColor As Long
    lastBkMode = SetBkMode(dc, TRANSPARENT)
    lastTextColor = SetTextColor(dc, DocFgColor)
    
#If False Then
    Dim row As Long, col As Long
    For row = vRow To vRowNum - 1
        rcItem.Top = rcAll.Top + (row * rcItem.Height)
        For col = vCol To vColNum - 1
            rcItem.Left = rcAll.Left + (col * rcItem.Width)
            
            'Dim itemText As String
            'itemText = "(" + CStr(col) + ", " + CStr(row) + ")"
            'Dim rcTemp As RECT
            'rcTemp = ToRECT(rcItem)
            'Dim rcText As RECT
            'rcText = rcTemp
            'DrawTextA dc, itemText, Len(itemText), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
        Next col
    Next row
#End If

    Dim lastFont As Long
    lastFont = SelectObject(dc, fontHelpers)

    If bShowGrid = True Then DrawGrid dc
    If bShowRules = True Then DrawRules dc
    If bShowMiceLines = True Then DrawMiceLines dc, hWnd
    
    SelectObject dc, lastFont

    SetTextColor dc, lastTextColor
    SetBkMode dc, lastBkMode
End Sub

Public Sub HighlightByCoords(x As Long, y As Long)
    On Error Resume Next
    
    Dim row As Long, col As Long
    col = GetIndexFromPoint(x, y, row)
    
    hotCol = col
    hotRow = row
End Sub
