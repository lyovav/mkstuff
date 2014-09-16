Attribute VB_Name = "WinAPI"
Option Explicit
DefInt A-Z

' KERNEL32
Public Declare Function GetLastError Lib "KERNEL32" () As Long
Public Declare Function GetModuleHandleA Lib "KERNEL32" (ByVal lpFileName As String) As Long
Public Declare Function GetModuleHandleANull Lib "KERNEL32" Alias "GetModuleHandleA" (ByVal lpFileName As Long) As Long
Public Declare Function FindFirstFileA Lib "KERNEL32" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATAA) As Long
Public Declare Function FindNextFileA Lib "KERNEL32" (ByVal hFindFile As Long, lpFindFileData As WIN32_FIND_DATAA) As Long
Public Declare Function GetFileAttributesA Lib "KERNEL32" (ByVal lpFileName As String) As Long
Public Declare Function FindClose Lib "KERNEL32" (ByVal hFindFile As Long) As Long
Public Declare Function FileTimeToLocalFileTime Lib "KERNEL32" (lpFileTime As FILETIME, lpLocalFileTime As FILETIME) As Long
Public Declare Function FileTimeToSystemTime Lib "KERNEL32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME) As Long
Public Declare Function CreateThread Lib "KERNEL32" (ByVal lpSecurityAttributes As Long, ByVal dwStackSize As Long, ByVal lpStartAddress As Long, ByVal lpParameter As Long, ByVal dwCreationFlags As Long, lpThreadId As Long) As Long
Public Declare Function CloseHandle Lib "KERNEL32" (ByVal hObject As Long) As Long
Public Declare Function MulDiv Lib "KERNEL32" (ByVal nNumber As Long, ByVal nNumerator As Long, ByVal nDenominator As Long) As Long
Public Declare Function GetPrivateProfileStringA Lib "KERNEL32" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Public Declare Function CreateFileA Lib "KERNEL32" (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long
Public Declare Function WriteFile Lib "KERNEL32" (ByVal hFile As Long, ByVal lpBuffer As Long, ByVal nLen As Long, ByRef nWritten As Long, ByVal lpOverlapped As Long) As Long
Public Declare Function SetFilePointer Lib "KERNEL32" (ByVal hFile As Long, ByVal lDist As Long, ByRef lpDistHigh As Long, ByVal dwMoveMethod As Long) As Long
Public Declare Function SetFilePointerNull Lib "KERNEL32" Alias "SetFilePointer" (ByVal hFile As Long, ByVal lDist As Long, ByVal lpDistHigh As Long, ByVal dwMoveMethod As Long) As Long
Public Declare Function GetFileSize Lib "KERNEL32" (ByVal hFile As Long, ByRef lpHigh As Long) As Long
Public Declare Function GetFileSizeNull Lib "KERNEL32" Alias "GetFileSize" (ByVal hFile As Long, ByVal lpHigh As Long) As Long
Public Declare Function ReadFile Lib "KERNEL32" (ByVal hFile As Long, ByVal lpBuffer As Long, ByVal nLen As Long, ByRef lpnRead As Long, ByVal lpOverlapped As Long) As Long

' USER32
Public Declare Function GetSystemMetrics Lib "USER32" (ByVal n As Integer) As Integer
Public Declare Function SendMessageA Lib "USER32" (ByVal hWnd As Long, ByVal message As Integer, ByVal wParam As Integer, ByVal lParam As Long) As Long
Public Declare Function SendMessageW Lib "USER32" (ByVal hWnd As Long, ByVal message As Integer, ByVal wParam As Integer, ByVal lParam As Long) As Long
Public Declare Function SetWindowLongA Lib "USER32" (ByVal hWnd As Long, ByVal index As Integer, ByVal value As Long) As Long
Public Declare Function GetWindowLongA Lib "USER32" (ByVal hWnd As Long, ByVal index As Integer) As Long
Public Declare Function SetWindowLongW Lib "USER32" (ByVal hWnd As Long, ByVal index As Integer, ByVal value As Long) As Long
Public Declare Function GetWindowLongW Lib "USER32" (ByVal hWnd As Long, ByVal index As Integer) As Long
Public Declare Function SetTimer Lib "USER32" (ByVal hWnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerFunc As Long) As Long
Public Declare Function KillTimer Lib "USER32" (ByVal hWnd As Long, ByVal nIDEvent As Long) As Long
Public Declare Function GetParent Lib "USER32" (ByVal hWnd As Long) As Long
Public Declare Function GetDesktopWindow Lib "USER32" () As Long
Public Declare Function GetClientRect Lib "USER32" (ByVal hWnd As Long, ByRef lpRect As RECT) As Long
Public Declare Function InvalidateRect Lib "USER32" (ByVal hWnd As Long, ByRef lpRect As RECT, ByVal bErase As Integer) As Long
Public Declare Function InvalidateRectNull Lib "USER32" Alias "InvalidateRect" (ByVal hWnd As Long, ByVal lpRect As Long, ByVal bErase As Integer) As Long
Public Declare Function DrawTextA Lib "USER32" (ByVal hDC As Long, ByVal lpStr As String, ByVal nCount As Long, ByRef lpRect As RECT, ByVal wFormat As Long) As Long
Public Declare Function OffsetRect Lib "USER32" (ByRef lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Public Declare Function CallWindowProcA Lib "USER32" (ByVal lpPrevWndFunc As Long, ByVal hWnd As Long, ByVal msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function SetCapture Lib "USER32" (ByVal hWnd As Long) As Long
Public Declare Function GetCapture Lib "USER32" () As Long
Public Declare Function ReleaseCapture Lib "USER32" () As Long
Public Declare Function BeginPaint Lib "USER32" (ByVal hWnd As Long, ByRef lpPaint As PAINTSTRUCT) As Long
Public Declare Function EndPaint Lib "USER32" (ByVal hWnd As Long, ByRef lpPaint As PAINTSTRUCT) As Long
Public Declare Function GetCursorPos Lib "USER32" (ByRef lpPoint As APOINT) As Long
Public Declare Function SetCursorPos Lib "USER32" (ByVal x As Long, ByVal y As Long) As Long
Public Declare Function ScreenToClient Lib "USER32" (ByVal hWnd As Long, ByRef pn As APOINT) As Long
Public Declare Function InflateRect Lib "USER32" (ByRef lpRect As RECT, ByVal dx As Long, ByVal dy As Long) As Long
Public Declare Function SetCursor Lib "USER32" (ByVal hCursor As Long) As Long
Public Declare Function LoadCursorA Lib "USER32" (ByVal hInstance As Long, ByVal lpCursorName As Long) As Long

' GDI32
Public Declare Function GetStockObject Lib "GDI32" (ByVal index As Integer) As Long
Public Declare Function CreateCompatibleDC Lib "GDI32" (ByVal hDC As Long) As Long
Public Declare Function OleCreatePictureIndirect Lib "olepro32.dll" (PicDesc As PICTDESC, RefIID As GUID, ByVal fPictureOwnsHandle As Long, IPic As IPicture) As Long
Public Declare Function CreateCompatibleBitmap Lib "GDI32" (ByVal hDC As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Public Declare Function GetDeviceCaps Lib "GDI32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
Public Declare Function PatBlt Lib "GDI32" (ByVal hDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal dwRop As Long) As Long
Public Declare Function BitBlt Lib "GDI32" (ByVal hDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal sx As Long, ByVal sy As Long, ByVal dwRop As Long) As Long
Public Declare Function CreateBitmap Lib "GDI32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
Public Declare Function SelectObject Lib "GDI32" (ByVal hDC As Long, ByVal hObject As Long) As Long
Public Declare Function CreateSolidBrush Lib "GDI32" (ByVal crColor As Long) As Long
Public Declare Function DeleteObject Lib "GDI32" (ByVal hObject As Long) As Long
Public Declare Function DeleteDC Lib "GDI32" (ByVal hDC As Long) As Long
Public Declare Function ExtTextOutA Lib "GDI32" (ByVal hDC As Long, ByVal x As Long, ByVal y As Long, ByVal wOptions As Long, ByRef lpRect As RECT, ByVal lpString As String, ByVal nCount As Long, lpDx As Long) As Long
Public Declare Function SetBkColor Lib "GDI32" (ByVal hDC As Long, ByVal color As Long) As Long
Public Declare Function GetDC Lib "GDI32" (ByVal hWnd As Long) As Long
Public Declare Function ReleaseDC Lib "GDI32" (ByVal hWnd As Long, ByVal hDC As Long) As Long
Public Declare Function GetWindowDC Lib "GDI32" (ByVal hWnd As Long) As Long
Public Declare Function MoveToEx Lib "GDI32" (ByVal hDC As Long, ByVal x As Integer, ByVal y As Integer, ByRef lppt As APOINT) As Long
Public Declare Function LineTo Lib "GDI32" (ByVal hDC As Long, ByVal x As Integer, ByVal y As Integer) As Integer
Public Declare Function MoveToExNull Lib "GDI32" Alias "MoveToEx" (ByVal hDC As Long, ByVal x As Integer, ByVal y As Integer, ByVal lppt As Long) As Long
Public Declare Function SetBkMode Lib "GDI32" (ByVal hDC As Long, ByVal nBkMode As Long) As Long
Public Declare Function SetTextColor Lib "GDI32" (ByVal hDC As Long, ByVal color As Long) As Long
Public Declare Function CreateFontIndirectA Lib "GDI32" (ByRef lpLogFont As LOGFONT) As Long
Public Declare Function CreatePen Lib "GDI32" (ByVal penStyle As Long, ByVal Width As Long, ByVal color As Long) As Long
Public Declare Function Rectangle Lib "GDI32" (ByVal hDC As Long, ByVal rectLeft As Long, ByVal rectTop As Long, ByVal rectRight As Long, ByVal rectBottom As Long) As Long
Public Declare Function CreateFontA Lib "GDI32" (ByVal nHeight As Long, ByVal nWidth As Long, ByVal nEscapement As Long, ByVal nOrientation As Long, ByVal fnWeight As Long, ByVal fdwItalic As Boolean, ByVal fdwUnderline As Boolean, ByVal fdwStrikeOut As Boolean, ByVal fdwCharSet As Long, ByVal fdwOutputPrecision As Long, ByVal fdwClipPrecision As Long, ByVal fdwQuality As Long, ByVal fdwPitchAndFamily As Long, ByVal lpszFace As String) As Long
Public Declare Function Ellipse Lib "GDI32" (ByVal hDC As Long, ByVal x As Long, ByVal y As Long, ByVal rx As Long, ByVal by As Long) As Long

Public Function StripNulls(str As String) As String
    Dim zp As Integer
    zp = InStr(str, Chr(0))
    If (zp > 0) Then
        str = Left(str, zp - 1)
    End If
    StripNulls = str
End Function

Public Function LowWord(ByVal inDWord As Long) As Integer
    LowWord = inDWord And &H7FFF&
    If (inDWord And &H8000&) Then LowWord = LowWord Or &H8000
End Function

Public Function HighWord(ByVal inDWord As Long) As Integer
    HighWord = LowWord(((inDWord And &HFFFF0000) \ &H10000) And &HFFFF&)
End Function

Public Function ProcPtr(ByVal nAddress As Long) As Long
    ProcPtr = nAddress
End Function

Public Sub FillSolidRect(ByVal hDC As Long, ByRef lpRect As RECT, ByVal clr As Long)
    Dim lastColor As Long
    lastColor = SetBkColor(hDC, clr)
    ExtTextOutA hDC, 0, 0, ETO_OPAQUE, lpRect, 0, 0, 0
    SetBkColor hDC, lastColor
End Sub

Public Sub ALineChecked(ByVal hDC As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long)
    If x1 < 0 Then x1 = 0
    If y1 < 0 Then y1 = 0
    If x2 < 0 Then x2 = 0
    If y2 < 0 Then y2 = 0
    
    MoveToExNull hDC, x1, y1, 0
    LineTo hDC, x2, y2
End Sub

Public Sub ALine(ByVal hDC As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long)
    MoveToExNull hDC, x1, y1, 0
    LineTo hDC, x2, y2
End Sub

Public Sub ARect(ByVal hDC As Long, ByRef rc As RECT)
    Dim pt As APOINT
    MoveToEx hDC, rc.Left, rc.Top, pt
    LineTo hDC, rc.Right, rc.Top
    LineTo hDC, rc.Right, rc.Bottom
    LineTo hDC, rc.Left, rc.Bottom
    LineTo hDC, rc.Left, rc.Top
End Sub

Public Sub OLEFont2LOGFONT(fnt As StdFont, ByVal hDC As Long, ByRef lfont As LOGFONT)
    Dim i As Integer

    With lfont
        For i = 1 To Len(fnt.name)
            .lfFaceName(i - 1) = Asc(Mid(fnt.name, i, 1))
        Next i
        .lfHeight = -MulDiv((fnt.size), (GetDeviceCaps(hDC, LOGPIXELSY)), 72)
        .lfItalic = fnt.Italic
        If (fnt.Bold) Then
          .lfWeight = FW_BOLD
        Else
          .lfWeight = FW_NORMAL
        End If
        .lfUnderline = fnt.Underline
        .lfStrikeOut = fnt.Strikethrough
        .lfCharSet = fnt.Charset
    End With
End Sub

Public Function OLEFont2HFONT(fnt As StdFont, ByVal hDC As Long) As Long
    Dim lfont As LOGFONT
    Dim rv As Long
    
    OLEFont2LOGFONT fnt, hDC, lfont
    rv = CreateFontIndirectA(lfont)
    
    OLEFont2HFONT = rv
End Function

Public Sub Invalidate(ByRef frm As Form, Optional bErase As Integer = 0)
    InvalidateRectNull frm.hWnd, 0, bErase
End Sub

Public Function MoveTo(ByVal dc As Long, ByVal x As Integer, ByVal y As Integer) As Integer
    MoveTo = MoveToExNull(dc, x, y, 0)
End Function

Public Function GetIniString(ByVal sHeading As String, ByVal sKey As String, sINIFileName As String) As String
    Const cparmLen = 50
    
    Dim sReturn As String * cparmLen
    Dim sDefault As String * cparmLen
    Dim lLength As Long
    
    lLength = GetPrivateProfileStringA(sHeading, sKey, sDefault, sReturn, cparmLen, sINIFileName)
    
    GetIniString = Mid(sReturn, 1, lLength)
End Function

Public Sub EllipseRc(ByVal dc As Long, ByRef rc As RECT)
    Ellipse dc, rc.Left, rc.Top, rc.Right, rc.Bottom
End Sub

Public Function InitRECT(ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long) As RECT
    Dim rc As RECT
    
    With rc
        .Left = x
        .Top = y
        .Right = .Left + cx
        .Bottom = .Top + cy
    End With
    
    InitRECT = rc
End Function

Public Function RWidth(ByRef rc As RECT) As Long
    RWidth = rc.Right - rc.Left
End Function

Public Function RHeight(ByRef rc As RECT) As Long
    RHeight = rc.Bottom - rc.Top
End Function

Public Function CreateEmptySECURITY_ATTRIBUTES() As SECURITY_ATTRIBUTES
    Dim rv As SECURITY_ATTRIBUTES
    
    rv.bInheritHandle = 0
    rv.lpSecurityDescriptor = 0
    rv.nLength = Len(rv)
    
    CreateEmptySECURITY_ATTRIBUTES = rv
End Function

Public Function CreateEmptyOVERLAPPED() As OVERLAPPED
    Dim rv As OVERLAPPED
    
    rv.Internal = 0
    rv.InternalHigh = 0
    rv.Offset = 0
    rv.OffsetHigh = 0
    rv.hEvent = 0
   
    CreateEmptyOVERLAPPED = rv
End Function

