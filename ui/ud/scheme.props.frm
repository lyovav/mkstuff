VERSION 5.00
Begin VB.Form DocProps 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   4230
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   3675
   Icon            =   "scheme.props.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4230
   ScaleWidth      =   3675
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Caption         =   "Dimensions"
      Height          =   1695
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3375
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   2400
         TabIndex        =   2
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   1560
         TabIndex        =   1
         Top             =   360
         Width           =   735
      End
      Begin VB.Label Label1 
         Caption         =   "Columns x Rows ="
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   360
         Width           =   1455
      End
   End
End
Attribute VB_Name = "DocProps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

