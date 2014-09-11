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

Private Const DefItemWidth As Long = 90
Private Const DefItemHeight As Long = 120

Private dScale As Double
Private Item() As Byte

Private Cols As Integer
Private Rows As Integer
Private rcDisplay As RECT
Private rcAll As RECT
Private rcItem As RECT
Private vCol As Integer
Private vColNum As Integer
Private vRow As Integer
Private vRowNum As Integer


Public Sub Class_Initialize()
    dScale = 1#
    Allocate 6, 10
End Sub

Public Sub Allocate(cn As Integer, rn As Integer)
    ReDim Item(0 To cn, 0 To rn) As Byte
    
    Cols = UBound(Item, 2)
    Rows = UBound(Item, 1)

    ' --------------------------------------------------
    Dim row As Integer, col As Integer
    For row = 0 To Rows
        For col = 0 To Cols
            Item(row, col) = 0
            
            ' TODO: remove debug filling
            Item(row, col) = CByte(0 + Rnd * 255)
        Next col
    Next row
    ' --------------------------------------------------
End Sub

Private Sub CalcItemRect()
    With rcItem
        .Left = 0
        .Top = 0
        .Right = DefItemWidth * dScale
        .Bottom = DefItemHeight * dScale
    End With
End Sub

Private Sub CalcMyRect()
    With rcAll
        .Right = Cols * rcItem.Right
        .Bottom = Rows * rcItem.Bottom
        .Left = rcDisplay.Left + (rcDisplay.Right - .Right) / 2
        .Top = rcDisplay.Top + (rcDisplay.Bottom - .Bottom) / 2
    End With
End Sub

Private Sub CalcVisibleIndexes()
    If rcAll.Right > rcDisplay.Right Then
        vCol = (rcDisplay.Left - rcAll.Left) / rcItem.Right - 1
        If vCol < 0 Then vCol = 0
        
        vColNum = (rcDisplay.Right + rcItem.Right) / rcItem.Right + 2
        If vColNum > Cols Then vColNum = Cols
    Else
        vCol = 0
        vColNum = Cols
    End If
    
    If rcAll.Bottom > rcDisplay.Bottom Then
        vRow = (rcDisplay.Top - rcAll.Top) / rcItem.Bottom - 1
        If vRow < 0 Then vRow = 0
        
        vRowNum = (rcDisplay.Bottom + rcItem.Bottom) / rcItem.Bottom + 2
        If vRowNum > Rows Then vRowNum = Rows
    Else
        vRow = 0
        vRowNum = Rows
    End If
End Sub

Public Sub Draw(ByVal dc As Long, x As Long, y As Long, cx As Long, cy As Long)
    With rcDisplay
        .Left = x
        .Top = y
        .Right = cx
        .Bottom = cy
    End With
    
    CalcItemRect
    CalcMyRect
    CalcVisibleIndexes
    
    SetBkMode dc, TRANSPARENT
    
    Dim row As Integer, col As Integer
    For row = vRow To vRowNum - 1
        rcItem.Top = rcAll.Top + (row * rcItem.Bottom)
        For col = vCol To vColNum - 1
            rcItem.Left = rcAll.Left + (col * rcItem.Right)
            
            Dim itemText As String
            itemText = "(" + CStr(col) + ", " + CStr(row) + ")"
            
            Dim rcText As RECT
            With rcText
                .Left = rcItem.Left
                .Top = rcItem.Top
                .Right = rcItem.Left + rcItem.Right
                .Bottom = rcItem.Top + rcItem.Bottom
            End With
            
            DrawTextA dc, itemText, Len(itemText), rcText, DT_CENTER + DT_VCENTER + DT_SINGLELINE
            
            ARect dc, rcItem
        Next col
    Next row

End Sub
