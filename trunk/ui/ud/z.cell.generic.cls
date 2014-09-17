VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Cell"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Implements ICell

Private InpPin As Pin
Private OutPin As Pin
Private dU As Double
Private dI As Double

Private Sub Class_Initialize()
    dU = 0#
    dI = 0#
End Sub

Private Sub ICell_Process()
    Call InpPin.ProcessInput(dU, dI)
    Call OutPin.ResetOutout(dU, dI)
End Sub

Private Sub ICell_ProcessInput(dU As Double, dI As Double)
End Sub

Private Sub ICell_ResetOutput(dU As Double, dI As Double)
End Sub
