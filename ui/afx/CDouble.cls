VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CDouble"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private SepDecimal As String
Private SepMiles As String

Public Function Init()
    If CDbl("3,24") = 324 Then
        SepDecimal = "."
        SepMiles = ","
    Else
        SepDecimal = ","
        SepMiles = "."
    End If
End Function

Public Function FromString(x As String) As Double
    If x = "" Then x = "0"
    x = Replace(Trim(x), " ", "")
    
    If InStr(x, SepDecimal) > 0 Then
        If InStr(x, SepMiles) > 0 Then
            If InStr(x, SepDecimal) > InStr(x, SepMiles) Then
                x = Replace(x, SepMiles, "")
            Else
                x = Replace(x, SepDecimal, "")
                x = Replace(x, SepMiles, SepDecimal)
            End If
        End If
    Else
        x = Replace(x, SepMiles, SepDecimal)
    End If
    FromString = CDbl(x)
End Function
