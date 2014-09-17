Attribute VB_Name = "Basics"
Option Explicit
DefInt A-Z

Public Enum CellType
    ctBlank = 32
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

' Pin coords
'.Pin(1).x = 0   '   0__1__2
'.Pin(1).y = 1   '  0|     |
'.Pin(2).x = 2   '  1|     |
'.Pin(2).y = 1   '  2|_____|

Public Type CellDesc
    Id As Long
    Type As Long
    Flags As Long
    Pin(1 To 2) As PinDesc
End Type

Public BlankCell As CellDesc

Private Sub DrawWire(cell As CellDesc, ByVal dc As Long, rc As RECT, hcx As Long, hcy As Long)
    ALineChecked dc _
               , rc.Left + cell.Pin(1).x * hcx _
               , rc.Top + cell.Pin(1).y * hcy _
               , rc.Left + cell.Pin(2).x * hcx _
               , rc.Top + cell.Pin(2).y * hcx
End Sub

Public Sub DrawCell(ByRef cell As CellDesc, ByVal dc As Long, ByRef rcItem As CRect, ByRef miceCoords As APOINT)
    If cell.Type = ctBlank Then
        Exit Sub
    End If

    Dim rc As RECT
    Dim rc1 As RECT
    Dim cx As Long, cy As Long
    Dim ex As Long, ey As Long
   
    cx = rcItem.Width
    cy = rcItem.Height
    ex = cx \ 6
    ey = cy \ 6
    rc = ToRECT(rcItem)
    rc1 = rc
    Call InflateRect(rc1, -ex, -ey)
    
    DrawWire cell, dc, rc, cx \ 2, cy \ 2
    
    Select Case cell.Type
    Case ctVoltmeter
        EllipseRc dc, rc1
        DrawTextA dc, "V", 1, rc1, DT_CENTERD
    Case ctAmpermeter
        EllipseRc dc, rc1
        DrawTextA dc, "A", 1, rc1, DT_CENTERD
    Case ctVivaLaResistance
        InflateRect rc1, 0, -ey
        Rectangle dc, rc1.Left, rc1.Top, rc1.Right, rc1.Bottom
    End Select
End Sub

Public Sub InitBasics()
    BlankCell = CreateBlankCell()
    With BlankCell
        .Id = 0
        .Type = ctBlank
    End With
End Sub

Public Function CreateBlankCell() As CellDesc
    Dim rv As CellDesc
    
    With rv
        .Id = 0
        .Type = ctBlank
        .Flags = 0
        .Pin(1).x = 0   '   0__1__2
        .Pin(1).y = 1   '  0|     |
        .Pin(2).x = 2   '  1|     |
        .Pin(2).y = 1   '  2|_____|
    End With
    
    CreateBlankCell = rv
End Function


Public Function CreateVoltmeter() As CellDesc
    Dim rv As CellDesc
    
    rv = CreateBlankCell()
    rv.Type = ctVoltmeter
    
    CreateVoltmeter = rv
End Function

Public Function CreateAmpermeter() As CellDesc
    Dim rv As CellDesc
    
    rv = CreateBlankCell()
    rv.Type = ctAmpermeter
    
    CreateAmpermeter = rv
End Function

Public Function CreateResistor() As CellDesc
    Dim rv As CellDesc
    
    rv = CreateBlankCell()
    rv.Type = ctVivaLaResistance
    
    CreateResistor = rv
End Function

