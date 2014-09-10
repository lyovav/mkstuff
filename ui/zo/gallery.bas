Attribute VB_Name = "Gallery"
Option Explicit
DefInt A-Z

Public Const FetchInSeparatedThread As Boolean = True
Public Const FetchInSameThread As Boolean = False

Private Pictures() As IPictureDisp
Private picNum As Integer
Private bLoaded As Boolean
Private pbTarget As PictureBox
Private galleryTimer As Long
Private Const icGalleryTimer As Long = 1001
Public Path As String
Public SlideShowTimeout As String

Private Sub StartTimer()
    KillTimer 0, icGalleryTimer
    SetTimer 0, icGalleryTimer, CInt(SlideShowTimeout), AddressOf TimerProc
End Sub

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

Public Sub Fetch(target As PictureBox, loadMode As Boolean)
    Set pbTarget = target
    picNum = 0
    bLoaded = False
    
    If loadMode = FetchInSeparatedThread Then
        Dim thread As Long
        thread = CreateThread(0, 0, AddressOf LoadGalleryProc, 0, 0, 0)
        CloseHandle thread
    Else
        LoadGalleryProc Nothing
    End If
    
    StartTimer
End Sub

Private Function LoadGalleryProc(ByVal param As IUnknown) As Long
    LoadGallery Path
    LoadGalleryProc = 0
End Function

Private Sub LoadGallery(Path As String)
    On Error GoTo ErrIn_LoadGallery
    Dim findHandle As Long
    Dim findData As WIN32_FIND_DATAA
    
    findHandle = FindFirstFileA(Path + "\*.*", findData)
    If findHandle <> INVALID_HANDLE_VALUE Then
        Dim findNext As Long
        Dim FileName As String
        Dim counter As Integer
       
        findNext = True
        counter = 0
        Do While findNext
            FileName = StripNulls(findData.cFileName)
            ProcessEntry Path, FileName, findData, counter
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

Private Sub ProcessEntry(Path As String, FileName As String, ByRef findData As WIN32_FIND_DATAA, ByRef num As Integer)
    On Error GoTo ErrIn_Process
    
    Dim tempp As IPictureDisp
    Set tempp = LoadPix(Path + "\" + FileName)
    
    ReDim Preserve Pictures(0 To num + 1) As IPictureDisp
    Set Pictures(num) = tempp
    
    Debug.Print "PENTRY: " + str(num) + " " _
        + str(CInt(Pictures(num).Width)) + " x" _
        + str(CInt(Pictures(num).Height)) _
        + " `" + Path + "\" + FileName + "`"
    
    num = num + 1
    
    Exit Sub
    
ErrIn_Process:
    Debug.Print Err.Description
End Sub

Private Sub DrawPic(pic As IPictureDisp)
    Dim px As Single
    Dim py As Single
    Dim cx As Single
    Dim cy As Single
    Dim x As Single
    Dim y As Single
    Dim asp As Single
    
    pbTarget.AutoSize = False
    pbTarget.ScaleMode = vbTwips
       
    cx = pbTarget.Width
    cy = pbTarget.Height
    px = pic.Width
    py = pic.Height
    
    If py > cy Then
        asp = cy / py
        px = px * asp
        py = cy
    End If
    
    If px > cx Then
        asp = cx / px
        px = cx
        py = py * asp
    End If
   
    x = (cx - px) / 2
    y = (cy - py) / 2
    
    pbTarget.AutoRedraw = True
    If pbTarget.HasDC = True Then
        PatBlt pbTarget.hDC, 0, 0, cx / Screen.TwipsPerPixelX, cy / Screen.TwipsPerPixelY, WHITENESS
    End If
    pbTarget.PaintPicture pic, x, y, px, py
    pbTarget.Picture = pbTarget.Image
End Sub

Public Sub ChangePic(dex As Integer)
    On Error GoTo ErrpUpdateGalleryPic
    DrawPic Pictures(dex)
    Exit Sub
ErrpUpdateGalleryPic:
    Debug.Print "!!! GALLERY: " + Err.Description
End Sub

Private Sub TimerProc()
    ChangePic GetRndIndex()
End Sub
