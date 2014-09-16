Attribute VB_Name = "WinAPIConsts"
Option Explicit
DefInt A-Z

Public Const FW_DONTCARE = 0
Public Const FW_THIN = 100
Public Const FW_EXTRALIGHT = 200
Public Const FW_LIGHT = 300
Public Const FW_NORMAL = 400
Public Const FW_MEDIUM = 500
Public Const FW_SEMIBOLD = 600
Public Const FW_BOLD = 700
Public Const FW_EXTRABOLD = 800
Public Const FW_HEAVY = 900
Public Const FW_BLACK = FW_HEAVY
Public Const FW_DEMIBOLD = FW_SEMIBOLD
Public Const FW_REGULAR = FW_NORMAL
Public Const FW_ULTRABOLD = FW_EXTRABOLD
Public Const FW_ULTRALIGHT = FW_EXTRALIGHT
Public Const ANSI_CHARSET = 0
Public Const DEFAULT_CHARSET = 1
Public Const SYMBOL_CHARSET = 2
Public Const SHIFTJIS_CHARSET = 128
Public Const HANGEUL_CHARSET = 129
Public Const CHINESEBIG5_CHARSET = 136
Public Const OEM_CHARSET = 255
Public Const OUT_CHARACTER_PRECIS = 2
Public Const OUT_DEFAULT_PRECIS = 0
Public Const OUT_DEVICE_PRECIS = 5
Public Const CLIP_DEFAULT_PRECIS = 0
Public Const CLIP_CHARACTER_PRECIS = 1
Public Const CLIP_STROKE_PRECIS = 2
Public Const DEFAULT_QUALITY = 0
Public Const DRAFT_QUALITY = 1
Public Const PROOF_QUALITY = 2
Public Const DEFAULT_PITCH = 0
Public Const FIXED_PITCH = 1
Public Const VARIABLE_PITCH = 2

Public Const WH_MOUSE = 7
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
Public Const SM_CXSCREEN As Integer = 0
Public Const SM_CYSCREEN As Integer = 1
Public Const SM_CXVSCROLL As Integer = 2
Public Const SM_CYHSCROLL As Integer = 3
Public Const SM_CYCAPTION As Integer = 4
Public Const SM_CXBORDER As Integer = 5
Public Const SM_CYBORDER As Integer = 6
Public Const SM_CXDLGFRAME As Integer = 7
Public Const SM_CYDLGFRAME As Integer = 8
Public Const SM_CYVTHUMB As Integer = 9
Public Const SM_CXHTHUMB As Integer = 10
Public Const SM_CXICON As Integer = 11
Public Const SM_CYICON As Integer = 12
Public Const SM_CXCURSOR As Integer = 13
Public Const SM_CYCURSOR As Integer = 14
Public Const SM_CYMENU As Integer = 15
Public Const SM_CXFULLSCREEN As Integer = 16
Public Const SM_CYFULLSCREEN As Integer = 17
Public Const SM_CYKANJIWINDOW As Integer = 18
Public Const SM_MOUSEPRESENT As Integer = 19
Public Const SM_CYVSCROLL As Integer = 20
Public Const SM_CXHSCROLL As Integer = 21
Public Const SM_DEBUG As Integer = 22
Public Const SM_SWAPBUTTON As Integer = 23
Public Const SM_RESERVED1 As Integer = 24
Public Const SM_RESERVED2 As Integer = 25
Public Const SM_RESERVED3 As Integer = 26
Public Const SM_RESERVED4 As Integer = 27
Public Const SM_CXMIN As Integer = 28
Public Const SM_CYMIN As Integer = 29
Public Const SM_CXSIZE As Integer = 30
Public Const SM_CYSIZE As Integer = 31
Public Const SM_CXFRAME As Integer = 32
Public Const SM_CYFRAME As Integer = 33
Public Const SM_CXMINTRACK As Integer = 34
Public Const SM_CYMINTRACK As Integer = 35
Public Const SM_CXDOUBLECLK As Integer = 36
Public Const SM_CYDOUBLECLK As Integer = 37
Public Const SM_CXICONSPACING As Integer = 38
Public Const SM_CYICONSPACING As Integer = 39
Public Const SM_MENUDROPALIGNMENT As Integer = 40
Public Const SM_PENWINDOWS As Integer = 41
Public Const SM_DBCSENABLED As Integer = 42
Public Const SM_CMOUSEBUTTONS As Integer = 43
Public Const GWL_EXSTYLE As Integer = -20
Public Const GWL_HINSTANCE As Integer = -6
Public Const GWL_ID As Integer = -12
Public Const GWL_STYLE As Integer = -16
Public Const GWL_USERDATA As Integer = -21
Public Const GWL_WNDPROC As Integer = -4
Public Const SS_LEFT As Long = &H0
Public Const SS_CENTER As Long = &H1
Public Const SS_RIGHT As Long = &H2
Public Const SS_ICON As Long = &H3
Public Const SS_BLACKRECT As Long = &H4
Public Const SS_GRAYRECT As Long = &H5
Public Const SS_WHITERECT As Long = &H6
Public Const SS_BLACKFRAME As Long = &H7
Public Const SS_GRAYFRAME As Long = &H8
Public Const SS_WHITEFRAME As Long = &H9
Public Const SS_USERITEM As Long = &HA
Public Const SS_SIMPLE As Long = &HB
Public Const SS_LEFTNOWORDWRAP As Long = &HC
Public Const SS_OWNERDRAW As Long = &HD
Public Const SS_BITMAP As Long = &HE
Public Const SS_ENHMETAFILE As Long = &HF
Public Const SS_ETCHEDHORZ As Long = &H10
Public Const SS_ETCHEDVERT As Long = &H11
Public Const SS_ETCHEDFRAME As Long = &H12
Public Const SS_TYPEMASK As Long = &H1F
Public Const SS_REALSIZECONTROL As Long = &H40
Public Const SS_NOPREFIX As Long = &H80
Public Const SS_NOTIFY As Long = &H100
Public Const SS_CENTERIMAGE As Long = &H200
Public Const SS_RIGHTJUST As Long = &H400
Public Const SS_REALSIZEIMAGE As Long = &H800
Public Const SS_SUNKEN As Long = &H1000
Public Const SS_EDITCONTROL As Long = &H2000
Public Const SS_ENDELLIPSIS As Long = &H4000
Public Const SS_PATHELLIPSIS As Long = &H8000
Public Const SS_WORDELLIPSIS As Long = &HC000
Public Const SS_ELLIPSISMASK As Long = &HC000
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
Public Const SRCCOPY As Long = &HCC0020
Public Const SRCPAINT As Long = &HEE0086
Public Const SRCAND As Long = &H8800C6
Public Const SRCINVERT As Long = &H660046
Public Const SRCERASE As Long = &H440328
Public Const NOTSRCCOPY As Long = &H330008
Public Const NOTSRCERASE As Long = &H1100A6
Public Const MERGECOPY As Long = &HC000CA
Public Const MERGEPAINT As Long = &HBB0226
Public Const PATCOPY As Long = &HF00021
Public Const PATPAINT As Long = &HFB0A09
Public Const PATINVERT As Long = &H5A0049
Public Const DSTINVERT As Long = &H550009
Public Const BLACKNESS As Long = &H42
Public Const WHITENESS As Long = &HFF0062
Public Const NOMIRRORBITMAP As Long = &H80000000
Public Const CAPTUREBLT As Long = &H40000000
Public Const PICTYPE_UNINITIALIZED As Integer = -1
Public Const PICTYPE_NONE As Integer = 0
Public Const PICTYPE_BITMAP As Integer = 1
Public Const PICTYPE_METAFILE As Integer = 2
Public Const PICTYPE_ICON As Integer = 3
Public Const PICTYPE_ENHMETAFILE As Integer = 4
Public Const WHITE_BRUSH As Integer = 0
Public Const LTGRAY_BRUSH As Integer = 1
Public Const GRAY_BRUSH As Integer = 2
Public Const DKGRAY_BRUSH As Integer = 3
Public Const BLACK_BRUSH As Integer = 4
Public Const NULL_BRUSH As Integer = 5
Public Const HOLLOW_BRUSH As Integer = NULL_BRUSH
Public Const WHITE_PEN As Integer = 6
Public Const BLACK_PEN As Integer = 7
Public Const NULL_PEN As Integer = 8
Public Const OEM_FIXED_FONT As Integer = 10
Public Const ANSI_FIXED_FONT As Integer = 11
Public Const ANSI_VAR_FONT As Integer = 12
Public Const SYSTEM_FONT As Integer = 13
Public Const DEVICE_DEFAULT_FONT As Integer = 14
Public Const DEFAULT_PALETTE As Integer = 15
Public Const SYSTEM_FIXED_FONT As Integer = 16
Public Const ETO_OPAQUE As Long = &H2
Public Const ETO_CLIPPED As Long = &H4
Public Const ETO_GLYPH_INDEX As Long = &H10
Public Const ETO_RTLREADING As Long = &H80
Public Const ETO_NUMERICSLOCAL As Long = &H400
Public Const ETO_NUMERICSLATIN As Long = &H800
Public Const ETO_IGNORELANGUAGE As Long = &H1000
Public Const ETO_PDY As Long = &H2000
Public Const ETO_REVERSE_INDEX_MAP As Long = &H10000
Public Const PLANES As Long = 14
Public Const BITSPIXEL As Long = 12
Public Const OPAQUE = 2
Public Const TRANSPARENT = 1
Public Const LF_FACESIZE = 32
Public Const LOGPIXELSY = 90
Public Const WM_NULL As Long = &H0
Public Const WM_CREATE As Long = &H1
Public Const WM_DESTROY As Long = &H2
Public Const WM_MOVE As Long = &H3
Public Const WM_SIZE As Long = &H5
Public Const WM_ACTIVATE As Long = &H6
Public Const WA_INACTIVE As Long = 0
Public Const WA_ACTIVE As Long = 1
Public Const WA_CLICKACTIVE As Long = 2
Public Const WM_SETFOCUS As Long = &H7
Public Const WM_KILLFOCUS As Long = &H8
Public Const WM_ENABLE As Long = &HA
Public Const WM_SETREDRAW As Long = &HB
Public Const WM_SETTEXT As Long = &HC
Public Const WM_GETTEXT As Long = &HD
Public Const WM_GETTEXTLENGTH As Long = &HE
Public Const WM_PAINT As Long = &HF
Public Const WM_CLOSE As Long = &H10
Public Const WM_QUERYENDSESSION As Long = &H11
Public Const WM_QUERYOPEN As Long = &H13
Public Const WM_ENDSESSION As Long = &H16
Public Const WM_QUIT As Long = &H12
Public Const WM_ERASEBKGND As Long = &H14
Public Const WM_SYSCOLORCHANGE As Long = &H15
Public Const WM_SHOWWINDOW As Long = &H18
Public Const WM_WININICHANGE As Long = &H1A
Public Const WM_SETTINGCHANGE As Long = WM_WININICHANGE
Public Const WM_DEVMODECHANGE As Long = &H1B
Public Const WM_ACTIVATEAPP As Long = &H1C
Public Const WM_FONTCHANGE As Long = &H1D
Public Const WM_TIMECHANGE As Long = &H1E
Public Const WM_CANCELMODE As Long = &H1F
Public Const WM_SETCURSOR As Long = &H20
Public Const WM_MOUSEACTIVATE As Long = &H21
Public Const WM_CHILDACTIVATE As Long = &H22
Public Const WM_QUEUESYNC As Long = &H23
Public Const WM_GETMINMAXINFO As Long = &H24
Public Const WM_PAINTICON As Long = &H26
Public Const WM_ICONERASEBKGND As Long = &H27
Public Const WM_NEXTDLGCTL As Long = &H28
Public Const WM_SPOOLERSTATUS As Long = &H2A
Public Const WM_DRAWITEM As Long = &H2B
Public Const WM_MEASUREITEM As Long = &H2C
Public Const WM_DELETEITEM As Long = &H2D
Public Const WM_VKEYTOITEM As Long = &H2E
Public Const WM_CHARTOITEM As Long = &H2F
Public Const WM_SETFONT As Long = &H30
Public Const WM_GETFONT As Long = &H31
Public Const WM_SETHOTKEY As Long = &H32
Public Const WM_GETHOTKEY As Long = &H33
Public Const WM_QUERYDRAGICON As Long = &H37
Public Const WM_COMPAREITEM As Long = &H39
Public Const WM_GETOBJECT As Long = &H3D
Public Const WM_COMPACTING As Long = &H41
Public Const WM_COMMNOTIFY As Long = &H44
Public Const WM_WINDOWPOSCHANGING As Long = &H46
Public Const WM_WINDOWPOSCHANGED As Long = &H47
Public Const WM_POWER As Long = &H48
Public Const PWR_OK As Long = 1
Public Const PWR_FAIL As Long = -1
Public Const PWR_SUSPENDREQUEST As Long = 1
Public Const PWR_SUSPENDRESUME As Long = 2
Public Const PWR_CRITICALRESUME As Long = 3
Public Const WM_COPYDATA As Long = &H4A
Public Const WM_CANCELJOURNAL As Long = &H4B
Public Const WM_NOTIFY As Long = &H4E
Public Const WM_INPUTLANGCHANGEREQUEST As Long = &H50
Public Const WM_INPUTLANGCHANGE As Long = &H51
Public Const WM_TCARD As Long = &H52
Public Const WM_HELP As Long = &H53
Public Const WM_USERCHANGED As Long = &H54
Public Const WM_NOTIFYFORMAT As Long = &H55
Public Const NFR_ANSI As Long = 1
Public Const NFR_UNICODE As Long = 2
Public Const NF_QUERY As Long = 3
Public Const NF_REQUERY As Long = 4
Public Const WM_CONTEXTMENU As Long = &H7B
Public Const WM_STYLECHANGING As Long = &H7C
Public Const WM_STYLECHANGED As Long = &H7D
Public Const WM_DISPLAYCHANGE As Long = &H7E
Public Const WM_GETICON As Long = &H7F
Public Const WM_SETICON As Long = &H80
Public Const WM_NCCREATE As Long = &H81
Public Const WM_NCDESTROY As Long = &H82
Public Const WM_NCCALCSIZE As Long = &H83
Public Const WM_NCHITTEST As Long = &H84
Public Const WM_NCPAINT As Long = &H85
Public Const WM_NCACTIVATE As Long = &H86
Public Const WM_GETDLGCODE As Long = &H87
Public Const WM_SYNCPAINT As Long = &H88
Public Const WM_NCMOUSEMOVE As Long = &HA0
Public Const WM_NCLBUTTONDOWN As Long = &HA1
Public Const WM_NCLBUTTONUP As Long = &HA2
Public Const WM_NCLBUTTONDBLCLK As Long = &HA3
Public Const WM_NCRBUTTONDOWN As Long = &HA4
Public Const WM_NCRBUTTONUP As Long = &HA5
Public Const WM_NCRBUTTONDBLCLK As Long = &HA6
Public Const WM_NCMBUTTONDOWN As Long = &HA7
Public Const WM_NCMBUTTONUP As Long = &HA8
Public Const WM_NCMBUTTONDBLCLK As Long = &HA9
Public Const WM_NCXBUTTONDOWN As Long = &HAB
Public Const WM_NCXBUTTONUP As Long = &HAC
Public Const WM_NCXBUTTONDBLCLK As Long = &HAD
Public Const WM_INPUT_DEVICE_CHANGE As Long = &HFE
Public Const WM_INPUT As Long = &HFF
Public Const WM_KEYFIRST As Long = &H100
Public Const WM_KEYDOWN As Long = &H100
Public Const WM_KEYUP As Long = &H101
Public Const WM_CHAR As Long = &H102
Public Const WM_DEADCHAR As Long = &H103
Public Const WM_SYSKEYDOWN As Long = &H104
Public Const WM_SYSKEYUP As Long = &H105
Public Const WM_SYSCHAR As Long = &H106
Public Const WM_SYSDEADCHAR As Long = &H107
Public Const WM_UNICHAR As Long = &H109
Public Const UNICODE_NOCHAR As Long = &HFFFF
Public Const WM_IME_STARTCOMPOSITION As Long = &H10D
Public Const WM_IME_ENDCOMPOSITION As Long = &H10E
Public Const WM_IME_COMPOSITION As Long = &H10F
Public Const WM_IME_KEYLAST As Long = &H10F
Public Const WM_INITDIALOG As Long = &H110
Public Const WM_COMMAND As Long = &H111
Public Const WM_SYSCOMMAND As Long = &H112
Public Const WM_TIMER As Long = &H113
Public Const WM_HSCROLL As Long = &H114
Public Const WM_VSCROLL As Long = &H115
Public Const WM_INITMENU As Long = &H116
Public Const WM_INITMENUPOPUP As Long = &H117
Public Const WM_GESTURE As Long = &H119
Public Const WM_GESTURENOTIFY As Long = &H11A
Public Const WM_MENUSELECT As Long = &H11F
Public Const WM_MENUCHAR As Long = &H120
Public Const WM_ENTERIDLE As Long = &H121
Public Const WM_MENURBUTTONUP As Long = &H122
Public Const WM_MENUDRAG As Long = &H123
Public Const WM_MENUGETOBJECT As Long = &H124
Public Const WM_UNINITMENUPOPUP As Long = &H125
Public Const WM_MENUCOMMAND As Long = &H126
Public Const WM_CHANGEUISTATE As Long = &H127
Public Const WM_UPDATEUISTATE As Long = &H128
Public Const WM_QUERYUISTATE As Long = &H129
Public Const UIS_SET As Long = 1
Public Const UIS_CLEAR As Long = 2
Public Const UIS_INITIALIZE As Long = 3
Public Const UISF_HIDEFOCUS As Long = &H1
Public Const UISF_HIDEACCEL As Long = &H2
Public Const UISF_ACTIVE As Long = &H4
Public Const WM_CTLCOLORMSGBOX As Long = &H132
Public Const WM_CTLCOLOREDIT As Long = &H133
Public Const WM_CTLCOLORLISTBOX As Long = &H134
Public Const WM_CTLCOLORBTN As Long = &H135
Public Const WM_CTLCOLORDLG As Long = &H136
Public Const WM_CTLCOLORSCROLLBAR As Long = &H137
Public Const WM_CTLCOLORSTATIC As Long = &H138
Public Const MN_GETHMENU As Long = &H1E1
Public Const WM_MOUSEFIRST As Long = &H200
Public Const WM_MOUSEMOVE As Long = &H200
Public Const WM_LBUTTONDOWN As Long = &H201
Public Const WM_LBUTTONUP As Long = &H202
Public Const WM_LBUTTONDBLCLK As Long = &H203
Public Const WM_RBUTTONDOWN As Long = &H204
Public Const WM_RBUTTONUP As Long = &H205
Public Const WM_RBUTTONDBLCLK As Long = &H206
Public Const WM_MBUTTONDOWN As Long = &H207
Public Const WM_MBUTTONUP As Long = &H208
Public Const WM_MBUTTONDBLCLK As Long = &H209
Public Const WM_MOUSEWHEEL As Long = &H20A
Public Const WM_XBUTTONDOWN As Long = &H20B
Public Const WM_XBUTTONUP As Long = &H20C
Public Const WM_XBUTTONDBLCLK As Long = &H20D
Public Const WM_MOUSEHWHEEL As Long = &H20E
Public Const WHEEL_DELTA As Long = 120
Public Const XBUTTON1 As Long = &H1
Public Const XBUTTON2 As Long = &H2
Public Const WM_PARENTNOTIFY As Long = &H210
Public Const WM_ENTERMENULOOP As Long = &H211
Public Const WM_EXITMENULOOP As Long = &H212
Public Const WM_NEXTMENU As Long = &H213
Public Const WM_SIZING As Long = &H214
Public Const WM_CAPTURECHANGED As Long = &H215
Public Const WM_MOVING As Long = &H216
Public Const WM_POWERBROADCAST As Long = &H218
Public Const PBT_APMQUERYSUSPEND As Long = &H0
Public Const PBT_APMQUERYSTANDBY As Long = &H1
Public Const PBT_APMQUERYSUSPENDFAILED As Long = &H2
Public Const PBT_APMQUERYSTANDBYFAILED As Long = &H3
Public Const PBT_APMSUSPEND As Long = &H4
Public Const PBT_APMSTANDBY As Long = &H5
Public Const PBT_APMRESUMECRITICAL As Long = &H6
Public Const PBT_APMRESUMESUSPEND As Long = &H7
Public Const PBT_APMRESUMESTANDBY As Long = &H8
Public Const PBTF_APMRESUMEFROMFAILURE As Long = &H1
Public Const PBT_APMBATTERYLOW As Long = &H9
Public Const PBT_APMPOWERSTATUSCHANGE As Long = &HA
Public Const PBT_APMOEMEVENT As Long = &HB
Public Const PBT_APMRESUMEAUTOMATIC As Long = &H12
Public Const PBT_POWERSETTINGCHANGE As Long = &H8013
Public Const WM_DEVICECHANGE As Long = &H219
Public Const WM_MDICREATE As Long = &H220
Public Const WM_MDIDESTROY As Long = &H221
Public Const WM_MDIACTIVATE As Long = &H222
Public Const WM_MDIRESTORE As Long = &H223
Public Const WM_MDINEXT As Long = &H224
Public Const WM_MDIMAXIMIZE As Long = &H225
Public Const WM_MDITILE As Long = &H226
Public Const WM_MDICASCADE As Long = &H227
Public Const WM_MDIICONARRANGE As Long = &H228
Public Const WM_MDIGETACTIVE As Long = &H229
Public Const WM_MDISETMENU As Long = &H230
Public Const WM_ENTERSIZEMOVE As Long = &H231
Public Const WM_EXITSIZEMOVE As Long = &H232
Public Const WM_DROPFILES As Long = &H233
Public Const WM_MDIREFRESHMENU As Long = &H234
Public Const WM_TOUCH As Long = &H240
Public Const WM_IME_SETCONTEXT As Long = &H281
Public Const WM_IME_NOTIFY As Long = &H282
Public Const WM_IME_CONTROL As Long = &H283
Public Const WM_IME_COMPOSITIONFULL As Long = &H284
Public Const WM_IME_SELECT As Long = &H285
Public Const WM_IME_CHAR As Long = &H286
Public Const WM_IME_REQUEST As Long = &H288
Public Const WM_IME_KEYDOWN As Long = &H290
Public Const WM_IME_KEYUP As Long = &H291
Public Const WM_MOUSEHOVER As Long = &H2A1
Public Const WM_MOUSELEAVE As Long = &H2A3
Public Const WM_NCMOUSEHOVER As Long = &H2A0
Public Const WM_NCMOUSELEAVE As Long = &H2A2
Public Const WM_WTSSESSION_CHANGE As Long = &H2B1
Public Const WM_TABLET_FIRST As Long = &H2C0
Public Const WM_TABLET_LAST As Long = &H2DF
Public Const WM_CUT As Long = &H300
Public Const WM_COPY As Long = &H301
Public Const WM_PASTE As Long = &H302
Public Const WM_CLEAR As Long = &H303
Public Const WM_UNDO As Long = &H304
Public Const WM_RENDERFORMAT As Long = &H305
Public Const WM_RENDERALLFORMATS As Long = &H306
Public Const WM_DESTROYCLIPBOARD As Long = &H307
Public Const WM_DRAWCLIPBOARD As Long = &H308
Public Const WM_PAINTCLIPBOARD As Long = &H309
Public Const WM_VSCROLLCLIPBOARD As Long = &H30A
Public Const WM_SIZECLIPBOARD As Long = &H30B
Public Const WM_ASKCBFORMATNAME As Long = &H30C
Public Const WM_CHANGECBCHAIN As Long = &H30D
Public Const WM_HSCROLLCLIPBOARD As Long = &H30E
Public Const WM_QUERYNEWPALETTE As Long = &H30F
Public Const WM_PALETTEISCHANGING As Long = &H310
Public Const WM_PALETTECHANGED As Long = &H311
Public Const WM_HOTKEY As Long = &H312
Public Const WM_PRINT As Long = &H317
Public Const WM_PRINTCLIENT As Long = &H318
Public Const WM_APPCOMMAND As Long = &H319
Public Const WM_THEMECHANGED As Long = &H31A
Public Const WM_CLIPBOARDUPDATE As Long = &H31D
Public Const WM_DWMCOMPOSITIONCHANGED As Long = &H31E
Public Const WM_DWMNCRENDERINGCHANGED As Long = &H31F
Public Const WM_DWMCOLORIZATIONCOLORCHANGED As Long = &H320
Public Const WM_DWMWINDOWMAXIMIZEDCHANGE As Long = &H321
Public Const WM_DWMSENDICONICTHUMBNAIL As Long = &H323
Public Const WM_DWMSENDICONICLIVEPREVIEWBITMAP As Long = &H326
Public Const WM_GETTITLEBARINFOEX As Long = &H33F
Public Const WM_HANDHELDFIRST As Long = &H358
Public Const WM_HANDHELDLAST As Long = &H35F
Public Const WM_AFXFIRST As Long = &H360
Public Const WM_AFXLAST As Long = &H37F
Public Const WM_PENWINFIRST As Long = &H380
Public Const WM_PENWINLAST As Long = &H38F
Public Const WM_APP As Long = &H8000
Public Const WM_USER As Long = &H400
Public Const WMSZ_LEFT As Long = 1
Public Const WMSZ_RIGHT As Long = 2
Public Const WMSZ_TOP As Long = 3
Public Const WMSZ_TOPLEFT As Long = 4
Public Const WMSZ_TOPRIGHT As Long = 5
Public Const WMSZ_BOTTOM As Long = 6
Public Const WMSZ_BOTTOMLEFT As Long = 7
Public Const WMSZ_BOTTOMRIGHT As Long = 8
Public Const HTERROR As Long = -2
Public Const HTTRANSPARENT As Long = -1
Public Const HTNOWHERE As Long = 0
Public Const HTCLIENT As Long = 1
Public Const HTCAPTION As Long = 2
Public Const HTSYSMENU As Long = 3
Public Const HTGROWBOX As Long = 4
Public Const HTSIZE As Long = HTGROWBOX
Public Const HTMENU As Long = 5
Public Const HTHSCROLL As Long = 6
Public Const HTVSCROLL As Long = 7
Public Const HTMINBUTTON As Long = 8
Public Const HTMAXBUTTON As Long = 9
Public Const HTLEFT As Long = 10
Public Const HTRIGHT As Long = 11
Public Const HTTOP As Long = 12
Public Const HTTOPLEFT As Long = 13
Public Const HTTOPRIGHT As Long = 14
Public Const HTBOTTOM As Long = 15
Public Const HTBOTTOMLEFT As Long = 16
Public Const HTBOTTOMRIGHT As Long = 17
Public Const HTBORDER As Long = 18
Public Const HTREDUCE As Long = HTMINBUTTON
Public Const HTZOOM As Long = HTMAXBUTTON
Public Const HTSIZEFIRST As Long = HTLEFT
Public Const HTSIZELAST As Long = HTBOTTOMRIGHT
Public Const HTOBJECT As Long = 19
Public Const HTCLOSE As Long = 20
Public Const HTHELP As Long = 21
Public Const SMTO_NORMAL As Long = &H0
Public Const SMTO_BLOCK As Long = &H1
Public Const SMTO_ABORTIFHUNG As Long = &H2
Public Const SMTO_NOTIMEOUTIFNOTHUNG As Long = &H8
Public Const SMTO_ERRORONEXIT As Long = &H20
Public Const MA_ACTIVATE As Long = 1
Public Const MA_ACTIVATEANDEAT As Long = 2
Public Const MA_NOACTIVATE As Long = 3
Public Const MA_NOACTIVATEANDEAT As Long = 4
Public Const ICON_SMALL As Long = 0
Public Const ICON_BIG As Long = 1
Public Const ICON_SMALL2 As Long = 2
Public Const SIZE_RESTORED As Long = 0
Public Const SIZE_MINIMIZED As Long = 1
Public Const SIZE_MAXIMIZED As Long = 2
Public Const SIZE_MAXSHOW As Long = 3
Public Const SIZE_MAXHIDE As Long = 4
Public Const SIZENORMAL As Long = SIZE_RESTORED
Public Const SIZEICONIC As Long = SIZE_MINIMIZED
Public Const SIZEFULLSCREEN As Long = SIZE_MAXIMIZED
Public Const SIZEZOOMSHOW As Long = SIZE_MAXSHOW
Public Const SIZEZOOMHIDE As Long = SIZE_MAXHIDE
Public Const MK_LBUTTON As Long = &H1
Public Const MK_RBUTTON As Long = &H2
Public Const MK_SHIFT As Long = &H4
Public Const MK_CONTROL As Long = &H8
Public Const MK_MBUTTON As Long = &H10
Public Const MK_XBUTTON1 As Long = &H20
Public Const MK_XBUTTON2 As Long = &H40
Public Const TME_HOVER As Long = &H1
Public Const TME_LEAVE As Long = &H2
Public Const TME_NONCLIENT As Long = &H10
Public Const TME_QUERY As Long = &H40000000
Public Const TME_CANCEL As Long = &H80000000
Public Const HOVER_DEFAULT As Long = &HFFFFFFFF
Public Const WS_OVERLAPPED As Long = &H0
Public Const WS_POPUP As Long = &H80000000
Public Const WS_CHILD As Long = &H40000000
Public Const WS_MINIMIZE As Long = &H20000000
Public Const WS_VISIBLE As Long = &H10000000
Public Const WS_DISABLED As Long = &H8000000
Public Const WS_CLIPSIBLINGS As Long = &H4000000
Public Const WS_CLIPCHILDREN As Long = &H2000000
Public Const WS_MAXIMIZE As Long = &H1000000
Public Const WS_CAPTION As Long = &HC00000
Public Const WS_BORDER As Long = &H800000
Public Const WS_DLGFRAME As Long = &H400000
Public Const WS_VSCROLL As Long = &H200000
Public Const WS_HSCROLL As Long = &H100000
Public Const WS_SYSMENU As Long = &H80000
Public Const WS_THICKFRAME As Long = &H40000
Public Const WS_GROUP As Long = &H20000
Public Const WS_TABSTOP As Long = &H10000
Public Const WS_MINIMIZEBOX As Long = &H20000
Public Const WS_MAXIMIZEBOX As Long = &H10000
Public Const WS_TILED As Long = WS_OVERLAPPED
Public Const WS_ICONIC As Long = WS_MINIMIZE
Public Const WS_SIZEBOX As Long = WS_THICKFRAME
Public Const WS_EX_DLGMODALFRAME As Long = &H1
Public Const WS_EX_NOPARENTNOTIFY As Long = &H4
Public Const WS_EX_TOPMOST As Long = &H8
Public Const WS_EX_ACCEPTFILES As Long = &H10
Public Const WS_EX_TRANSPARENT As Long = &H20
Public Const WS_EX_MDICHILD As Long = &H40
Public Const WS_EX_TOOLWINDOW As Long = &H80
Public Const WS_EX_WINDOWEDGE As Long = &H100
Public Const WS_EX_CLIENTEDGE As Long = &H200
Public Const WS_EX_CONTEXTHELP As Long = &H400
Public Const WS_EX_RIGHT As Long = &H1000
Public Const WS_EX_LEFT As Long = &H0
Public Const WS_EX_RTLREADING As Long = &H2000
Public Const WS_EX_LTRREADING As Long = &H0
Public Const WS_EX_LEFTSCROLLBAR As Long = &H4000
Public Const WS_EX_RIGHTSCROLLBAR As Long = &H0
Public Const WS_EX_CONTROLPARENT As Long = &H10000
Public Const WS_EX_STATICEDGE As Long = &H20000
Public Const WS_EX_APPWINDOW As Long = &H40000
Public Const WS_EX_OVERLAPPEDWINDOW As Long = (WS_EX_WINDOWEDGE + WS_EX_CLIENTEDGE)
Public Const WS_EX_PALETTEWINDOW As Long = (WS_EX_WINDOWEDGE + WS_EX_TOOLWINDOW + WS_EX_TOPMOST)
Public Const WS_EX_LAYERED As Long = &H80000
Public Const WS_EX_NOINHERITLAYOUT As Long = &H100000
Public Const WS_EX_LAYOUTRTL As Long = &H400000
Public Const WS_EX_COMPOSITED As Long = &H2000000
Public Const WS_EX_NOACTIVATE As Long = &H8000000
Public Const CS_VREDRAW As Long = &H1
Public Const CS_HREDRAW As Long = &H2
Public Const CS_DBLCLKS As Long = &H8
Public Const CS_OWNDC As Long = &H20
Public Const CS_CLASSDC As Long = &H40
Public Const CS_PARENTDC As Long = &H80
Public Const CS_NOCLOSE As Long = &H200
Public Const CS_SAVEBITS As Long = &H800
Public Const CS_BYTEALIGNCLIENT As Long = &H1000
Public Const CS_BYTEALIGNWINDOW As Long = &H2000
Public Const CS_GLOBALCLASS As Long = &H4000
Public Const CS_IME As Long = &H10000
Public Const CS_DROPSHADOW As Long = &H20000
Public Const PRF_CHECKVISIBLE As Long = &H1
Public Const PRF_NONCLIENT As Long = &H2
Public Const PRF_CLIENT As Long = &H4
Public Const PRF_ERASEBKGND As Long = &H8
Public Const PRF_CHILDREN As Long = &H10
Public Const PRF_OWNED As Long = &H20
Public Const BDR_RAISEDOUTER As Long = &H1
Public Const BDR_SUNKENOUTER As Long = &H2
Public Const BDR_RAISEDINNER As Long = &H4
Public Const BDR_SUNKENINNER As Long = &H8
Public Const BDR_OUTER As Long = (BDR_RAISEDOUTER + BDR_SUNKENOUTER)
Public Const BDR_INNER As Long = (BDR_RAISEDINNER + BDR_SUNKENINNER)
Public Const BDR_RAISED As Long = (BDR_RAISEDOUTER + BDR_RAISEDINNER)
Public Const BDR_SUNKEN As Long = (BDR_SUNKENOUTER + BDR_SUNKENINNER)
Public Const EDGE_RAISED As Long = (BDR_RAISEDOUTER + BDR_RAISEDINNER)
Public Const EDGE_SUNKEN As Long = (BDR_SUNKENOUTER + BDR_SUNKENINNER)
Public Const EDGE_ETCHED As Long = (BDR_SUNKENOUTER + BDR_RAISEDINNER)
Public Const EDGE_BUMP As Long = (BDR_RAISEDOUTER + BDR_SUNKENINNER)
Public Const BF_LEFT As Long = &H1
Public Const BF_TOP As Long = &H2
Public Const BF_RIGHT As Long = &H4
Public Const BF_BOTTOM As Long = &H8
Public Const BF_TOPLEFT As Long = (BF_TOP + BF_LEFT)
Public Const BF_TOPRIGHT As Long = (BF_TOP + BF_RIGHT)
Public Const BF_BOTTOMLEFT As Long = (BF_BOTTOM + BF_LEFT)
Public Const BF_BOTTOMRIGHT As Long = (BF_BOTTOM + BF_RIGHT)
Public Const BF_RECT As Long = (BF_LEFT + BF_TOP + BF_RIGHT + BF_BOTTOM)
Public Const BF_DIAGONAL As Long = &H10
Public Const BF_DIAGONAL_ENDTOPRIGHT As Long = (BF_DIAGONAL + BF_TOP + BF_RIGHT)
Public Const BF_DIAGONAL_ENDTOPLEFT As Long = (BF_DIAGONAL + BF_TOP + BF_LEFT)
Public Const BF_DIAGONAL_ENDBOTTOMLEFT As Long = (BF_DIAGONAL + BF_BOTTOM + BF_LEFT)
Public Const BF_DIAGONAL_ENDBOTTOMRIGHT As Long = (BF_DIAGONAL + BF_BOTTOM + BF_RIGHT)
Public Const BF_MIDDLE As Long = &H800
Public Const BF_SOFT As Long = &H1000
Public Const BF_ADJUST As Long = &H2000
Public Const BF_FLAT As Long = &H4000
Public Const BF_MONO As Long = &H8000

' MNi helpers
Public Const DT_CENTERD As Long = DT_CENTER + DT_VCENTER + DT_SINGLELINE