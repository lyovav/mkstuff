Attribute VB_Name = "WinAPI"
Option Explicit
DefInt A-Z

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

Type FILETIME
     dwLowDateTime As Long
     dwHighDateTime As Long
End Type

Type SYSTEMTIME
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

Public Declare Function FindFirstFileA Lib "kernel32" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATAA) As Long
Public Declare Function FindNextFileA Lib "kernel32" (ByVal hFindFile As Long, lpFindFileData As WIN32_FIND_DATAA) As Long
Public Declare Function GetFileAttributesA Lib "kernel32" (ByVal lpFileName As String) As Long
Public Declare Function FindClose Lib "kernel32" (ByVal hFindFile As Long) As Long
Public Declare Function FileTimeToLocalFileTime Lib "kernel32" (lpFileTime As FILETIME, lpLocalFileTime As FILETIME) As Long
Public Declare Function FileTimeToSystemTime Lib "kernel32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME) As Long

Public Function StripNulls(str As String) As String
    Dim zp As Integer
    zp = InStr(str, Chr(0))
    If (zp > 0) Then
        str = Left(str, zp - 1)
    End If
    StripNulls = str
End Function

