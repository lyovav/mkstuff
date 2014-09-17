VERSION 5.00
Begin VB.Form CDoc 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00F2FFFF&
   Caption         =   "Untitled"
   ClientHeight    =   6420
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   13020
   DrawMode        =   11  'Not Xor Pen
   BeginProperty Font 
      Name            =   "Small Fonts"
      Size            =   6.75
      Charset         =   204
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   HasDC           =   0   'False
   Icon            =   "ud.doc.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   MouseIcon       =   "ud.doc.frx":058A
   MousePointer    =   99  'Custom
   ScaleHeight     =   428
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   868
End
Attribute VB_Name = "CDoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Implements IHookXP

Private Const cxMinSize = 256
Private Const cyMinSize = 256

Private Scheme As New CScheme
Private TempSchemeFilename As String
Private backBmp As Long
Private backDc As Long
Private lastFont As Long
Private hFont As Long
Private OriginalCaption As String
Private DragOn As Boolean
Private pTool As ITool
Private toolWire As New CToolWire

Private Function IHookXP_Message(ByVal hWnd As Long, ByVal uiMsg As Long, ByVal wParam As Long, ByVal lParam As Long, ByVal dwRefData As Long) As Long
    On Error Resume Next
    
    Dim paintDc As Long
    Dim ps As PAINTSTRUCT
    Dim delta As Integer, keys As Integer
    Dim xp As Long, yp As Long

    Select Case uiMsg
    Case WM_MOUSEWHEEL
        keys = LowWord(wParam)
        delta = HighWord(wParam) \ WHEEL_DELTA
        xp = LowWord(lParam)
        yp = HighWord(lParam)
        Call OnMouseWheel(keys, delta, xp, yp)

    Case WM_PAINT
        paintDc = BeginPaint(hWnd, ps)
        Call OnPaint
        Call DrawBackBufer(paintDc)
        Call EndPaint(hWnd, ps)
        IHookXP_Message = 0
        Exit Function
        
    Case WM_ERASEBKGND
        IHookXP_Message = 0
        Exit Function

    End Select
    
    IHookXP_Message = HookDefault(hWnd, uiMsg, wParam, lParam)
End Function

Private Sub Form_Load()
    On Error Resume Next
    Set pTool = toolWire
    Me.ScaleMode = vbPixels
    Me.AutoRedraw = False
    hFont = 0
    DragOn = False
    OriginalCaption = Me.Caption
    Call Scheme.SetMousePointer
    Call HookSet(Me.hWnd, Me)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call Scheme.SaveScheme(TempSchemeFilename)
    Call DeleteDBuffer
    Call DeleteObject(hFont)
    Call HookClear(Me.hWnd, Me)
End Sub

Public Sub LoadFile(fName As String)
    Dim ir As Integer
    ir = Scheme.LoadScheme(fName)
    If ir <> IOErrOK Then
        Call MsgBox(Scheme.StatusText, vbCritical, Mainframe.Caption)
    End If
End Sub

Public Sub AddTo(ByRef Owner As MDIForm, title As String, visbl As Boolean, winsta As Integer)
    Me.Caption = title
    OriginalCaption = title
    Me.WindowState = winsta
    Me.Visible = visbl
    Call UpdateTitle
    TempSchemeFilename = ".\temp\" + OriginalCaption + Scheme.GetActualFileExt()
   'Call Scheme.LoadScheme(TempSchemeFilename)
    Call Scheme.DoDebugStuff
End Sub

Public Sub DrawBackBufer(ByVal hDc As Long)
    Call BitBlt(hDc, 0, 0, Me.ScaleWidth, Me.ScaleHeight, backDc, 0, 0, vbSrcCopy)
End Sub

Public Sub OnMouseWheel(keys As Integer, delta As Integer, xp As Long, yp As Long)
    Call Scheme.IncrementScale(CDbl(delta), keys)
    Call UpdateTitle
    Call InvalidateRectNull(hWnd, 0, 0)
End Sub

Private Sub Form_Resize()
    Call CreateDBuffer(Me.ScaleWidth, Me.ScaleHeight)
End Sub

Private Sub DeleteDBuffer()
    On Error Resume Next
    DeleteObject SelectObject(backDc, lastFont)
    DeleteObject SelectObject(backDc, backBmp)
    DeleteDC backDc
End Sub

Private Sub CreateDBuffer(cx As Integer, cy As Integer)
    On Error Resume Next
    
    Dim lfnt As Long
    Dim bmp As Long
    Dim dc As Long
    
    If cx < cxMinSize Then cx = cxMinSize
    If cy < cyMinSize Then cy = cyMinSize
   
    dc = CreateCompatibleDC(ByVal 0&)
    bmp = CreateBitmap(cx, cy, GetDeviceCaps(dc, PLANES), GetDeviceCaps(dc, BITSPIXEL), ByVal 0&)
    bmp = SelectObject(dc, bmp)
    
    DeleteObject hFont
    hFont = OLEFont2HFONT(Me.Font, dc)
    lfnt = SelectObject(dc, hFont)
    
    DeleteDBuffer

    backBmp = bmp
    backDc = dc
    lastFont = lfnt
        
    Call InvalidateRectNull(hWnd, 0, 0)
End Sub

Public Sub OnPaint()
    Dim rc As RECT
    Call GetClientRect(hWnd, rc)
    Call FillSolidRect(backDc, rc, DocBgColor)
    Call Scheme.Draw(backDc, Me.hWnd, 0, 0, rc.Right, rc.Bottom, pTool)
End Sub

Public Sub UpdateTitle()
    Me.Caption = OriginalCaption + " ^" + CStr(CInt(Scheme.GetScale() * 100#)) + "% " + Scheme.StatusText
End Sub

Private Sub Form_KeyDown(iCode As Integer, iKeys As Integer)
    ' TODO: configure keyboard shortcuts
    Select Case iCode
    Case 8 ' backspace - reset ZOOM only
        Call Scheme.ResetView(False, False)
        Call UpdateTitle
    Case Asc("G")
        Call Scheme.ToggleGridOnOff
    Case Asc("R")
        Call Scheme.ToggleRulesOnOff
    Case Asc("M")
        Call Scheme.IncrementMiceMode(iKeys)
    End Select
    
    Call InvalidateRectNull(hWnd, 0, 0)
End Sub

Private Sub Form_MouseDown(btnNum As Integer, iKeys As Integer, x As Single, y As Single)
    Call SetFocus
    
    Select Case btnNum
    Case vbLeftButton
        Call Scheme.HighlightByCoords(CLng(x), CLng(y))
        Call pTool.OnBegin(Scheme, CLng(x), CLng(y), iKeys)
        
    Case vbRightButton
        Call PopupMenu(Mainframe.mnuScheme, , x, y)
        
    Case vbMiddleButton
        Call SetCapture(Me.hWnd)
        DragOn = True
        Call Scheme.BeginDrag(iKeys, CLng(x), CLng(y))
    End Select
    
    InvalidateRectNull Me.hWnd, 0, 0
End Sub

Private Sub Form_MouseMove(btnNum As Integer, iKeys As Integer, x As Single, y As Single)
    Select Case btnNum
    Case vbMiddleButton
        If DragOn Then
            Call Scheme.Drag(iKeys, CLng(x), CLng(y))
        End If
    End Select
    
    Call pTool.OnMove(CLng(x), CLng(y), iKeys)
    Call InvalidateRectNull(Me.hWnd, 0, 0)
End Sub

Private Sub Form_MouseUp(btnNum As Integer, iKeys As Integer, x As Single, y As Single)
    Select Case btnNum
    Case vbLeftButton
        Call pTool.OnEnd(Scheme, CLng(x), CLng(y), iKeys)
    
    Case vbMiddleButton
        DragOn = False
        Call ReleaseCapture
        Call Scheme.EndDrag(iKeys, CLng(x), CLng(y))
        Call InvalidateRectNull(Me.hWnd, 0, 0)
    End Select
End Sub

