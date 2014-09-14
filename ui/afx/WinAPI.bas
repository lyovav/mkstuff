Attribute VB_Name = "WinAPI"
Option Explicit
DefInt A-Z

' USER32
Public Declare Function GetSystemMetrics Lib "USER32" (ByVal n As Integer) As Integer
Public Declare Function SendMessageA Lib "USER32" (ByVal hwnd As Long, ByVal message As Integer, ByVal wParam As Integer, ByVal lParam As Long) As Long
Public Declare Function SendMessageW Lib "USER32" (ByVal hwnd As Long, ByVal message As Integer, ByVal wParam As Integer, ByVal lParam As Long) As Long
Public Declare Function SetWindowLongA Lib "USER32" (ByVal hwnd As Long, ByVal index As Integer, ByVal value As Long) As Long
Public Declare Function GetWindowLongA Lib "USER32" (ByVal hwnd As Long, ByVal index As Integer) As Long
Public Declare Function SetWindowLongW Lib "USER32" (ByVal hwnd As Long, ByVal index As Integer, ByVal value As Long) As Long
Public Declare Function GetWindowLongW Lib "USER32" (ByVal hwnd As Long, ByVal index As Integer) As Long
Public Declare Function SetTimer Lib "USER32" (ByVal hwnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerFunc As Long) As Long
Public Declare Function KillTimer Lib "USER32" (ByVal hwnd As Long, ByVal nIDEvent As Long) As Long
Public Declare Function GetParent Lib "USER32" (ByVal hwnd As Long) As Long
Public Declare Function GetDesktopWindow Lib "USER32" () As Long
Public Declare Function GetClientRect Lib "USER32" (ByVal hwnd As Long, ByRef lpRect As RECT) As Long
Public Declare Function InvalidateRect Lib "USER32" (ByVal hwnd As Long, ByRef lpRect As RECT, ByVal bErase As Integer) As Long
Public Declare Function InvalidateRectNull Lib "USER32" Alias "InvalidateRect" (ByVal hwnd As Long, ByVal lpRect As Long, ByVal bErase As Integer) As Long
Public Declare Function DrawTextA Lib "USER32" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, ByRef lpRect As RECT, ByVal wFormat As Long) As Long
Public Declare Function OffsetRect Lib "USER32" (ByRef lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Public Declare Function CallWindowProcA Lib "USER32" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function SetCapture Lib "USER32" (ByVal hwnd As Long) As Long
Public Declare Function GetCapture Lib "USER32" () As Long
Public Declare Function ReleaseCapture Lib "USER32" () As Long
Public Declare Function BeginPaint Lib "USER32" (ByVal hwnd As Long, ByRef lpPaint As PAINTSTRUCT) As Long
Public Declare Function EndPaint Lib "USER32" (ByVal hwnd As Long, ByRef lpPaint As PAINTSTRUCT) As Long

' KERNEL32
Public Declare Function FindFirstFileA Lib "KERNEL32" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATAA) As Long
Public Declare Function FindNextFileA Lib "KERNEL32" (ByVal hFindFile As Long, lpFindFileData As WIN32_FIND_DATAA) As Long
Public Declare Function GetFileAttributesA Lib "KERNEL32" (ByVal lpFileName As String) As Long
Public Declare Function FindClose Lib "KERNEL32" (ByVal hFindFile As Long) As Long
Public Declare Function FileTimeToLocalFileTime Lib "KERNEL32" (lpFileTime As FILETIME, lpLocalFileTime As FILETIME) As Long
Public Declare Function FileTimeToSystemTime Lib "KERNEL32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME) As Long
Public Declare Function CreateThread Lib "KERNEL32" (ByVal lpSecurityAttributes As Long, ByVal dwStackSize As Long, ByVal lpStartAddress As Long, ByVal lpParameter As Long, ByVal dwCreationFlags As Long, lpThreadId As Long) As Long
Public Declare Function CloseHandle Lib "KERNEL32" (ByVal hObject As Long) As Long
Public Declare Function MulDiv Lib "KERNEL32" (ByVal nNumber As Long, ByVal nNumerator As Long, ByVal nDenominator As Long) As Long

' GDI32
Public Declare Function GetStockObject Lib "GDI32" (ByVal index As Integer) As Long
Public Declare Function CreateCompatibleDC Lib "GDI32" (ByVal hdc As Long) As Long
Public Declare Function OleCreatePictureIndirect Lib "olepro32.dll" (PicDesc As PICTDESC, RefIID As GUID, ByVal fPictureOwnsHandle As Long, IPic As IPicture) As Long
Public Declare Function CreateCompatibleBitmap Lib "GDI32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Public Declare Function GetDeviceCaps Lib "GDI32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Public Declare Function PatBlt Lib "GDI32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal dwRop As Long) As Long
Public Declare Function BitBlt Lib "GDI32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal sx As Long, ByVal sy As Long, ByVal dwRop As Long) As Long
Public Declare Function CreateBitmap Lib "GDI32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
Public Declare Function SelectObject Lib "GDI32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function CreateSolidBrush Lib "GDI32" (ByVal crColor As Long) As Long
Public Declare Function DeleteObject Lib "GDI32" (ByVal hObject As Long) As Long
Public Declare Function DeleteDC Lib "GDI32" (ByVal hdc As Long) As Long
Public Declare Function ExtTextOutA Lib "GDI32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal wOptions As Long, ByRef lpRect As RECT, ByVal lpString As String, ByVal nCount As Long, lpDx As Long) As Long
Public Declare Function SetBkColor Lib "GDI32" (ByVal hdc As Long, ByVal color As Long) As Long
Public Declare Function GetDC Lib "GDI32" (ByVal hwnd As Long) As Long
Public Declare Function ReleaseDC Lib "GDI32" (ByVal hwnd As Long, ByVal hdc As Long) As Long
Public Declare Function GetWindowDC Lib "GDI32" (ByVal hwnd As Long) As Long
Public Declare Function MoveToEx Lib "GDI32" (ByVal hdc As Long, ByVal x As Integer, ByVal y As Integer, ByRef lppt As APOINT) As Long
Public Declare Function LineTo Lib "GDI32" (ByVal hdc As Long, ByVal x As Integer, ByVal y As Integer) As Integer
Public Declare Function MoveToExNull Lib "GDI32" Alias "MoveToEx" (ByVal hdc As Long, ByVal x As Integer, ByVal y As Integer, ByVal lppt As Long) As Long
Public Declare Function SetBkMode Lib "GDI32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long
Public Declare Function SetTextColor Lib "GDI32" (ByVal hdc As Long, ByVal color As Long) As Long
Public Declare Function CreateFontIndirectA Lib "GDI32" (ByRef lpLogFont As LOGFONT) As Long
Public Declare Function CreatePen Lib "GDI32" (ByVal penStyle As Long, ByVal Width As Long, ByVal color As Long) As Long
Public Declare Function Rectangle Lib "GDI32" (ByVal hdc As Long, ByVal rectLeft As Long, ByVal rectTop As Long, ByVal rectRight As Long, ByVal rectBottom As Long) As Long
Public Declare Function CreateFontA Lib "GDI32" (ByVal nHeight As Long, ByVal nWidth As Long, ByVal nEscapement As Long, ByVal nOrientation As Long, ByVal fnWeight As Long, ByVal fdwItalic As Boolean, ByVal fdwUnderline As Boolean, ByVal fdwStrikeOut As Boolean, ByVal fdwCharSet As Long, ByVal fdwOutputPrecision As Long, ByVal fdwClipPrecision As Long, ByVal fdwQuality As Long, ByVal fdwPitchAndFamily As Long, ByVal lpszFace As String) As Long

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

Public Sub FillSolidRect(ByVal hdc As Long, ByRef lpRect As RECT, ByVal clr As Long)
    Dim lastColor As Long
    lastColor = SetBkColor(hdc, clr)
    ExtTextOutA hdc, 0, 0, ETO_OPAQUE, lpRect, 0, 0, 0
    SetBkColor hdc, lastColor
End Sub

Public Sub ALine(ByVal hdc As Long, ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long)
    MoveToExNull hdc, x1, y1, 0
    LineTo hdc, x2, y2
End Sub

Public Sub ARect(ByVal hdc As Long, ByRef rc As RECT)
    Dim pt As APOINT
    MoveToEx hdc, rc.Left, rc.Top, pt
    LineTo hdc, rc.Right, rc.Top
    LineTo hdc, rc.Right, rc.Bottom
    LineTo hdc, rc.Left, rc.Bottom
    LineTo hdc, rc.Left, rc.Top
End Sub

Public Sub OLEFont2LOGFONT(fnt As StdFont, ByVal hdc As Long, ByRef lfont As LOGFONT)
    Dim i As Integer

    With lfont
        For i = 1 To Len(fnt.name)
            .lfFaceName(i - 1) = Asc(Mid(fnt.name, i, 1))
        Next i
        .lfHeight = -MulDiv((fnt.size), (GetDeviceCaps(hdc, LOGPIXELSY)), 72)
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

Public Function OLEFont2HFONT(fnt As StdFont, ByVal hdc As Long) As Long
    Dim lfont As LOGFONT
    Dim rv As Long
    
    OLEFont2LOGFONT fnt, hdc, lfont
    rv = CreateFontIndirectA(lfont)
    
    OLEFont2HFONT = rv
End Function

Public Sub Invalidate(ByRef frm As Form, Optional bErase As Integer = 0)
    InvalidateRectNull frm.hwnd, 0, bErase
End Sub

Public Function MoveTo(ByVal dc As Long, ByVal x As Integer, ByVal y As Integer) As Integer
    MoveTo = MoveToExNull(dc, x, y, 0)
End Function
