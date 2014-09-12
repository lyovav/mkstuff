Attribute VB_Name = "WinAPI"
Option Explicit
DefInt A-Z

Public Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Public Type APOINT
    x As Long
    y As Long
End Type

Public Const WM_ERASEBKGND = &H14

Public Const WM_MOUSEWHEEL = &H20A
Public Const WM_MBUTTONUP = &H208
Public Const WM_MBUTTONDOWN = &H207
Public Const WM_MBUTTONDBLCLK = &H209
Public Const WM_LBUTTONDOWN = &H201
Public Const WM_LBUTTONUP = &H202
Public Const WM_RBUTTONUP = &H205

Public Const MK_LBUTTON = &H1
Public Const MK_MBUTTON = &H10
Public Const MK_RBUTTON = &H2

Public Const WH_MOUSE = 7
Public Const WHEEL_DELTA = 120

Public Const WM_VSCROLL = &H115
Public Const WM_USER As Long = &H400
Public Const WM_SOMETHING = WM_USER + 3139

Public Const DT_TOP = &H0
Public Const DT_LEFT = &H0
Public Const DT_CENTER = &H1
Public Const DT_RIGHT = &H2
Public Const DT_VCENTER = &H4
Public Const DT_BOTTOM = &H8
Public Const DT_WORDBREAK = &H10
Public Const DT_SINGLELINE = &H20
Public Const DT_EXPANDTABS = &H40
Public Const DT_TABSTOP = &H80
Public Const DT_NOCLIP = &H100
Public Const DT_EXTERNALLEADING = &H200
Public Const DT_CALCRECT = &H400
Public Const DT_NOPREFIX = &H800
Public Const DT_INTERNAL = &H1000
Public Const DT_EDITCONTROL = &H2000
Public Const DT_PATH_ELLIPSIS = &H4000
Public Const DT_END_ELLIPSIS = &H8000
Public Const DT_MODIFYSTRING = &H10000
Public Const DT_RTLREADING = &H20000
Public Const DT_WORD_ELLIPSIS = &H40000

Public Const SM_CXSCREEN            As Integer = 0
Public Const SM_CYSCREEN            As Integer = 1
Public Const SM_CXVSCROLL           As Integer = 2
Public Const SM_CYHSCROLL           As Integer = 3
Public Const SM_CYCAPTION           As Integer = 4
Public Const SM_CXBORDER            As Integer = 5
Public Const SM_CYBORDER            As Integer = 6
Public Const SM_CXDLGFRAME          As Integer = 7
Public Const SM_CYDLGFRAME          As Integer = 8
Public Const SM_CYVTHUMB            As Integer = 9
Public Const SM_CXHTHUMB            As Integer = 10
Public Const SM_CXICON              As Integer = 11
Public Const SM_CYICON              As Integer = 12
Public Const SM_CXCURSOR            As Integer = 13
Public Const SM_CYCURSOR            As Integer = 14
Public Const SM_CYMENU              As Integer = 15
Public Const SM_CXFULLSCREEN        As Integer = 16
Public Const SM_CYFULLSCREEN        As Integer = 17
Public Const SM_CYKANJIWINDOW       As Integer = 18
Public Const SM_MOUSEPRESENT        As Integer = 19
Public Const SM_CYVSCROLL           As Integer = 20
Public Const SM_CXHSCROLL           As Integer = 21
Public Const SM_DEBUG               As Integer = 22
Public Const SM_SWAPBUTTON          As Integer = 23
Public Const SM_RESERVED1           As Integer = 24
Public Const SM_RESERVED2           As Integer = 25
Public Const SM_RESERVED3           As Integer = 26
Public Const SM_RESERVED4           As Integer = 27
Public Const SM_CXMIN               As Integer = 28
Public Const SM_CYMIN               As Integer = 29
Public Const SM_CXSIZE              As Integer = 30
Public Const SM_CYSIZE              As Integer = 31
Public Const SM_CXFRAME             As Integer = 32
Public Const SM_CYFRAME             As Integer = 33
Public Const SM_CXMINTRACK          As Integer = 34
Public Const SM_CYMINTRACK          As Integer = 35
Public Const SM_CXDOUBLECLK         As Integer = 36
Public Const SM_CYDOUBLECLK         As Integer = 37
Public Const SM_CXICONSPACING       As Integer = 38
Public Const SM_CYICONSPACING       As Integer = 39
Public Const SM_MENUDROPALIGNMENT   As Integer = 40
Public Const SM_PENWINDOWS          As Integer = 41
Public Const SM_DBCSENABLED         As Integer = 42
Public Const SM_CMOUSEBUTTONS       As Integer = 43

Public Const GWL_EXSTYLE            As Integer = -20
Public Const GWL_HINSTANCE          As Integer = -6
Public Const GWL_ID                 As Integer = -12
Public Const GWL_STYLE              As Integer = -16
Public Const GWL_USERDATA           As Integer = -21
Public Const GWL_WNDPROC            As Integer = -4

Public Const SS_LEFT                As Long = &H0
Public Const SS_CENTER              As Long = &H1
Public Const SS_RIGHT               As Long = &H2
Public Const SS_ICON                As Long = &H3
Public Const SS_BLACKRECT           As Long = &H4
Public Const SS_GRAYRECT            As Long = &H5
Public Const SS_WHITERECT           As Long = &H6
Public Const SS_BLACKFRAME          As Long = &H7
Public Const SS_GRAYFRAME           As Long = &H8
Public Const SS_WHITEFRAME          As Long = &H9
Public Const SS_USERITEM            As Long = &HA
Public Const SS_SIMPLE              As Long = &HB
Public Const SS_LEFTNOWORDWRAP      As Long = &HC
Public Const SS_OWNERDRAW           As Long = &HD
Public Const SS_BITMAP              As Long = &HE
Public Const SS_ENHMETAFILE         As Long = &HF
Public Const SS_ETCHEDHORZ          As Long = &H10
Public Const SS_ETCHEDVERT          As Long = &H11
Public Const SS_ETCHEDFRAME         As Long = &H12
Public Const SS_TYPEMASK            As Long = &H1F
Public Const SS_REALSIZECONTROL     As Long = &H40
Public Const SS_NOPREFIX            As Long = &H80
Public Const SS_NOTIFY              As Long = &H100
Public Const SS_CENTERIMAGE         As Long = &H200
Public Const SS_RIGHTJUST           As Long = &H400
Public Const SS_REALSIZEIMAGE       As Long = &H800
Public Const SS_SUNKEN              As Long = &H1000
Public Const SS_EDITCONTROL         As Long = &H2000
Public Const SS_ENDELLIPSIS         As Long = &H4000
Public Const SS_PATHELLIPSIS        As Long = &H8000
Public Const SS_WORDELLIPSIS        As Long = &HC000
Public Const SS_ELLIPSISMASK        As Long = &HC000

Public Const MAX_PATH = 260
Public Const MAXDWORD = &HFFFF
Public Const INVALID_HANDLE_VALUE = -1
Public Const FILE_ATTRIBUTE_ARCHIVE = &H20
Public Const FILE_ATTRIBUTE_DIRECTORY = &H10
Public Const FILE_ATTRIBUTE_HIDDEN = &H2
Public Const FILE_ATTRIBUTE_NORMAL = &H80
Public Const FILE_ATTRIBUTE_READONLY = &H1
Public Const FILE_ATTRIBUTE_SYSTEM = &H4
Public Const FILE_ATTRIBUTE_TEMPORARY = &H100

Public Type FILETIME
     dwLowDateTime As Long
     dwHighDateTime As Long
End Type

Public Type SYSTEMTIME
     wYear As Integer
     wMonth As Integer
     wDayOfWeek As Integer
     wDay As Integer
     wHour As Integer
     wMinute As Integer
     wSecond As Integer
     wMilliseconds As Integer
End Type

Public Type WIN32_FIND_DATAA
    dwFileAttributes As Long
    ftCreationTime As FILETIME
    ftLastAccessTime As FILETIME
    ftLastWriteTime As FILETIME
    nFileSizeHigh As Long
    nFileSizeLow As Long
    dwReserved0 As Long
    dwReserved1 As Long
    cFileName As String * MAX_PATH
    cAlternateFileName As String * 14
End Type

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

' GDI Functions
Public Const SRCCOPY             As Long = &HCC0020   ' dest = source
Public Const SRCPAINT            As Long = &HEE0086   ' dest = source OR dest
Public Const SRCAND              As Long = &H8800C6   ' dest = source AND dest
Public Const SRCINVERT           As Long = &H660046   ' dest = source XOR dest
Public Const SRCERASE            As Long = &H440328   ' dest = source AND (NOT dest)
Public Const NOTSRCCOPY          As Long = &H330008   ' dest = (NOT source)
Public Const NOTSRCERASE         As Long = &H1100A6   ' dest = (NOT src) AND (NOT dest)
Public Const MERGECOPY           As Long = &HC000CA   ' dest = (source AND pattern)
Public Const MERGEPAINT          As Long = &HBB0226   ' dest = (NOT source) OR dest
Public Const PATCOPY             As Long = &HF00021   ' dest = pattern
Public Const PATPAINT            As Long = &HFB0A09   ' dest = DPSnoo
Public Const PATINVERT           As Long = &H5A0049   ' dest = pattern XOR dest
Public Const DSTINVERT           As Long = &H550009   ' dest = (NOT dest)
Public Const BLACKNESS           As Long = &H42       ' dest = BLACK
Public Const WHITENESS           As Long = &HFF0062   ' dest = WHITE
Public Const NOMIRRORBITMAP      As Long = &H80000000 ' Do not Mirror the bitmap in this call
Public Const CAPTUREBLT          As Long = &H40000000 ' Include layered windows

Public Const PICTYPE_UNINITIALIZED As Integer = -1
Public Const PICTYPE_NONE          As Integer = 0
Public Const PICTYPE_BITMAP        As Integer = 1
Public Const PICTYPE_METAFILE      As Integer = 2
Public Const PICTYPE_ICON          As Integer = 3
Public Const PICTYPE_ENHMETAFILE   As Integer = 4

Public Const WHITE_BRUSH         As Integer = 0
Public Const LTGRAY_BRUSH        As Integer = 1
Public Const GRAY_BRUSH          As Integer = 2
Public Const DKGRAY_BRUSH        As Integer = 3
Public Const BLACK_BRUSH         As Integer = 4
Public Const NULL_BRUSH          As Integer = 5
Public Const HOLLOW_BRUSH        As Integer = NULL_BRUSH
Public Const WHITE_PEN           As Integer = 6
Public Const BLACK_PEN           As Integer = 7
Public Const NULL_PEN            As Integer = 8
Public Const OEM_FIXED_FONT      As Integer = 10
Public Const ANSI_FIXED_FONT     As Integer = 11
Public Const ANSI_VAR_FONT       As Integer = 12
Public Const SYSTEM_FONT         As Integer = 13
Public Const DEVICE_DEFAULT_FONT As Integer = 14
Public Const DEFAULT_PALETTE     As Integer = 15
Public Const SYSTEM_FIXED_FONT   As Integer = 16

Public Const ETO_OPAQUE            As Long = &H2
Public Const ETO_CLIPPED           As Long = &H4
Public Const ETO_GLYPH_INDEX       As Long = &H10
Public Const ETO_RTLREADING        As Long = &H80
Public Const ETO_NUMERICSLOCAL     As Long = &H400
Public Const ETO_NUMERICSLATIN     As Long = &H800
Public Const ETO_IGNORELANGUAGE    As Long = &H1000
Public Const ETO_PDY               As Long = &H2000
Public Const ETO_REVERSE_INDEX_MAP As Long = &H10000

Public Const PLANES               As Long = 14
Public Const BITSPIXEL            As Long = 12

Public Const OPAQUE = 2
Public Const TRANSPARENT = 1

Public Type GUID
   Data1    As Long
   Data2    As Integer
   Data3    As Integer
   Data4(7) As Byte
End Type

Public Type PICTDESC
   size     As Long
   Type     As Long
   hBmp     As Long
   hPal     As Long
   Reserved As Long
End Type

Public Const LF_FACESIZE = 32
Public Const FW_NORMAL = 400
Public Const FW_BOLD = 700
Public Const FF_DONTCARE = 0
Public Const DEFAULT_QUALITY = 0
Public Const DEFAULT_PITCH = 0
Public Const DEFAULT_CHARSET = 1
Public Const LOGPIXELSY = 90

Public Type LOGFONT
    lfHeight As Long
    lfWidth As Long
    lfEscapement As Long
    lfOrientation As Long
    lfWeight As Long
    lfItalic As Byte
    lfUnderline As Byte
    lfStrikeOut As Byte
    lfCharSet As Byte
    lfOutPrecision As Byte
    lfClipPrecision As Byte
    lfQuality As Byte
    lfPitchAndFamily As Byte
    lfFaceName(0 To LF_FACESIZE) As Byte
End Type

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
Public Declare Function ReleaseDC Lib "GDI32" (ByVal hWnd As Long, ByVal hDC As Long) As Integer
Public Declare Function GetWindowDC Lib "GDI32" (ByVal hWnd As Long) As Long
Public Declare Function MoveToEx Lib "GDI32" (ByVal hDC As Long, ByVal x As Integer, ByVal y As Integer, ByRef lppt As APOINT) As Integer
Public Declare Function LineTo Lib "GDI32" (ByVal hDC As Long, ByVal x As Integer, ByVal y As Integer) As Integer
Public Declare Function SetBkMode Lib "GDI32" (ByVal hDC As Long, ByVal nBkMode As Long) As Long
Public Declare Function SetTextColor Lib "GDI32" (ByVal hDC As Long, ByVal color As Long) As Long
Public Declare Function CreateFontIndirectA Lib "GDI32" (ByRef lpLogFont As LOGFONT) As Long
Public Declare Function CreatePen Lib "GDI32" (ByVal penStyle As Integer, ByVal Width As Integer, ByVal color As Long) As Long

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

Public Sub ALine(ByVal hDC As Long, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
    Dim pt As APOINT
    MoveToEx hDC, x1, y1, pt
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
