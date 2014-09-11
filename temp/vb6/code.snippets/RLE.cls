VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "RLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Author: Alvaro Redondo <merlin@sevillaonline.com>
' http://www.sevillaonline.com/ActiveX
' Version: 1.0
' Last modification date: 22.07.2001
' Description: RLE (Run Length Encoding) is a very simple compression algorithm, mainly used for
'               streams of data with strings of repeating characters. Please note that you
'               might find different, not compatible implementations.

Option Explicit

Private Type SYSTEMTIME
        wYear As Integer
        wMonth As Integer
        wDayOfWeek As Integer
        wDay As Integer
        wHour As Integer
        wMinute As Integer
        wSecond As Integer
        wMilliseconds As Integer
End Type

Private Declare Sub GetSystemTime Lib "kernel32" (lpSystemTime As SYSTEMTIME)

Private m_dLastCompressionRatio As Double, m_dLastCount As Double

Property Get LastCompressionRatio() As Double
    LastCompressionRatio = m_dLastCompressionRatio
End Property

Property Get LastCount() As Double
    LastCount = m_dLastCount / 1000
End Property

Sub Compress(arrInput() As Byte, arrOutput() As Byte)

    Dim CountINI As SYSTEMTIME, CountEND As SYSTEMTIME
    GetSystemTime CountINI

    Dim lInPos As Long, lOutPos As Long, _
        bCount As Long, bRepeatCount As Long, _
        bChar As Long, N As Long

    ReDim arrOutput(LBound(arrInput) To (UBound(arrInput) * 1.4)) As Byte
    lOutPos = LBound(arrOutput)

    For lInPos = LBound(arrInput) To UBound(arrInput)
        bCount = bCount + 1
        If bCount = 1 Then
            bChar = arrInput(lInPos)
            bRepeatCount = 1
        Else
            If arrInput(lInPos) = bChar Then
                bRepeatCount = bRepeatCount + 1
                If bCount > bRepeatCount Then
                    If UBound(arrInput) > lInPos Then
                        If arrInput(lInPos + 1) = bChar Then
                            arrOutput(lOutPos) = bCount - bRepeatCount
                            For N = 1 To (bCount - bRepeatCount)
                                arrOutput(lOutPos + N) = arrInput(lInPos - bCount + N)
                            Next
                            lOutPos = lOutPos + (bCount - bRepeatCount) + 1
                            bCount = bRepeatCount
                        End If
                    Else
                        If bCount = 128 Or bRepeatCount > 2 Then
                            arrOutput(lOutPos) = bCount - bRepeatCount
                            For N = 1 To (bCount - bRepeatCount)
                                arrOutput(lOutPos + N) = arrInput(lInPos - bCount + N)
                            Next
                            lOutPos = lOutPos + (bCount - bRepeatCount) + 1
                            bCount = bRepeatCount
                        End If
                    End If
                End If
                If bRepeatCount = &H80 Then
                    arrOutput(lOutPos) = &HFF
                    arrOutput(lOutPos + 1) = bChar
                    lOutPos = lOutPos + 2
                    bRepeatCount = 1
                    bCount = 1
                End If
            Else
                If bRepeatCount > 2 Then
                    arrOutput(lOutPos) = (bRepeatCount Or &H80)
                    arrOutput(lOutPos + 1) = bChar
                    lOutPos = lOutPos + 2
                    bCount = 1
                End If
                bChar = arrInput(lInPos)
                bRepeatCount = 1
            End If
            If bCount = &H80 Then
                arrOutput(lOutPos) = bCount - bRepeatCount
                For N = 1 To (bCount - bRepeatCount)
                    arrOutput(lOutPos + N) = arrInput(lInPos - 128 + N)
                Next
                lOutPos = lOutPos + (bCount - bRepeatCount) + 1
                bCount = bRepeatCount
            End If
        End If
    Next

    If bRepeatCount > 2 Then
        arrOutput(lOutPos) = bRepeatCount Or &H80
        arrOutput(lOutPos + 1) = bChar
        lOutPos = lOutPos + 2
    ElseIf bCount > 1 Then
        arrOutput(lOutPos) = bCount
        For N = 1 To bCount
            arrOutput(lOutPos + N) = arrInput(lInPos - bCount + N - 1)
        Next
        lOutPos = lOutPos + bCount + 1
    Else
        arrOutput(lOutPos) = &H1
        arrOutput(lOutPos + 1) = bChar
        lOutPos = lOutPos + 2
    End If
    ReDim Preserve arrOutput(LBound(arrOutput) To lOutPos - 1)

    m_dLastCompressionRatio = _
        CDbl(UBound(arrOutput) - LBound(arrOutput) + 1) / (UBound(arrInput) - LBound(arrInput) + 1)

    GetSystemTime CountEND
    m_dLastCount = CDbl((CountEND.wMinute - CountINI.wMinute)) * 60000 + CDbl((CountEND.wSecond - CountINI.wSecond)) * 1000 + (CountEND.wMilliseconds - CountINI.wMilliseconds)

End Sub

Sub UnCompress(arrInput() As Byte, arrOutput() As Byte)

    Dim CountINI As SYSTEMTIME, CountEND As SYSTEMTIME
    GetSystemTime CountINI

    Dim lInPos As Long, lOutPos As Long, lLength As Long, lStep As Long, N As Long

'   Calculate output size
    lInPos = LBound(arrInput)
    Do
        lStep = arrInput(lInPos) And &H7F
        lLength = lLength + lStep
        If arrInput(lInPos) And &H80 Then
            lInPos = lInPos + 2
        Else
            lInPos = lInPos + lStep + 1
        End If
    Loop Until lInPos > UBound(arrInput)
    ReDim arrOutput(0 To (lLength - 1)) As Byte

'   Uncompress
    lInPos = LBound(arrInput)
    lOutPos = LBound(arrOutput)
    Do
        lStep = arrInput(lInPos) And &H7F
        If arrInput(lInPos) And &H80 Then
            For N = 0 To lStep - 1
                arrOutput(lOutPos + N) = arrInput(lInPos + 1)
            Next
            lOutPos = lOutPos + lStep
            lInPos = lInPos + 2
        Else
            For N = 0 To lStep - 1
                arrOutput(lOutPos + N) = arrInput(lInPos + N + 1)
            Next
            lOutPos = lOutPos + lStep
            lInPos = lInPos + lStep + 1
        End If
    Loop Until lInPos > UBound(arrInput)

    m_dLastCompressionRatio = _
        CDbl(UBound(arrInput) - LBound(arrInput) + 1) / (UBound(arrOutput) - LBound(arrOutput) + 1)

    GetSystemTime CountEND
    m_dLastCount = CDbl((CountEND.wMinute - CountINI.wMinute)) * 60000 + CDbl((CountEND.wSecond - CountINI.wSecond)) * 1000 + (CountEND.wMilliseconds - CountINI.wMilliseconds)

End Sub
