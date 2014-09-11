Attribute VB_Name = "UdMain"
Option Explicit
DefInt A-Z

Private Sub Main()
    Debug.Print "APPENTRY: Mainframe `" + Mainframe.LinkTopic + "` started"
    Debug.Print "APPENTRY: Command line - `" + Command$ + "`"
    
    Mainframe.Init Command$
    Mainframe.Show
End Sub
