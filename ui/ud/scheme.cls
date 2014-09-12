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
Private Const cdMaxScale As Double = 2.2

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

Private Sub CalcMyRect()
    With rcAll
        .Width = Cols * rcItem.Width
        .Height = Rows * rcItem.Height
        .Left = rcDisplay.Left + (rcDisplay.Width - .Width) / 2
        .Top = rcDisplay.Top + (rcDisplay.Height - .Height) / 2
    End With
End Sub

Private Sub CalcVisibleIndexes()
    If rcAll.Width > rcDisplay.Width Then
        vCol = (rcDisplay.Left - rcAll.Left) / rcItem.Width - 1
        If vCol < 0 Then vCol = 0
        
        vColNum = (rcDisplay.Width + rcItem.Width + rcItem.Width) / rcItem.Width + 1
        If vColNum > Cols Then vColNum = Cols
    Else
        vCol = 0
        vColNum = Cols
    End If
    
    If rcAll.Height > rcDisplay.Height Then
        vRow = (rcDisplay.Top - rcAll.Top) / rcItem.Height - 1
        If vRow < 0 Then vRow = 0
        
        vRowNum = (rcDisplay.Height + rcItem.Height + rcItem.Height) / rcItem.Height + 1
        If vRowNum > Rows Then vRowNum = Rows
    Else
        vRow = 0
        vRowNum = Rows
    End If
End Sub

Public Sub Draw(ByVal dc As Long, x As Long, y As Long, cx As Long, cy As Long)
    On Error Resume Next
    rcDisplay = RInit(x, y, cx, cy)
    
    CalcItemRect
    CalcMyRect
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
            
            Dim rcDraw As RECT, rcText As RECT
            rcDraw = ToRECT(rcItem)
            rcText = rcDraw
            
            DrawTextA dc, itemText, Len(itemText), rcText, DT_CENTER + DT_BOTTOM + DT_SINGLELINE
            ARect dc, rcDraw
        Next col
    Next row

    SetTextColor dc, lastTextColor
    SetBkMode dc, lastBkMode
    SelectObject dc, lastPen
End Sub
