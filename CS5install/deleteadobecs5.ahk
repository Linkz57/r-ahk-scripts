;doesn't actually seem to work. I should try using Windows' del command.
FileRemoveDir, c:\Adobe CS3, 1
FileRemoveDir, c:\Adobe CS4, 1
FileRemoveDir, c:\Adobe CS5, 1
MsgBox,0,Magic Trick,AND it's gone!,5
sleep 6000
FileDelete, c:\deleteadobecs5.exe