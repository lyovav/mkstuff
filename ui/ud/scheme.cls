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

Private Const DefItemWidth As Long = 48
Private Const DefItemHeight As Long = 48
Private Const DefItemCols As Integer = 32
Private Const DefItemRows As Integer = 32
Private Const cdMinScale As Double = 0.1
Private Const cdMaxScale As Double = 10.2

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

' Appearance
Private penGrid As Long

Public Sub Class_Initialize()
    penGrid = CreatePen(DocGridStyle, 1, DocGridColor)
    dScale = 1#
    Allocate DefItemRows, DefItemCols
End Sub

Private Sub Class_Terminate()
    DeleteObject penGrid
End Sub

Public Sub IncrementScale(val As Double)
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

    ' Filling by some initial values -------------------
    Dim row As Integer, col As Integer
    For row = 0 To Rows
        For col = 0 To Cols
            Item(row, col) = 0
        Next col
    Next row
    ' --------------------------------------------------
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
        .Left = rcDisplay.Left + (rcDisplay.Width - .Width) / 2
        .Top = rcDisplay.Top + (rcDisplay.Height - .Height) / 2
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
    
    DebugString = "[" + CStr(vCol) + " " + CStr(vRow) + " " + CStr(vColNum) + "x" + CStr(vRowNum) + "]"
End Sub

Public Sub Draw(ByVal dc As Long, x As Long, y As Long, cx As Long, cy As Long)
    On Error Resume Next
    rcDisplay = RInit(x, y, cx, cy)
    
    CalcItemRect
    CalcAllRect
    CalcVisibleIndexes
    
    Dim lastPen As Long, lastBkMode As Long, lastTextColor As Long
    
    lastPen = SelectObject(dc, penGrid)
    lastBkMode = SetBkMode(dc, TRANSPARENT)
    lastTextColor = SetTextColor(dc, DocFgColor)
    
    Dim row As Integer, col As Integer
    For row = vRow To vRowNum - 1
        rcItem.Top = rcAll.Top + (row * rcItem.Height)
        For col = vCol To vColNum - 1
            rcItem.Left = rcAll.Left + (col * rcItem.Width)
            
            Dim itemText As String
            itemText = "(" + CStr(col) + ", " + CStr(row) + ")"
            
            Dim rcTemp As RECT
            rcTemp = ToRECT(rcItem)
            
            'Rectangle dc, rcTemp.Left, rcTemp.Top, rcTemp.right + 1, rcTemp.bottom + 1
            
            Dim rcText As RECT
            rcText = rcTemp
            DrawTextA dc, itemText, Len(itemText), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
            
            MoveTo dc, rcTemp.Left, rcTemp.Bottom
            LineTo dc, rcTemp.Right, rcTemp.Bottom
            LineTo dc, rcTemp.Right, rcTemp.Top
            
        Next col
    Next row

    SetTextColor dc, lastTextColor
    SetBkMode dc, lastBkMode
    SelectObject dc, lastPen
End Sub
