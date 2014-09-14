Attribute VB_Name = "UdBasics"
Option Explicit
DefInt A-Z

Public Type Cell
    Id As Long
End Type

Public ZeroCell As Cell

Public Sub InitBasics()
    With ZeroCell
        .Id = -1
    End With
End Sub
