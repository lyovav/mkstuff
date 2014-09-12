Attribute VB_Name = "WinAPITypes"
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

'
'Struct pointed to by WM_GETMINMAXINFO lParam
'
Public Type MINMAXINFO
    ptReserved     As APOINT
    ptMaxSize      As APOINT
    ptMaxPosition  As APOINT
    ptMinTrackSize As APOINT
    ptMaxTrackSize As APOINT
End Type

'
'lParam of WM_COPYDATA message points to...
'
Public Type COPYDATASTRUCT
    dwData As Long
    cbData As Long
    lpData As Long
End Type

Public Type MDINEXTMENU
    hmenuIn As Long
    hmenuNext As Long
    hwndNext As Long
End Type

