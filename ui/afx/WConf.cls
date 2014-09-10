VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "WConf"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private appName As String

Private Const scConfig As String = "Common"
Private Const scLeft As String = "left"
Private Const scTop As String = "top"
Private Const scWidth As String = "width"
Private Const scHeight As String = "height"

Private Sub Class_Initialize()
    appName = ""
End Sub

Public Sub OnFormLoad(ByRef frm As Form, Optional strVersion As String = "1.0.0")
    On Error Resume Next
    
    Let appName = frm.LinkTopic + " " + strVersion

    Dim cx As Integer
    Dim cy As Integer
    Dim x As Integer
    Dim y As Integer
    
    cx = frm.Width
    cy = frm.Height
    x = ((GetSystemMetrics(SM_CXSCREEN) * Screen.TwipsPerPixelX) - cx) / 2
    y = ((GetSystemMetrics(SM_CYFULLSCREEN) * Screen.TwipsPerPixelY) - cy) / 2
    
    frm.left = GetSetting(appName, scConfig, scLeft, x)
    frm.top = GetSetting(appName, scConfig, scTop, y)
    frm.Width = GetSetting(appName, scConfig, scWidth, frm.Width)
    frm.Height = GetSetting(appName, scConfig, scHeight, frm.Height)
End Sub

Public Sub onFormUnload(ByRef frm As Form)
    On Error Resume Next

    SaveSetting appName, scConfig, scLeft, frm.left
    SaveSetting appName, scConfig, scTop, frm.top
    SaveSetting appName, scConfig, scWidth, frm.Width
    SaveSetting appName, scConfig, scHeight, frm.Height
End Sub

Public Sub LoadTextBox(ByRef tb As TextBox, Optional deft As String = "")
    tb.Text = GetSetting(appName, scConfig, tb.Name, deft)
End Sub

Public Sub SaveTextBox(ByRef tb As TextBox)
    SaveSetting appName, scConfig, tb.Name, tb.Text
End Sub

