; doesn't actually seem to work all the time. Needs more testing and observation than I'm willing to give it now.
SetWorkingDir, C:\
if ErrorLevel
    ExitApp
FileRemoveDir, c:\Adobe CS3, 1
FileRemoveDir, c:\Adobe CS4, 1
FileRemoveDir, c:\Adobe CS5, 1

RunWait %ComSpec% /C "RMDIR /S /Q c:\Adobe CS3"
FileRemoveDir, c:\Adobe CS4, 1
FileRemoveDir, c:\Adobe CS5, 1
MsgBox,0,Magic Trick,AND it's gone!,5
sleep 6000
FileDelete, c:\deleteadobecs5.exe
Run %ComSpec% /C "del c:\deleteadobecs5.exe"