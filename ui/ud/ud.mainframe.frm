VERSION 5.00
Begin VB.MDIForm Mainframe 
   Appearance      =   0  'Flat
   BackColor       =   &H00E0E0E0&
   Caption         =   "Michael Nikonov's Understanding Digital Electronics"
   ClientHeight    =   6660
   ClientLeft      =   225
   ClientTop       =   855
   ClientWidth     =   11220
   Icon            =   "ud.mainframe.frx":0000
   LinkTopic       =   "Michael Nikonov's Understanding Digital Electronics"
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu mnuFile 
      Caption         =   "File"
      Index           =   0
      Begin VB.Menu mnuNew 
         Caption         =   "New"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "Window"
      Begin VB.Menu mnuCloseDocWin 
         Caption         =   "Close document window"
         Shortcut        =   ^W
      End
   End
End
Attribute VB_Name = "Mainframe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private config As New WConf
Private child As New Collection
Private totalChildCount As Long

Private Sub mnuNew_Click()
    AddForm "Untitled...", True
End Sub

Private Sub mnuCloseDocWin_Click()
    Unload ActiveForm
End Sub

Private Sub mnuExit_Click()
    Unload Me
    End
End Sub

Private Sub MDIForm_Load()
    config.OnFormLoad Me, "1.0.0"
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    config.OnFormUnload Me
End Sub

Public Sub AddForm(capt As String, visbl As Boolean)
    Dim childFrame As New CDoc
    
    childFrame.Caption = capt
    childFrame.WindowState = vbMaximized
    childFrame.Visible = visbl

    totalChildCount = totalChildCount + 1
    child.Add childFrame, str(totalChildCount) + "> " + capt
End Sub

Public Sub Init(comandLine As String)
    AddForm "Trololo...", True
End Sub

