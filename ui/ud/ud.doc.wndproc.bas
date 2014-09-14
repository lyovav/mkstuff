Attribute VB_Name = "UdDocWndProc"
Option Explicit
DefInt A-Z

Private prevWindowProc As Long
Private owner As CDoc
Private dragOn As Boolean

Private Function UDocWndProc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    Dim keys As Integer
    Dim delta As Integer
    Dim xp As Long
    Dim yp As Long
    
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
    End Select
    
    If prevWindowProc <> 0 Then
        UDocWndProc = CallWindowProcA(prevWindowProc, hWnd, uMsg, wParam, lParam)
    End If
End Function

Public Sub InstallUDocWndProc(ByRef frm As CDoc)
    On Error GoTo Error
    
    dragOn = False
    
    Set owner = frm
    prevWindowProc = SetWindowLongA(owner.hWnd, GWL_WNDPROC, AddressOf UDocWndProc)
    
    Exit Sub
    
Error:
    Resume Next
End Sub

