VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Michael Nikonov's: The Ohm Rulez"
   ClientHeight    =   9165
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   7215
   LinkTopic       =   "Michael Nikonov's: The Ohm Rulez"
   MaxButton       =   0   'False
   Picture         =   "zo.main.frx":0000
   ScaleHeight     =   9165
   ScaleWidth      =   7215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox pbGallery 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H80000008&
      Height          =   3255
      Left            =   120
      ScaleHeight     =   3225
      ScaleWidth      =   6945
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   5760
      Width           =   6975
   End
   Begin VB.CheckBox constI 
      BackColor       =   &H00FFFFFF&
      Caption         =   "const"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1560
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   4680
      Width           =   1215
   End
   Begin VB.CheckBox constU 
      BackColor       =   &H00FFFFFF&
      Caption         =   "const"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3000
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CheckBox constR 
      BackColor       =   &H00FFFFFF&
      Caption         =   "const"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4440
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   4680
      Width           =   1215
   End
   Begin VB.TextBox ebR 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00F0FFFF&
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   525
      Left            =   3720
      TabIndex        =   0
      Text            =   "0"
      Top             =   5010
      Width           =   2655
   End
   Begin VB.TextBox ebU 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00F0FFF0&
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   525
      Left            =   2280
      TabIndex        =   1
      Text            =   "0"
      Top             =   3090
      Width           =   2655
   End
   Begin VB.TextBox ebI 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00FFF0FF&
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   525
      Left            =   840
      TabIndex        =   2
      Text            =   "0"
      Top             =   5010
      Width           =   2655
   End
   Begin VB.Label lbTop 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "P = IU"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   20.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   1
      Left            =   120
      TabIndex        =   4
      Top             =   240
      Width           =   6975
   End
   Begin VB.Line Line2 
      BorderWidth     =   3
      X1              =   3600
      X2              =   240
      Y1              =   1200
      Y2              =   5640
   End
   Begin VB.Line Line3 
      BorderWidth     =   3
      X1              =   3600
      X2              =   6960
      Y1              =   1200
      Y2              =   5640
   End
   Begin VB.Line Line1 
      BorderWidth     =   3
      X1              =   6960
      X2              =   240
      Y1              =   5640
      Y2              =   5640
   End
   Begin VB.Line Line4 
      BorderWidth     =   2
      X1              =   1680
      X2              =   5520
      Y1              =   3720
      Y2              =   3720
   End
   Begin VB.Line Line5 
      BorderWidth     =   3
      X1              =   3600
      X2              =   3600
      Y1              =   5640
      Y2              =   3720
   End
   Begin VB.Label lbU 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "U"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Index           =   0
      Left            =   3000
      TabIndex        =   5
      Top             =   2040
      Width           =   1215
   End
   Begin VB.Label lbI 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "I"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Index           =   1
      Left            =   1920
      TabIndex        =   6
      Top             =   3840
      Width           =   1215
   End
   Begin VB.Label lbR 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Patopian 1986"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Index           =   0
      Left            =   4080
      TabIndex        =   3
      Top             =   3840
      Width           =   1215
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private Conf As New WConf
Private Dbl As New CDouble
Private gdipToken As Long
Private galleryPath As String
Private Const scGalleryPath As String = "GalleryPath"
Private Const scGalleryTimeout As String = "SlideShowTimeout"

Private Sub Form_Load()
    On Error GoTo Fail
    Dbl.Init
    Randomize
    gdipToken = InitGDIPlus
    
    Conf.OnFormLoad Me, "2.0.2"
    
    Conf.LoadTextBox ebR, "0"
    Conf.LoadTextBox ebU, "0"
    
    constI.Enabled = False
    constU.Enabled = False
    constR.Enabled = False

    constR.value = 1
    
    updateValues True, True, False
    
    Gallery.Path = Conf.GetString(scGalleryPath, "gallery")
    Gallery.SlideShowTimeout = Conf.GetString(scGalleryTimeout, "1500")
    
    Gallery.Fetch pbGallery, Gallery.FetchInSameThread ' FetchInSeparatedThread
    Exit Sub
Fail:
    Err.Description = Err.Source + "(" + str(Err.Number) + "): " + Err.Description
    Debug.Print "!!! > " + Err.Description
    MsgBox Err.Description, vbCritical, Me.Caption
    Resume Next
    ' Err.Raise Err.Number, Err.Source, Err.Description, Err.HelpFile, Err.HelpContext
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Conf.OnFormUnload Me
    
    Conf.SaveTextBox ebR
    Conf.SaveTextBox ebU
    
    Conf.SaveString scGalleryPath, Gallery.Path
    Conf.SaveString scGalleryTimeout, Gallery.SlideShowTimeout
    
    FreeGDIPlus gdipToken
End Sub

Private Sub pbGallery_Click()
    Gallery.ChangePic Gallery.GetRndIndex()
End Sub

Private Sub selText(ByRef tb As TextBox)
    tb.SelStart = 0
    tb.SelLength = Len(tb.Text)
End Sub

Private Sub ebR_GotFocus()
    selText ebR
End Sub

Private Sub ebU_GotFocus()
    selText ebU
End Sub

Private Sub ebI_GotFocus()
    selText ebI
End Sub

Private Sub ebR_KeyUp(KeyCode As Integer, Shift As Integer)
    updateValues True, False, False
End Sub

Private Sub ebU_KeyUp(KeyCode As Integer, Shift As Integer)
    updateValues False, True, False
End Sub

Private Sub ebI_KeyUp(KeyCode As Integer, Shift As Integer)
    updateValues False, False, True
End Sub

Private Function calc_I(ByVal U As Double, ByVal R As Double) As Double
    If R = 0 Then R = 1
    calc_I = U / R
End Function

Private Function calc_U(ByVal I As Double, ByVal R As Double) As Double
    calc_U = I * R
End Function

Private Function calc_R(ByVal I As Double, ByVal U As Double) As Double
    calc_R = U / I
End Function

Private Function calc_P(ByVal I As Double, ByVal U As Double) As Double
    calc_P = I * U
End Function

Private Sub updateValues(R_Changed As Boolean, U_Changed As Boolean, I_Changed As Boolean)
    On Error Resume Next
    
    If R_Changed Or U_Changed Then
        ebI.Text = Format(calc_I(Dbl.FromString(ebU.Text), Dbl.FromString(ebR.Text)), "0.0000")
    End If
    
    If I_Changed Then
        ebU.Text = Format(calc_U(Dbl.FromString(ebI.Text), Dbl.FromString(ebR.Text)), "0.0000")
    End If
    
    lbTop(1).Caption = "P = " + CStr(calc_P(Dbl.FromString(ebI.Text), Dbl.FromString(ebU.Text)))
End Sub

