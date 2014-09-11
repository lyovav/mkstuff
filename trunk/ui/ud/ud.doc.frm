VERSION 5.00
Begin VB.Form CDoc 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00400040&
   Caption         =   "..."
   ClientHeight    =   6585
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   9630
   Icon            =   "ud.doc.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   MousePointer    =   2  'Cross
   ScaleHeight     =   439
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   642
End
Attribute VB_Name = "CDoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private backBmp As Long
Private backDc As Long

Private Sub Form_Load()
    On Error Resume Next
    Me.ScaleMode = vbPixels
    Me.AutoRedraw = True
End Sub

Private Sub Form_Paint()
    BitBlt Me.hDC, 0, 0, Me.ScaleWidth, Me.ScaleHeight, backDc, 0, 0, vbSrcCopy
End Sub

Private Sub Form_Resize()
    CreateDBuffer
End Sub

Private Sub Form_Unload(Cancel As Integer)
    DeleteDBuffer
End Sub

Private Sub DeleteDBuffer()
    On Error Resume Next
    
    DeleteObject SelectObject(backDc, backBmp)
    DeleteDC backDc
    
    Debug.Print "BKBUFFER: del &H" + Hex(backDc) + " &H" + Hex(backBmp)
End Sub

Private Sub CreateDBuffer()
    On Error Resume Next
    
    Dim bmp As Long
    Dim dc As Long
   
    dc = CreateCompatibleDC(ByVal 0&)
    bmp = CreateBitmap(Me.ScaleWidth, Me.ScaleHeight, GetDeviceCaps(dc, PLANES), GetDeviceCaps(dc, BITSPIXEL), ByVal 0&)
    bmp = SelectObject(dc, bmp)
    
    DeleteDBuffer

    backBmp = bmp
    backDc = dc
        
    Debug.Print "BKBUFFER: new " + CStr(Me.ScaleWidth) + " x " + CStr(Me.ScaleHeight)
    Draw
End Sub

Private Sub DrawRule(which As Integer)

End Sub

Private Sub DrawGrid()
    
End Sub

Private Sub Draw()
    On Error GoTo PaintErr
    Dim rc As RECT
    
    GetClientRect Me.hWnd, rc
    FillSolidRect backDc, rc, SchemeBgColor
    
    DrawGrid
    DrawRule vbHorizontal
    DrawRule vbVertical
    
    Form_Paint
    Exit Sub
PaintErr:
    Debug.Print "CHILDRAW: " + Err.Description
    Resume Next
End Sub
