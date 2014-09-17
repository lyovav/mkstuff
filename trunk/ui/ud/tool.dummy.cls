VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CToolDummy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

#If False Then

Implements ITool

Public Sub DrawingBegin(ByVal hDc As Long)
End Sub

Public Sub DrawingMove(ByVal hDc As Long)
End Sub

Public Sub DrawingEnd(ByVal hDc As Long)
End Sub

#End If
