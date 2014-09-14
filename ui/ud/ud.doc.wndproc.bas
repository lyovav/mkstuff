Attribute VB_Name = "UdDocWndProc"
Option Explicit
DefInt A-Z

Private prevWindowProc As Long
Private owner As CDoc
Private dragOn As Boolean
Private keys As Integer
Private delta As Integer
Private xp As Long
Private yp As Long

Private Function UDocWndProc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    On Error Resume Next
    
    Select Case uMsg
        Case WM_MBUTTONDOWN
            keys = LowWord(wParam)
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            SetCapture hWnd
            dragOn = True
            owner.OnBeginDrag keys, xp, yp
            
        Case WM_MOUSEMOVE
            If dragOn = True Then
                keys = LowWord(wParam)
                xp = LowWord(lParam)
                yp = HighWord(lParam)
                owner.OnDrag keys, xp, yp
            End If
            InvalidateRectNull hWnd, 0, 0
            
        Case WM_MBUTTONUP
            keys = LowWord(wParam)
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            dragOn = False
            ReleaseCapture
            owner.OnEndDrag keys, xp, yp
            
        Case WM_MOUSEWHEEL
            keys = LowWord(wParam)
            delta = HighWord(wParam) / WHEEL_DELTA
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            owner.OnMouseWheel keys, delta, xp, yp
            
        Case WM_ERASEBKGND
            UDocWndProc = 1
            Exit Function
            
        Case WM_PAINT
            Dim hdc As Long
            Dim ps As PAINTSTRUCT

            hdc = BeginPaint(hWnd, ps)
            owner.OnPaint
            owner.DrawBackBufer hdc
            EndPaint hWnd, ps
            
            UDocWndProc = 0
            
        Case Else
            If prevWindowProc <> 0 Then
                UDocWndProc = CallWindowProcA(prevWindowProc, hWnd, uMsg, wParam, lParam)
            End If
    End Select
End Function

Public Sub InstallUDocWndProc(ByRef frm As CDoc)
    On Error GoTo Error
    
    dragOn = False
    keys = 0
    delta = 0
    xp = 0
    yp = 0
    
    Set owner = frm
    prevWindowProc = SetWindowLongA(owner.hWnd, GWL_WNDPROC, AddressOf UDocWndProc)
    
    Exit Sub
    
Error:
    Resume Next
End Sub

