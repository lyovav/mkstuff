Attribute VB_Name = "UdDocWndProc"
Option Explicit
DefInt A-Z

Private prevWindowProc As Long
Private owner As CDoc

Private Function UDocWndProc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    Dim keys As Long
    Dim delta As Integer
    Dim xp As Long
    Dim yp As Long
    Dim dragOn As Boolean

    Select Case uMsg
        Case WM_MBUTTONDOWN
            keys = wParam And &HFFFF
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            SetCapture hWnd
            dragOn = True
            owner.OnBeginDrag keys, xp, yp
            
        Case WM_MOUSEMOVE
            If dragOn = True Then
                keys = wParam And &HFFFF
                xp = LowWord(lParam)
                yp = HighWord(lParam)
                owner.OnDrag keys, xp, yp
            End If
            
        Case WM_MBUTTONUP
            keys = wParam And &HFFFF
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            dragOn = False
            ReleaseCapture
            owner.OnEndDrag keys, xp, yp
            
        Case WM_MOUSEWHEEL
            keys = wParam And &HFFFF
            delta = wParam / 65535 / WHEEL_DELTA
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            owner.OnMouseWheel keys, delta, xp, yp
            
        Case WM_ERASEBKGND
            UDocWndProc = 1
            Exit Function
    End Select
    
    If prevWindowProc <> 0 Then
        UDocWndProc = CallWindowProcA(prevWindowProc, hWnd, uMsg, wParam, lParam)
    End If
End Function

Public Sub InstallUDocWndProc(ByRef frm As CDoc)
    On Error GoTo Error
    
    Set owner = frm
    prevWindowProc = SetWindowLongA(owner.hWnd, GWL_WNDPROC, AddressOf UDocWndProc)
    
    Exit Sub
    
Error:
    Resume Next
End Sub

