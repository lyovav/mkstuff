Attribute VB_Name = "AnythingToString"
Option Explicit
DefInt A-Z

Public Function BytesToPlaneString(byteArr() As Byte, lb As Long, ub As Long) As String
    On Error Resume Next
    Dim i As Long, rv As String
    
    For i = lb To ub
        rv = rv + CStr(byteArr(i))
    Next i
    
    BytesToPlaneString = rv
End Function
