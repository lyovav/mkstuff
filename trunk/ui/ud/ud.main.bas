Attribute VB_Name = "UdMain"
Option Explicit
DefInt A-Z

Private Sub Main()
    Randomize
    
    Debug.Print "APPENTRY: Mainframe `" + Mainframe.LinkTopic + "` started"
    Debug.Print "APPENTRY: Command line - `" + Command$ + "`"
    
    InitBasics
    
    Mainframe.Init
    Mainframe.Show
End Sub
