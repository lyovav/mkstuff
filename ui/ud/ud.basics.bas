Attribute VB_Name = "UdBasics"
Option Explicit
DefInt A-Z

Public Enum CellType
    ctZero = 32
    ctWire
    ctVoltmeter
    ctAmpermeter
End Enum

Public Type CellDesc
    Id As Long
End Type

Public ZeroCell As CellDesc

Public Sub InitBasics()
    With ZeroCell
        .Id = ctZero
    End With
End Sub

Public Function CreateWire() As CellDesc
    Dim rv As CellDesc
    
    With rv
        .Id = ctWire
    End With
    
    CreateWire = rv
End Function

