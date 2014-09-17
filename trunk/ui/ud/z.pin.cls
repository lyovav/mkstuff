VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Pin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private Connection() As ICell

Public Sub Connect(pCell As ICell)
    On Error Resume Next
    
    If pCell Then
        Dim iCur As Long
        iCur = UBound(Connection)
        iCur = iCur + 1
        ReDim Connection(0 To iCur) As ICell
        Set Connection(iCur) = pCell
    End If
End Sub

Public Sub ProcessInput(ByRef dU As Double, ByRef dI As Double)
    On Error Resume Next
    Dim iMax As Long, i As Long
    iMax = UBound(Connection)
    For i = 1 To iMax
        Call Connection(i).ProcessInput(dU, dI)
    Next i
End Sub

Public Sub ResetOutout(ByRef dU As Double, ByRef dI As Double)
    On Error Resume Next
    Dim iMax As Long, i As Long
    iMax = UBound(Connection)
    For i = 1 To iMax
        Call Connection(i).ResetOutout(dU, dI)
    Next i
End Sub

