VERSION 5.00
Begin VB.MDIForm Mainframe 
   BackColor       =   &H00404040&
   Caption         =   "Michael Nikonov's Understanding Digital Electronics"
   ClientHeight    =   8775
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   14820
   LinkTopic       =   "Michael Nikonov's Understanding Digital Electronics"
   StartUpPosition =   3  'Windows Default
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
    config.OnFormUnload Me, "1.0.0"
End Sub
