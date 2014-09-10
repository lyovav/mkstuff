Attribute VB_Name = "Gallery"
Option Explicit
DefInt A-Z

Public Const FetchInSeparatedThread As Boolean = True
Public Const FetchInSameThread As Boolean = False

Public Pictures() As IPictureDisp
Private picNum As Integer
Private bLoaded As Boolean

Public Function IsReady() As Boolean
    IsReady = bLoaded
End Function

Public Function GetRndIndex() As Integer
    Dim lim As Single
    Dim ind As Integer
    
    lim = picNum
    ind = CInt(Rnd * lim)
    
    GetRndIndex = ind
End Function

Public Sub Fetch(loadMode As Boolean)
    picNum = 0
    bLoaded = False
    
    If loadMode = FetchInSeparatedThread Then
        Dim thread As Long
        thread = CreateThread(0, 0, AddressOf LoadGalleryProc, 0, 0, 0)
        CloseHandle thread
    Else
        LoadGalleryProc Nothing
    End If
End Sub

Private Function LoadGalleryProc(ByVal param As IUnknown) As Long
    LoadGallery App.path + "\gallery"
    LoadGalleryProc = 0
End Function

Private Sub LoadGallery(path As String)
    On Error GoTo ErrIn_LoadGallery
    Dim findHandle As Long
    Dim findData As WIN32_FIND_DATAA
    
    findHandle = FindFirstFileA(path + "\*.*", findData)
    If findHandle <> INVALID_HANDLE_VALUE Then
        Dim findNext As Long
        Dim FileName As String
        Dim counter As Integer
       
        findNext = True
        counter = 0
        Do While findNext
            FileName = StripNulls(findData.cFileName)
            ProcessGalleryEntry path, FileName, findData, counter
            findNext = FindNextFileA(findHandle, findData)
        Loop
        
        FindClose findHandle
        bLoaded = True
        picNum = counter
    End If
    
    Exit Sub
ErrIn_LoadGallery:
    FindClose findHandle
    Err.Raise Err.Number, Err.Source, Err.Description, Err.HelpFile, Err.HelpContext
End Sub

Private Sub ProcessGalleryEntry(path As String, FileName As String, ByRef findData As WIN32_FIND_DATAA, ByRef num As Integer)
    On Error GoTo ErrIn_Process
    
    Debug.Print "PENTRY: " + str(findData.dwFileAttributes) + " `" + path + "\" + FileName + "`"
    
    Dim tempp As IPictureDisp
    Set tempp = LoadPix(path + "\" + FileName)
    
    ReDim Preserve Pictures(0 To num + 1) As IPictureDisp
    Set Pictures(num) = tempp
    num = num + 1
    
    Exit Sub
    
ErrIn_Process:
    Debug.Print Err.Description
End Sub

