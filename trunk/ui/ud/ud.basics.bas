Attribute VB_Name = "Basics"
Option Explicit
DefInt A-Z

Public Enum CellType
    ctBlank = 32
    ctPin
    ctVoltmeter
    ctAmpermeter
    ctVivaLaResistance
End Enum

Public Enum CellFlags
    cfNone = 0
End Enum

Public Type PinDesc
    x As Long
    y As Long
End Type

' Pin coords example
'
'.Pin(1).x = 0   '   0__1__2
'.Pin(1).y = 1   '  0|     |
'.Pin(2).x = 2   '  1|     |
'.Pin(2).y = 1   '  2|_____|
'

Public Type CellDesc
    Id As Long
    Type As Long
    Flags As Long
    Pin(1 To 2) As PinDesc
    Text(1 To 32) As Byte
End Type

Public BlankCell As CellDesc

Public Function CellTextLen(ByRef cell As CellDesc) As Long
    Dim i As Long
    For i = LBound(cell.Text) To UBound(cell.Text)
        If cell.Text(i) = 0 Then Exit For
    Next i
    CellTextLen = i - 1
End Function

Public Sub SetCellText(ByRef cell As CellDesc, str As String)
    Dim i As Long
    For i = 1 To Len(str)
        cell.Text(i) = Asc(Mid(str, i, 1))
        If i > UBound(cell.Text) - 1 Then Exit For
    Next i
End Sub

Private Sub DrawWire(cell As CellDesc, ByVal dc As Long, rc As RECT, hcx As Long, hcy As Long)
    Dim i As Long
    Call MoveToChecked(dc, rc.Left + cell.Pin(1).x * hcx, rc.Top + cell.Pin(1).y * hcy)
    For i = 2 To UBound(cell.Pin)
        Call LineToChecked(dc, rc.Left + cell.Pin(i).x * hcx, rc.Top + cell.Pin(i).y * hcy)
    Next i
End Sub

Public Sub DrawCell(ByRef cell As CellDesc, ByVal dc As Long, ByRef rcItem As CRect, ByRef miceCoords As APOINT)
    If cell.Type = ctBlank Then
        Exit Sub
    End If

    Dim rc As RECT
    Dim rc1 As RECT
    Dim cx As Long, cy As Long
    Dim l As Integer
   
    cx = rcItem.Width
    cy = rcItem.Height
    rc = ToRECT(rcItem)
    rc1 = rc
    
    Call DrawWire(cell, dc, rc, cx \ 2, cy \ 2)
    
    Select Case cell.Type
    Case ctPin
        Call InflateRect(rc1, -(cx / 2.5), -(cy / 2.5))
        Call EllipseRc(dc, rc1)
    Case ctVoltmeter
        Call InflateRect(rc1, -(cx \ 6), -(cy \ 6))
        Call EllipseRc(dc, rc1)
    Case ctAmpermeter
        Call InflateRect(rc1, -(cx \ 6), -(cy \ 6))
        Call EllipseRc(dc, rc1)
    Case ctVivaLaResistance
        Call InflateRect(rc1, -(cx \ 6), -(cy \ 3))
        Call Rectangle(dc, rc1.Left, rc1.Top, rc1.Right, rc1.Bottom)
    End Select
    
    l = CellTextLen(cell)
    If l > 0 Then Call DrawTextA(dc, cell.Text, l, rc1, DT_CENTERED)
End Sub

Public Sub InitBasics()
    BlankCell = CreateBlankCell(0, 0, 0, 0)
    With BlankCell
        .Id = 0
        .Type = ctBlank
    End With
End Sub

Public Function CreateBlankCell(ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As CellDesc
    Dim rv As CellDesc, i As Long
    With rv
        .Id = 0
        .Type = ctBlank
        .Flags = 0
        
        .Pin(1).x = x1 '   0__1__2
        .Pin(1).y = y1 '  0|     |
        .Pin(2).x = x2 '  1|     |
        .Pin(2).y = y2 '  2|_____|
        
        For i = LBound(.Text) To UBound(.Text)
            .Text(i) = 0
        Next i
    End With
    CreateBlankCell = rv
End Function

Public Function CreatePin(ByVal x As Long, ByVal y As Long) As CellDesc
    Dim rv As CellDesc
    rv = CreateBlankCell(1, 1, x, y)
    rv.Type = ctPin
    CreatePin = rv
End Function

Public Function CreateVoltmeter(Optional x1 As Long = 0, Optional y1 As Long = 1, Optional x2 As Long = 2, Optional y2 As Long = 1) As CellDesc
    Dim rv As CellDesc
    rv = CreateBlankCell(x1, y1, x2, y2)
    rv.Type = ctVoltmeter
    Call SetCellText(rv, "U")
    CreateVoltmeter = rv
End Function

Public Function CreateAmpermeter(Optional x1 As Long = 0, Optional y1 As Long = 1, Optional x2 As Long = 2, Optional y2 As Long = 1) As CellDesc
    Dim rv As CellDesc
    rv = CreateBlankCell(x1, y1, x2, y2)
    rv.Type = ctAmpermeter
    Call SetCellText(rv, "I")
    CreateAmpermeter = rv
End Function

Public Function CreateResistor(Optional x1 As Long = 0, Optional y1 As Long = 1, Optional x2 As Long = 2, Optional y2 As Long = 1) As CellDesc
    Dim rv As CellDesc
    rv = CreateBlankCell(x1, y1, x2, y2)
    rv.Type = ctVivaLaResistance
    Call SetCellText(rv, "R")
    CreateResistor = rv
End Function
