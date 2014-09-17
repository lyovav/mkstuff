VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CToolWire"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Implements ITool

Private bInProgress As Boolean
Private lStartX As Long
Private lStartY As Long
Private lCurrX As Long
Private lCurrY As Long
Private lEndX As Long
Private lEndY As Long

Private Sub Class_Initialize()
    bInProgress = False
End Sub

Public Function ITool_InProgress() As Boolean
    ITool_InProgress = bInProgress
End Function

Private Sub ITool_OnBegin(ByRef pScheme As CScheme, ByVal x As Long, ByVal y As Long, ByVal iKeys As Integer)
    If bInProgress Then
        bInProgress = False
        lEndX = x
        lEndY = y
        Call pScheme.ConnectByWyre(lStartX, lStartY, lEndX, lEndY)
    Else
        lStartX = x
        lStartY = y
        bInProgress = True
    End If
End Sub

Private Sub ITool_OnMove(ByVal x As Long, ByVal y As Long, ByVal iKeys As Integer)
    lCurrX = x
    lCurrY = y
End Sub

Private Sub ITool_OnEnd(ByRef pScheme As CScheme, ByVal x As Long, ByVal y As Long, ByVal iKeys As Integer)
End Sub

Private Sub ITool_OnDraw(ByVal dc As Long, ByRef pScheme As CScheme)
    Call ALine(dc, lStartX, lStartY, lCurrX, lCurrY)
End Sub
