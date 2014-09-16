Attribute VB_Name = "UdBasics"
Option Explicit
DefInt A-Z

Public Enum CellType
    ctZero = 32
    ctVoltmeter
    ctAmpermeter
    ctVivaLaResistance
End Enum

Public Enum CellFlags
    cfNone = 0
    cfHorizontal = &H1
    cfVertical = &H2
End Enum

Public Type CellDesc
    Id As Long
    Type As Long
    Flags As Long
    Reserved As Long
End Type

Public ZeroCell As CellDesc

Private Sub DrawWire(ByVal dc As Long, rc As RECT, rc1 As RECT, cx As Long, cy As Long, flg As Long)
    Dim y As Long
    
    If (flg And cfHorizontal) <> 0 Then
        y = rc.Top + cy \ 2
        ALineChecked dc, rc.Left, y, rc1.Left, y
        ALineChecked dc, rc1.Right, y, rc.Right, y
    Else
        If (flg And cfVertical) <> 0 Then
            y = rc.Left + cx \ 2
            ALineChecked dc, y, rc.Top, y, rc1.Top
            ALineChecked dc, y, rc1.Bottom, y, rc.Bottom
        End If
    End If
End Sub

Public Sub DrawCell(ByRef cell As CellDesc, ByVal dc As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long)
    If cell.Type = ctZero Then
        Exit Sub
    End If
    
    Dim rc As RECT
    rc = InitRECT(x, y, cx, cy)
    
    Dim rc1 As RECT
    rc1 = rc
    
    Dim ex As Long, ey As Long
    ex = cx \ 6
    ey = cy \ 6
    
    InflateRect rc1, -ex, -ey
    
    Dim rc2 As RECT
    rc2 = rc1
    
    Select Case cell.Type
    Case ctVoltmeter
        EllipseRc dc, rc1
        DrawTextA dc, "V", 1, rc1, DT_CENTERD
        DrawWire dc, rc, rc1, cx, cy, cell.Flags
        
    Case ctAmpermeter
        EllipseRc dc, rc1
        DrawTextA dc, "A", 1, rc1, DT_CENTERD
        DrawWire dc, rc, rc1, cx, cy, cell.Flags
        
    Case ctVivaLaResistance
        If (cell.Flags And cfVertical) <> 0 Then
            InflateRect rc2, -ex, 0
        Else
            InflateRect rc2, 0, -ey
        End If
        Rectangle dc, rc2.Left, rc2.Top, rc2.Right, rc2.Bottom
        DrawWire dc, rc, rc1, cx, cy, cell.Flags
       
    End Select
End Sub

Public Sub InitBasics()
    ZeroCell = CreateZeroCell()
    With ZeroCell
        .Id = 0
        .Type = ctZero
    End With
End Sub

Public Function CreateZeroCell() As CellDesc
    Dim rv As CellDesc
    
    With rv
        .Id = 0
        .Type = ctZero
        .Flags = cfHorizontal
    End With
    
    CreateZeroCell = rv
End Function


Public Function CreateVoltmeter() As CellDesc
    Dim rv As CellDesc
    
    rv = CreateZeroCell()
    rv.Type = ctVoltmeter
    
    CreateVoltmeter = rv
End Function

Public Function CreateAmpermeter() As CellDesc
    Dim rv As CellDesc
    
    rv = CreateZeroCell()
    rv.Type = ctAmpermeter
    
    CreateAmpermeter = rv
End Function

Public Function CreateResistor() As CellDesc
    Dim rv As CellDesc
    
    rv = CreateZeroCell()
    rv.Type = ctVivaLaResistance
    
    CreateResistor = rv
End Function

