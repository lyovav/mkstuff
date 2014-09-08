Attribute VB_Name = "Buttons"
DefInt A-Z
Option Explicit

Public Type ButtonConf
    bnTitle As String
    bnPic As Picture
End Type

Public DefaultButtons(0 To MaxButtons) As ButtonConf

Private Const DefaultButtonR0 = "   | B | C |   | E |   |"
Private Const DefaultButtonR1 = "   |   |   |   |   |   |"
Private Const DefaultButtonR2 = "   |   | 1 | 2 | 3 |   |"
Private Const DefaultButtonR3 = "   |   | 4 | 5 | 6 |   |"
Private Const DefaultButtonR4 = "   |   | 7 | 8 | 9 |   |"
Private Const DefaultButtonR5 = "   |   |   | 0 |   |   |"
Private Const DefaultButtonR6 = "   |   |   |   |   |   |"

Public Static Sub InitButtons()

End Sub
