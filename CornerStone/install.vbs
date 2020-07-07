Option Explicit
Dim strShortcutPath, strDirectory, strIconLocation
Dim strMenuSrcPath, strConfigSrcPath, strLogSrcPath, strMenuDstPath, strConfigDstPath, strLogDstPath
Dim strBinSrcPath, strBinDstPath
Dim strRunPath
Dim objFSO, objFolder, objShortcut, objShell
Dim btn


Const strTitle = "CornerStone Multihack"
Const strUri = "https://www.unknowncheats.me/forum/cs-go-releases/352322-cornerstone-internal-external-multihack.html"
Const bIncompatible = True

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strDirectory = objShell.ExpandEnvironmentStrings("%APPDATA%\CornerStone")

strMenuSrcPath = ".\dist\ui"
strMenuDstPath = objFSO.BuildPath(strDirectory, "ui")
strConfigSrcPath = ".\dist\cfg"
strConfigDstPath = objFSO.BuildPath(strDirectory, "cfg")
strLogSrcPath = ".\dist\log"
strLogDstPath = objFSO.BuildPath(strDirectory, "log")
strMenuSrcPath = ".\dist\ui"
strMenuDstPath = objFSO.BuildPath(strDirectory, "ui")
strBinSrcPath = ".\dist\bin"
strBinDstPath = objFSO.BuildPath(strDirectory, "bin")

If objFSO.FolderExists(strDirectory) Then
    If bIncompatible = True Then
        btn = MsgBox("This version incompatible with previous one. Do you want to uninstall previous version?", vbYesNo Or vbQuestion, strTitle)
        If btn = vbNo Then
            MsgBox "Please, delete CornerStone folder and try again.", vbExclamation, strTitle
            WScript.quit
        End If
        Set objFolder = objFSO.GetFolder(strDirectory)
        objFolder.Delete(True)
        Set objFolder = objFSO.CreateFolder(strDirectory)
    End If
Else
    Set objFolder = objFSO.CreateFolder(strDirectory)
End If

objFSO.CopyFolder strMenuSrcPath, strMenuDstPath, 1
objFSO.CopyFolder strBinSrcPath, strBinDstPath, 1
On Error Resume Next
objFSO.CopyFolder strConfigSrcPath, strConfigDstPath, 1
objFSO.CopyFolder strLogSrcPath, strLogDstPath, 1
On Error Goto 0

strShortcutPath = objFSO.BuildPath(objShell.SpecialFolders("Desktop"), "CornerStone Folder.lnk")
Set objShortcut = objShell.CreateShortcut(strShortcutPath)
objShortcut.Description = strTitle & " Folder"
objShortcut.TargetPath = strDirectory
objShortcut.Arguments = "/Arguments:Shortcut"
strIconLocation = objFSO.BuildPath(strDirectory, "ui\favicon.ico")
objShortcut.IconLocation = strIconLocation
objShortcut.Save

strShortcutPath = objFSO.BuildPath(strDirectory, "Run CornerStone.lnk")
Set objShortcut = objShell.CreateShortcut(strShortcutPath)
objShortcut.Description = "Run " & strTitle
strRunPath = objFSO.BuildPath(strDirectory, "bin")
strRunPath = objFSO.BuildPath(strRunPath, "run.cmd")
objShortcut.TargetPath = strRunPath
strIconLocation = objFSO.BuildPath(strDirectory, "ui\favicon.ico")
objShortcut.IconLocation = strIconLocation
objShortcut.Save

If err.number = vbEmpty then
    MsgBox strTitle & " successfully installed!", vbInformation, strTitle
    btn = MsgBox("Do you want to open forum thread to see more information?", vbYesNo Or vbQuestion, strTitle)
    If btn = vbYes Then
        objShell.run(strUri)
    End If
    objShell.run("explorer " & strDirectory & "\")
Else
    WScript.echo "VBScript Error: " & err.number
    WScript.quit
End If