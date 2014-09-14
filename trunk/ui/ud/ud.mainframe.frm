VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.Ocx"
Begin VB.MDIForm Mainframe 
   Appearance      =   0  'Flat
   BackColor       =   &H00E0E0E0&
   Caption         =   "Michael Nikonov's: Understanding Digital Electronics"
   ClientHeight    =   6660
   ClientLeft      =   225
   ClientTop       =   870
   ClientWidth     =   11220
   Icon            =   "ud.mainframe.frx":0000
   LinkTopic       =   "Michael Nikonov's Understanding Digital Electronics"
   StartUpPosition =   3  'Windows Default
   Begin ComctlLib.Toolbar tbMain 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11220
      _ExtentX        =   19791
      _ExtentY        =   741
      ButtonWidth     =   609
      AllowCustomize  =   0   'False
      _Version        =   327682
      BorderStyle     =   1
   End
   Begin ComctlLib.StatusBar sbMain 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   6285
      Width           =   11220
      _ExtentX        =   19791
      _ExtentY        =   661
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "File"
      Index           =   0
      Begin VB.Menu mnuNew 
         Caption         =   "New"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnuScheme 
      Caption         =   "Scheme"
      Begin VB.Menu mnuIns 
         Caption         =   "Insert"
         Begin VB.Menu mnuInsWire 
            Caption         =   "Wire"
         End
         Begin VB.Menu mnuInsVoltmeter 
            Caption         =   "Voltmeter"
         End
         Begin VB.Menu mnuInsAmpermeter 
            Caption         =   "Ampermeter"
         End
      End
   End
   Begin VB.Menu mnuWindow 
      Caption         =   "Window"
      Begin VB.Menu mnuWindowList 
         Caption         =   "List"
         WindowList      =   -1  'True
      End
      Begin VB.Menu mnuSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTileHorz 
         Caption         =   "Tile horizontally"
      End
      Begin VB.Menu mnuTieVert 
         Caption         =   "Tile vertically"
      End
      Begin VB.Menu mnuCascade 
         Caption         =   "Cascade"
      End
      Begin VB.Menu mnuSep 
         Caption         =   "-"
      End
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
'Private child As New Collection
'Private totalChildCount As Long

Private Sub mnuNew_Click()
    AddForm "Untitled...", True
End Sub

Private Sub mnuCloseDocWin_Click()
    On Error Resume Next
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
    childFrame.AddTo Me, capt, visbl, vbMaximized
    
    'totalChildCount = totalChildCount + 1
    'child.Add childFrame, str(totalChildCount) + "> " + capt
End Sub

Private Sub mnuTieVert_Click()
    Arrange vbTileVertical
End Sub

Private Sub mnuTileHorz_Click()
    Arrange vbTileHorizontal
End Sub

Private Sub mnuCascade_Click()
    Arrange vbCascade
End Sub

Public Sub Init()
    AddForm "Trololo...", True
End Sub

