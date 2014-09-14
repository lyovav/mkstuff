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

Private Const DefItemWidth As Long = 50
Private Const DefItemHeight As Long = 50
Private Const DefItemCols As Integer = 20
Private Const DefItemRows As Integer = 12

Private Const cdMinScale As Double = 0.01
Private Const cdMaxScale As Double = 40.96
Private Const cdScaleMul As Double = 0.02
Private Const cdScaleMul2 As Double = 0.5

Private Const ruleCx As Long = 16
Private Const ruleCy As Long = 16
Private Const ruleHalfCx As Long = ruleCx / 2
Private Const ruleHalfCy As Long = ruleCy / 2

Public DebugString As String

Private dScale As Double
Private Item() As Byte

Private bShowGrid As Boolean
Private bShowRules As Boolean
Private Cols As Integer
Private Rows As Integer
Private rcDisplay As CRect
Private rcAll As CRect
Private rcItem As CRect
Private vCol As Integer
Private vColNum As Integer
Private vRow As Integer
Private vRowNum As Integer
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

' Appearance
Private penGrid As Long
Private penRulesLine As Long
Private penRulesMark As Long

Public Sub Class_Initialize()
    penGrid = CreatePen(DocGridPenStyle, 1, DocGridColor)
    penRulesLine = CreatePen(DocRulesPenStyle, 1, DocRulesColor)
    penRulesMark = CreatePen(DocRulesPenStyle, 2, DocRulesColor)
    
    ResetView
    
    bShowGrid = True
    bShowRules = True
    
    Allocate DefItemRows, DefItemCols
End Sub

Private Sub Class_Terminate()
    DeleteObject penRulesMark
    DeleteObject penRulesLine
    DeleteObject penGrid
End Sub

Public Sub ResetView()
    dScale = 1#
    offsetX = 0
    offsetY = 0
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

Public Function GetScale() As Double
    GetScale = dScale
End Function

Public Sub Allocate(cn As Integer, rn As Integer)
    ReDim Item(0 To cn, 0 To rn) As Byte
    
    Cols = UBound(Item, 2)
    Rows = UBound(Item, 1)

    Dim row As Integer, col As Integer
    For row = 0 To Rows
        For col = 0 To Cols
            Item(row, col) = 0
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
        .Left = offsetX + rcDisplay.Left + (rcDisplay.Width - .Width) / 2
        .Top = offsetY + rcDisplay.Top + (rcDisplay.Height - .Height) / 2
    End With
End Sub

Private Function CalcVisibleStuff(ByRef count As Integer, maxCount As Integer _
                                , iw As Long _
                                , x1 As Long, w1 As Long _
                                , x2 As Long, w2 As Long _
                                ) As Integer
    Dim rv As Integer
    
    rv = ((x2 - x1) / iw) - 1
    count = (w2 / iw) + 2
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
    If rcAll.Height < rcDisplay.Height Then
        begY = rcAll.Top
        endY = RBottom(rcAll)
    Else
        begY = rcDisplay.Top
        endY = RBottom(rcDisplay)
    End If
    
    If rcAll.Width < rcDisplay.Width Then
        begX = rcAll.Left
        endX = RRight(rcAll)
    Else
        begX = rcDisplay.Left
        endX = RRight(rcDisplay)
    End If
End Sub

Public Sub DrawGrid(ByVal dc As Long)
    On Error Resume Next
    
    Dim lastPen As Long
    Dim row As Integer, col As Integer
    Dim y As Long
    
    lastPen = SelectObject(dc, penGrid)
    
    If rcAll.Height < rcDisplay.Height Then ALine dc, begX, begY, endX, begY
    
    For row = vRow To vRowNum - 1
        y = rcAll.Top + (row * rcItem.Height) + rcItem.Height
        
        If y >= rcDisplay.Top Then
            ALine dc, begX, y, endX, y
        End If
    Next row
    
    If rcAll.Width < rcDisplay.Width Then ALine dc, begX, begY, begX, endY
    
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
    Dim i As Integer
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

Public Sub Draw(ByVal dc As Long, x As Long, y As Long, cx As Long, cy As Long)
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
    
    Dim lastBkMode As Long, lastTextColor As Long
    
    lastBkMode = SetBkMode(dc, TRANSPARENT)
    lastTextColor = SetTextColor(dc, DocFgColor)
    
#If False Then
    Dim row As Integer, col As Integer
    For row = vRow To vRowNum - 1
        rcItem.Top = rcAll.Top + (row * rcItem.Height)
        For col = vCol To vColNum - 1
            rcItem.Left = rcAll.Left + (col * rcItem.Width)
            
            Dim itemText As String
            itemText = "(" + CStr(col) + ", " + CStr(row) + ")"
            
            Dim rcTemp As RECT
            rcTemp = ToRECT(rcItem)
            
            Dim rcText As RECT
            rcText = rcTemp
            DrawTextA dc, itemText, Len(itemText), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
        Next col
    Next row
#End If

    If bShowGrid = True Then DrawGrid dc
    If bShowRules = True Then DrawRules dc

    SetTextColor dc, lastTextColor
    SetBkMode dc, lastBkMode
End Sub
