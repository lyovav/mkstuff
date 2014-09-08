Attribute VB_Name = "WinAPI"
Option Explicit
DefInt A-Z

Public Const SM_CXSCREEN             As Integer = 0
Public Const SM_CYSCREEN             As Integer = 1
Public Const SM_CXVSCROLL            As Integer = 2
Public Const SM_CYHSCROLL            As Integer = 3
Public Const SM_CYCAPTION            As Integer = 4
Public Const SM_CXBORDER             As Integer = 5
Public Const SM_CYBORDER             As Integer = 6
Public Const SM_CXDLGFRAME           As Integer = 7
Public Const SM_CYDLGFRAME           As Integer = 8
Public Const SM_CYVTHUMB             As Integer = 9
Public Const SM_CXHTHUMB             As Integer = 10
Public Const SM_CXICON               As Integer = 11
Public Const SM_CYICON               As Integer = 12
Public Const SM_CXCURSOR             As Integer = 13
Public Const SM_CYCURSOR             As Integer = 14
Public Const SM_CYMENU               As Integer = 15
Public Const SM_CXFULLSCREEN         As Integer = 16
Public Const SM_CYFULLSCREEN         As Integer = 17
Public Const SM_CYKANJIWINDOW        As Integer = 18
Public Const SM_MOUSEPRESENT         As Integer = 19
Public Const SM_CYVSCROLL            As Integer = 20
Public Const SM_CXHSCROLL            As Integer = 21
Public Const SM_DEBUG                As Integer = 22
Public Const SM_SWAPBUTTON           As Integer = 23
Public Const SM_RESERVED1            As Integer = 24
Public Const SM_RESERVED2            As Integer = 25
Public Const SM_RESERVED3            As Integer = 26
Public Const SM_RESERVED4            As Integer = 27
Public Const SM_CXMIN                As Integer = 28
Public Const SM_CYMIN                As Integer = 29
Public Const SM_CXSIZE               As Integer = 30
Public Const SM_CYSIZE               As Integer = 31
Public Const SM_CXFRAME              As Integer = 32
Public Const SM_CYFRAME              As Integer = 33
Public Const SM_CXMINTRACK           As Integer = 34
Public Const SM_CYMINTRACK           As Integer = 35
Public Const SM_CXDOUBLECLK          As Integer = 36
Public Const SM_CYDOUBLECLK          As Integer = 37
Public Const SM_CXICONSPACING        As Integer = 38
Public Const SM_CYICONSPACING        As Integer = 39
Public Const SM_MENUDROPALIGNMENT    As Integer = 40
Public Const SM_PENWINDOWS           As Integer = 41
Public Const SM_DBCSENABLED          As Integer = 42
Public Const SM_CMOUSEBUTTONS        As Integer = 43

Public Declare Function GetSystemMetrics Lib "USER32" (ByVal n As Integer) As Integer
