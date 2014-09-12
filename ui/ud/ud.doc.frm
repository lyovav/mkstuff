VERSION 5.00
Begin VB.Form CDoc 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H0000FFFF&
   Caption         =   "..."
   ClientHeight    =   6585
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   9630
   BeginProperty Font 
      Name            =   "Terminus"
      Size            =   12
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
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

Private Const cxMinSize = 256
Private Const cyMinSize = 256

Private backBmp As Long
Private backDc As Long
Private hFont As Long

Public Scheme As New CScheme

Private Sub Form_Load()
    On Error Resume Next
    Me.ScaleMode = vbPixels
    Me.AutoRedraw = False
    hFont = 0
End Sub

Private Sub Form_Paint()
    OnPaint
    BitBlt Me.hDC, 0, 0, Me.ScaleWidth, Me.ScaleHeight, backDc, 0, 0, vbSrcCopy
End Sub

Private Sub Form_Resize()
    CreateDBuffer Me.ScaleWidth, Me.ScaleHeight
End Sub

Private Sub Form_Unload(Cancel As Integer)
    DeleteDBuffer
    
    If hFont = 0 Then DeleteObject hFont
End Sub

Private Sub DeleteDBuffer()
    On Error Resume Next
    
    DeleteObject SelectObject(backDc, backBmp)
    DeleteDC backDc
    
    'Debug.Print "BKBUFFER: del &H" + Hex(backDc) + " &H" + Hex(backBmp)
End Sub

Private Sub CreateDBuffer(cx As Integer, cy As Integer)
    On Error Resume Next
    
    Dim bmp As Long
    Dim dc As Long
    
    If cx < cxMinSize Then cx = cxMinSize
    If cy < cyMinSize Then cy = cyMinSize
   
    dc = CreateCompatibleDC(ByVal 0&)
    bmp = CreateBitmap(cx, cy, GetDeviceCaps(dc, PLANES), GetDeviceCaps(dc, BITSPIXEL), ByVal 0&)
    bmp = SelectObject(dc, bmp)
    
    If hFont = 0 Then hFont = OLEFont2HFONT(Me.Font, dc)
    SelectObject dc, hFont
    
    DeleteDBuffer

    backBmp = bmp
    backDc = dc
        
    'Debug.Print "BKBUFFER: new " + CStr(cx) + " x " + CStr(cy)
    Form_Paint
End Sub

Public Sub OnPaint()
    On Error GoTo PaintErr
    
    Dim rc As RECT
    GetClientRect Me.hWnd, rc
    
    FillSolidRect backDc, rc, DocBgColor
    
    Scheme.Draw backDc, 0, 0, rc.Right, rc.Bottom
    Exit Sub
    
PaintErr:
    Debug.Print "CHILDRAW: " + Err.Description
    Resume Next
End Sub
