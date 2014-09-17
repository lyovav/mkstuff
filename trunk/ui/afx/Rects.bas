Attribute VB_Name = "Rects"
Option Explicit
DefInt A-Z

Public Type CRect
    Left As Long
    Top As Long
    Width As Long
    Height As Long
End Type

Public Function RInit(x As Long, y As Long, cx As Long, cy As Long) As CRect
    Dim rv As CRect
    
    With rv
        .Left = x
        .Top = y
        .Width = cx
        .Height = cy
    End With
    
    RInit = rv
End Function

Public Function RRight(rc As CRect)
    RRight = rc.Left + rc.Width
End Function

Public Function RBottom(rc As CRect)
    RBottom = rc.Top + rc.Height
End Function

Public Function ToRECT(rc As CRect) As RECT
    Dim rv As RECT
    
    With rv
        .Left = rc.Left
        .Top = rc.Top
        .Right = rc.Left + rc.Width
        .Bottom = rc.Top + rc.Height
    End With
    
    ToRECT = rv
End Function

Public Sub DrawRect(ByVal hDc As Long, rc As CRect)
    Dim pt As APOINT
    MoveToEx hDc, rc.Left, rc.Top, pt
    LineTo hDc, RRight(rc), rc.Top
    LineTo hDc, RRight(rc), RBottom(rc)
    LineTo hDc, rc.Left, RBottom(rc)
    LineTo hDc, rc.Left, rc.Top
End Sub

