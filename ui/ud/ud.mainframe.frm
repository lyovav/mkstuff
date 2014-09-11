VERSION 5.00
Begin VB.MDIForm Mainframe 
   BackColor       =   &H00E0E0E0&
   Caption         =   "Michael Nikonov's Understanding Digital Electronics"
   ClientHeight    =   8775
   ClientLeft      =   225
   ClientTop       =   855
   ClientWidth     =   14820
   Icon            =   "ud.mainframe.frx":0000
   LinkTopic       =   "Michael Nikonov's Understanding Digital Electronics"
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu mFile 
      Caption         =   "File"
      Index           =   0
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
End
Attribute VB_Name = "Mainframe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private config As New WConf

Private Sub MDIForm_Load()
    config.OnFormLoad Me, "1.0.0"
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    config.OnFormUnload Me
End Sub

Private Sub mnuExit_Click()
    Unload Me
End Sub
