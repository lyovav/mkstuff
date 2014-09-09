Attribute VB_Name = "Gallery"
Option Explicit
DefInt A-Z

Sub StartGallery(mt As Boolean)
    If mt = True Then
        Dim thread As Long
        thread = CreateThread(0, 0, AddressOf LoadGalleryProc, 0, 0, 0)
        CloseHandle thread
    Else
        LoadGalleryProc Nothing
    End If
End Sub

Function LoadGalleryProc(ByVal param As IUnknown) As Long
    LoadGallery App.path + "gallery"
    LoadGalleryProc = 0
End Function

Sub LoadGallery(path As String)
    On Error GoTo ErrIn_LoadGallery
    Dim findHandle As Long
    Dim findData As WIN32_FIND_DATAA
    
    findHandle = FindFirstFileA(path + "\\*.*", findData)
    
    If findHandle <> INVALID_HANDLE_VALUE Then
        Dim findNext As Long
        Dim FileName As String
       
        findNext = True
        Do While findNext
            FileName = StripNulls(findData.cFileName)
        
            If FileName <> "." And FileName <> ".." Then ' skip current and upper dir
                ProcessGalleryEntry path, FileName, findData
            End If
            findNext = FindNextFileA(findHandle, findData)
        Loop
        
        FindClose findHandle
    End If
    
    Exit Sub
ErrIn_LoadGallery:
    FindClose findHandle
    Err.Raise Err.Number, Err.Source, Err.Description, Err.HelpFile, Err.HelpContext
End Sub

Sub ProcessGalleryEntry(path As String, FileName As String, ByRef findData As WIN32_FIND_DATAA)
    Dim pic As IPicture
    
    Debug.Print "PENTRY: " + str(findData.dwFileAttributes) + " `" + path + "\" + FileName + "`"
    
    pic = LoadPic(path + "\" + FileName)
End Sub
