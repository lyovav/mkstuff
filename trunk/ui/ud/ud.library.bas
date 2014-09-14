Attribute VB_Name = "UdLib"
Option Explicit
DefInt A-Z

Private Const csLibPath         As String = "library\"
Private Const csMeasureIni      As String = csLibPath + "measure.ini"
Private Const csVoltmeter       As String = "voltmeter"
Private Const csAmpermeter      As String = "ampermeter"
Private Const csPics            As String = "pics"
Private Const csSign            As String = "sign"
Private Const csUnit            As String = "unit"

Public Type MeterDesc
    Pics As String
    Sign As String
    Unit As String
End Type

Public MeasureIniPath As String

Private Voltmeter As MeterDesc
Private Ampermeter As MeterDesc

Public Sub InitUDLibrary()
    On Error GoTo InitLibErr
    
    MeasureIniPath = App.Path + "\" + csMeasureIni
    
    With Voltmeter
        .Pics = GetIniString(csVoltmeter, csPics, MeasureIniPath)
        .Sign = GetIniString(csVoltmeter, csSign, MeasureIniPath)
        .Unit = GetIniString(csVoltmeter, csUnit, MeasureIniPath)
    End With
    
    With Ampermeter
        .Pics = GetIniString(csAmpermeter, csPics, MeasureIniPath)
        .Sign = GetIniString(csAmpermeter, csSign, MeasureIniPath)
        .Unit = GetIniString(csAmpermeter, csUnit, MeasureIniPath)
    End With
        
    Exit Sub
InitLibErr:
            
End Sub
