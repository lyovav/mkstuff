VERSION 5.00
Begin VB.Form CDoc 
   Appearance      =   0  'Flat
   BackColor       =   &H00F1FFFF&
   Caption         =   "Form1"
   ClientHeight    =   6585
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   9630
   Icon            =   "ud.doc.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6585
   ScaleWidth      =   9630
End
Attribute VB_Name = "CDoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private dbufBitmap As Long
Private dbufDc As Long

Private Sub Form_Load()
    On Error Resume Next
    Me.ScaleMode = vbPixels
    
    dbufBitmap = 0
    dbufDc = 0
End Sub

Private Sub Form_Paint()
    BitBlt Me.hDC, 0, 0, Me.ScaleWidth, Me.ScaleHeight, dbufDc, 0, 0, vbSrcCopy
End Sub

Private Sub Form_Resize()
    CreateDBuffer
End Sub

Private Sub Form_Unload(Cancel As Integer)
    DeleteDBuffer
End Sub

Private Sub DeleteDBuffer()
    On Error Resume Next
    Debug.Print "DLBUFFER: delete @" + Hex(dbufDc) + " @" + Hex(dbufBitmap)
    DeleteObject dbufBitmap
    DeleteDC dbufDc
End Sub

Private Sub CreateDBuffer()
    On Error Resume Next
    Dim bmp As Long
    Dim dc As Long
    
    bmp = CreateCompatibleBitmap(Me.hDC, Me.ScaleWidth, Me.ScaleHeight)
    dc = CreateCompatibleDC(Me.hDC)
    SelectObject dc, bmp
    
    Debug.Print "DLBUFFER: new " + str(Me.ScaleWidth) + " x" + str(Me.ScaleHeight)
    
    If dc <> 0 And bmp <> 0 Then
        DeleteDBuffer
        dbufBitmap = bmp
        dbufDc = dc
    Else
        DeleteDC dc
        DeleteObject bmp
    End If
End Sub

