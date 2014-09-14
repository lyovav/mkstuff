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

Private Const DefItemWidth As Long = 64
Private Const DefItemHeight As Long = 64
Private Const DefItemCols As Integer = 16
Private Const DefItemRows As Integer = 16

Private Const cdMinScale As Double = 0.01
Private Const cdMaxScale As Double = 40.96
Private Const cdScaleMul As Double = 0.02
Private Const cdScaleMul2 As Double = 0.5

Public DebugString As String

Private dScale As Double
Private Item() As Byte

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
Private allX As Long
Private allY As Long

' Appearance
Private penGrid As Long

Public Sub Class_Initialize()
    penGrid = CreatePen(DocGridStyle, 1, DocGridColor)
    dScale = 1#
    allX = 0
    allY = 0
    Allocate DefItemRows, DefItemCols
End Sub

Private Sub Class_Terminate()
    DeleteObject penGrid
End Sub

Public Sub BeginDrag(keys As Integer, xp As Long, yp As Long)
    lastLeft = allX
    lastTop = allY
    dragX = xp
    dragY = yp
End Sub

Public Sub Drag(keys As Integer, xp As Long, yp As Long)
    allX = lastLeft + (xp - dragX)
    allY = lastTop + (yp - dragY)
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
        .Left = allX + rcDisplay.Left + (rcDisplay.Width - .Width) / 2
        .Top = allY + rcDisplay.Top + (rcDisplay.Height - .Height) / 2
    End With
End Sub

Private Function CalcVisibleStuff(ByRef count As Integer, maxCount As Integer, iw As Long, x1 As Long, w1 As Long, x2 As Long, w2 As Long) As Integer
    Dim x As Integer
    
    If w1 > w2 Then
        x = ((x2 - x1) / iw) - 1
        count = (w2 / iw) + 2
        count = count + x
        
        If count > maxCount Then count = maxCount
        If x < 0 Then x = 0
    Else
        x = 0
        count = maxCount
    End If
    
    CalcVisibleStuff = x
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
    
    If begY >= rcDisplay.Top Then ALine dc, begX, begY, endX, begY
    
    For row = vRow To vRowNum - 1
        y = rcAll.Top + (row * rcItem.Height) + rcItem.Height
        If y >= rcDisplay.Top And y < RBottom(rcDisplay) Then
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

Public Sub Draw(ByVal dc As Long, x As Long, y As Long, cx As Long, cy As Long)
    On Error Resume Next
    
    rcDisplay = RInit(x, y, cx, cy)
    
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

    DrawGrid dc

    SetTextColor dc, lastTextColor
    SetBkMode dc, lastBkMode
End Sub
