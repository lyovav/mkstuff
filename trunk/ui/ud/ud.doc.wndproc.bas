Attribute VB_Name = "UdDocWndProc"
Option Explicit
DefInt A-Z

Private formId As Long
Private Owner() As CDoc

Public Sub InstallCDocWndProc(ByRef frm As CDoc)
    On Error GoTo Error
    
    formId = formId + 1
    ReDim Preserve Owner(1 To formId) As CDoc
    Set Owner(formId) = frm
  
    SetWindowLongA Owner(formId).hWnd, GWL_USERDATA, formId
    Owner(formId).PrevWndProc = SetWindowLongA(Owner(formId).hWnd, GWL_WNDPROC, AddressOf WndProc)
    
    Exit Sub
    
Error:
    MsgBox Err.Description
    ' Resume Next
End Sub

Private Function WndProc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
    On Error Resume Next
    
    Dim delta As Integer, keys As Integer
    Dim xp As Long, yp As Long
    Dim Id As Long
    
    Id = GetWindowLongA(hWnd, GWL_USERDATA)
    
    Select Case uMsg
    Case WM_MBUTTONDOWN
        keys = LowWord(wParam)
        xp = LowWord(lParam)
        yp = HighWord(lParam)
        SetCapture hWnd
        Owner(Id).SetFocus
        Owner(Id).DragOn = True
        Owner(Id).OnBeginDrag keys, xp, yp
        
    Case WM_MOUSEMOVE
        If Owner(Id).DragOn = True Then
            keys = LowWord(wParam)
            xp = LowWord(lParam)
            yp = HighWord(lParam)
            Owner(Id).OnDrag keys, xp, yp
        Else
            InvalidateRectNull hWnd, 0, 0
        End If
        
    Case WM_MBUTTONUP
        keys = LowWord(wParam)
        xp = LowWord(lParam)
        yp = HighWord(lParam)
        Owner(Id).DragOn = False
        ReleaseCapture
        Owner(Id).OnEndDrag keys, xp, yp
        
    Case WM_MOUSEWHEEL
        keys = LowWord(wParam)
        delta = HighWord(wParam) / WHEEL_DELTA
        xp = LowWord(lParam)
        yp = HighWord(lParam)
        Owner(Id).OnMouseWheel keys, delta, xp, yp
        
    Case WM_ERASEBKGND
        WndProc = 1
        Exit Function
        
    Case WM_PAINT
        Dim hDC As Long
        Dim ps As PAINTSTRUCT

        hDC = BeginPaint(hWnd, ps)
        Owner(Id).OnPaint
        Owner(Id).DrawBackBufer hDC
        EndPaint hWnd, ps
       
    Case Else
        WndProc = CallWindowProcA(Owner(Id).PrevWndProc, hWnd, uMsg, wParam, lParam)
        Exit Function
    End Select
    
    WndProc = 0
End Function
