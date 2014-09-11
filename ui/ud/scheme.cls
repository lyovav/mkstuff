VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CScheme"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private Const CountX = 255
Private Const CountY = 255

Private ScaleInPercent As Integer
Private Item(0 To CountX, 0 To CountY) As Long

Private Sub Class_Initialize()
    ScaleInPercent = 100
    
    Dim row As Integer, col As Integer
    
    Randomize
    For row = 0 To CountY
        For col = 0 To CountX
            Item(col, row) = 1 + Rnd * 16
        Next col
    Next row
End Sub
