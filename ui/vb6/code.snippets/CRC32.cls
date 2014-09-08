VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CRC32"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Author: Alvaro Redondo <merlin@sevillaonline.com>
' http://www.sevillaonline.com/ActiveX
' Last modification date: 22.07.2001
' Description: CRC32 is an algorithm used to create a validation string of data.

Option Explicit

Private m_arrTable(0 To 255) As Long, m_lCheckSum As Long

Property Get Check() As String
    Dim arrData() As Byte, dTemp As Long, sTemp As String
    arrData = StrConv("123456789", vbFromUnicode)
    sTemp = Hex(Calculate(arrData))
    Check = String(8 - Len(sTemp), "0") & sTemp
End Property

Property Get CheckSum() As Long
    CheckSum = m_lCheckSum
End Property

Property Get Poly() As String
    Dim sTemp As String
    sTemp = Hex(&HEDB88320)
    Poly = String(8 - Len(sTemp), "0") & sTemp
End Property

Private Function Calculate(arrData() As Byte) As Long
    Dim lCheckSum As Long, N As Long, lTemp1 As Long, lTemp2 As Long
    lCheckSum = &HFFFFFFFF
    For N = 0 To UBound(arrData)
        lTemp1 = ((lCheckSum And &HFFFFFF00) \ &H100) And &HFFFFFF
        lTemp2 = m_arrTable((lCheckSum And &HFF) Xor CLng(arrData(N)))
        lCheckSum = lTemp1 Xor lTemp2
    Next
    lCheckSum = lCheckSum Xor &HFFFFFFFF
    Calculate = lCheckSum
End Function

Function CRC(arrData() As Byte) As Long
    Dim lCheckSum As Long
    lCheckSum = Calculate(arrData)
    m_lCheckSum = lCheckSum
    CRC = lCheckSum
End Function

Private Sub CreateTable()
    Dim N As Long, M As Long, lRegister As Long, lTemp As Long
    For N = 0 To 255
        lRegister = N
        For M = 0 To 7
            lTemp = ((lRegister And &HFFFFFFFE) \ &H2) And &H7FFFFFFF
            If lRegister And &H1 Then
                lRegister = lTemp Xor &HEDB88320
            Else
                lRegister = lTemp
            End If
        Next
        m_arrTable(N) = lRegister
    Next
End Sub

Private Sub Class_Initialize()
    CreateTable
End Sub
