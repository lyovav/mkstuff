VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ITool"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Public Function InProgress() As Boolean
End Function

Public Sub OnBegin(ByRef pScheme As CScheme, ByVal x As Long, ByVal y As Long, ByVal iKeys As Integer)
End Sub

Public Sub OnMove(ByVal x As Long, ByVal y As Long, ByVal iKeys As Integer)
End Sub

Public Sub OnEnd(ByRef pScheme As CScheme, ByVal x As Long, ByVal y As Long, ByVal iKeys As Integer, ByVal bCancel As Boolean)
End Sub

Public Sub OnDraw(ByVal dc As Long, ByRef pScheme As CScheme)
End Sub

