VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Michael Nikonov's: The Ohm Rulez"
   ClientHeight    =   7635
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   7170
   LinkTopic       =   "The Ohm Rulez"
   ScaleHeight     =   7635
   ScaleWidth      =   7170
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox ebR 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   3720
      TabIndex        =   5
      Text            =   "0"
      Top             =   4920
      Width           =   1935
   End
   Begin VB.TextBox ebU 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   2640
      TabIndex        =   4
      Text            =   "0"
      Top             =   3000
      Width           =   1935
   End
   Begin VB.TextBox ebI 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1560
      TabIndex        =   3
      Text            =   "0"
      Top             =   4920
      Width           =   1935
   End
   Begin VB.Label lbBottom 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Index           =   0
      Left            =   120
      TabIndex        =   7
      Top             =   5880
      Width           =   6975
   End
   Begin VB.Label lbTop 
      Alignment       =   2  'Center
      Caption         =   "P = IU"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Index           =   1
      Left            =   120
      TabIndex        =   6
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
      Caption         =   "U"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   0
      Left            =   3000
      TabIndex        =   2
      Top             =   2040
      Width           =   1215
   End
   Begin VB.Label lbI 
      Alignment       =   2  'Center
      Caption         =   "I"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   1
      Left            =   1920
      TabIndex        =   1
      Top             =   3840
      Width           =   1215
   End
   Begin VB.Label lbR 
      Alignment       =   2  'Center
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   36
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Index           =   0
      Left            =   4080
      TabIndex        =   0
      Top             =   3840
      Width           =   1215
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Conf As New WConf

Private Sub Form_Load()
    Conf.appName = "The Ohm Rulez"
    Conf.onFormLoad Me
    
    updateTextBoxes
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Conf.onFormUnload Me
End Sub

Private Function calc_I(ByVal U As Double, ByVal R As Double) As Double
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

Private Sub updateTextBoxes()
    On Error Resume Next
    
    Dim I As Double, uI As Double
    Dim U As Double, uU As Double
    Dim R As Double, uR As Double
    
    I = CDbl(ebI.Text)
    U = CDbl(ebU.Text)
    R = CDbl(ebR.Text)
    
    uI = calc_I(U, R)
    uU = calc_U(I, R)
    uR = calc_R(I, U)
    uP = calc_P(I, U)
    
    ebI.Text = Format(uI, "0.000")
    ebU.Text = Format(uU, "0.000")
    ebR.Text = Format(uR, "0.000")
    lbTop(1).Caption = "P = " + Format(uP, "0.000")
End Sub

