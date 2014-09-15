Attribute VB_Name = "FileIO"
Option Explicit
DefInt A-Z

#If False Then

Public Sub BinLoadScheme(fName As String, ByRef scheme As CScheme)
    On Error GoTo ErrReadBin
    
    Dim fn As Integer
    Dim fs As Long
    Dim reqLen As Long
    
    reqLen = Len(items(0, 0)) * numCols * numRows

    fn = FreeFile
    Open filename For Binary Access Read As #fn Len = reqLen
    fs = LOF(fn)
    
    Get #fn, , items
    
    Close #fn
    Exit Sub
    
ErrReadBin:
    Debug.Print "Error: `" + filename + "` - " + Err.Description
    Close #fn
End Sub

Public Sub BinSaveScheme(filename As String, ByRef items() As CellDesc, numCols As Long, numRows As Long)
    On Error GoTo ErrWriteBin
    
    Dim fn As Integer
    Dim fs As Long
    Dim reqLen As Long
    
    reqLen = Len(items(0, 0)) * numCols * numRows

    fn = FreeFile
    Open filename For Binary Access Write As #fn Len = reqLen
    fs = LOF(fn)
    
    Put #fn, , items
    
    Close #fn
    Exit Sub
    
ErrWriteBin:
    Debug.Print "Error: `" + filename + "` - " + Err.Description
    Close #fn
End Sub

#End If
