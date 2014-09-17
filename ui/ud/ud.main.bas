Attribute VB_Name = "AppEntry"
Option Explicit
DefInt A-Z

Private Declare Sub InitCommonControls Lib "COMCTL32" ()

Public hInstance As Long

Private Sub Main()
    Randomize
    
    Dim pn As New Pin
    Dim ct As ICell
    
    Set ct = Nothing
    Call pn.Connect(ct)
    
    hInstance = GetModuleHandleANull(0)
    InitCommonControls
    
    Debug.Print "APPENTRY: Mainframe `" + Mainframe.LinkTopic + "` started"
    Debug.Print "APPENTRY: Command line - `" + Command$ + "`"
    
    Mainframe.Init
    Mainframe.Show
End Sub
