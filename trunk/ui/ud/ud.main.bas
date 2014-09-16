Attribute VB_Name = "UdMain"
Option Explicit
DefInt A-Z

Public hInstance As Long

Private Sub Main()
    Randomize
    
    hInstance = GetModuleHandleANull(0)
    
    Debug.Print "APPENTRY: Mainframe `" + Mainframe.LinkTopic + "` started"
    Debug.Print "APPENTRY: Command line - `" + Command$ + "`"
    
    InitBasics
    
    Mainframe.Init
    Mainframe.Show
End Sub
