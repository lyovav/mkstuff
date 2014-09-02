VERSION 5.00
Begin VB.Form mainframe 
   Caption         =   "..."
   ClientHeight    =   11565
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   5460
   LinkTopic       =   "Form1"
   ScaleHeight     =   11565
   ScaleWidth      =   5460
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton button 
      Appearance      =   0  'Flat
      Height          =   735
      Index           =   0
      Left            =   240
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label log 
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Height          =   1935
      Left            =   120
      TabIndex        =   2
      Top             =   8760
      Width           =   5175
   End
   Begin VB.Label lcd 
      BackColor       =   &H00E0845C&
      BorderStyle     =   1  'Fixed Single
      Height          =   2415
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5175
   End
End
Attribute VB_Name = "mainframe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
DefInt A-Z

Private Sub Form_Load()
    InitButtons
    
    mainframe.Left = GetSetting(AppName, ConfSect0, ConfLeft, ConfLeftDefault)
    mainframe.Top = GetSetting(AppName, ConfSect0, ConfTop, ConfTopDefault)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    SaveSetting AppName, ConfSect0, ConfLeft, mainframe.Left
    SaveSetting AppName, ConfSect0, ConfTop, mainframe.Top
End Sub

Private Sub InitButtons()
    On Error Resume Next
    
End Sub
