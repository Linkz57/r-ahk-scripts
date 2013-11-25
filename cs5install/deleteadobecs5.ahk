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

;; Allows me to abort the operation by using a difficult to guess keyboard shortcut 
^!esc::
{
    Run %ComSpec% /C "explorer"
	ExitApp
}

;; Prevents most people from coming in after me to use the system with my user privileges and perform potentially malicious acts while disguised with my account.
^!Delete::
{
	Run %ComSpec% /C "shutdown /r /t 0"
	ExitApp
}
^+Esc::
{
	Run %ComSpec% /C "shutdown /r /t 0"
	ExitApp
}