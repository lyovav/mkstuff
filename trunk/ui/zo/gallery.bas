Attribute VB_Name = "Gallery"
Option Explicit
DefInt A-Z

Private tempPic As PictureBox

Public Sub StartGallery(mt As Boolean, ByRef tpb As PictureBox)
    Set tempPic = tpb

    If mt = True Then
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
       
        findNext = True
        Do While findNext
            FileName = StripNulls(findData.cFileName)
            ProcessGalleryEntry path, FileName, findData
            findNext = FindNextFileA(findHandle, findData)
        Loop
        
        FindClose findHandle
    End If
    
    Exit Sub
ErrIn_LoadGallery:
    FindClose findHandle
    Err.Raise Err.Number, Err.Source, Err.Description, Err.HelpFile, Err.HelpContext
End Sub

Private Sub ProcessGalleryEntry(path As String, FileName As String, ByRef findData As WIN32_FIND_DATAA)
    On Error GoTo ErrIn_Process
    
    Debug.Print "PENTRY: " + str(findData.dwFileAttributes) + " `" + path + "\" + FileName + "`"
    
    tempPic.Picture = LoadPix(path + "\" + FileName)
    
    Exit Sub
    
ErrIn_Process:
    Debug.Print Err.Description
End Sub
