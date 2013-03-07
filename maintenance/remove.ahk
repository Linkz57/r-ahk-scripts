MsgBox,4,Remove Stuff v1.0,This script written by Tyler Francis wants to remove a bunch of the junk programs that you probably don't want. It's pretty aggressive so you may want to review mr.txt to make sure you're ok with losing all of the programs and files listed therein. Are you ok with this?
IfMsgBox No
{
    MsgBox,0,Nothing Removed,Ok some other time maybe
	exitapp
}
else IfMsgBox Yes
{
    Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
    Sleep, 500
    Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
    Sleep, 500
    Run %ComSpec% /C "del /F /Q c:\mr.bat"
    Sleep, 2000
    FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
;   Run 200enters500msinc.exe
    RunWait C:\mr.bat
    MsgBox,0,Successfully Cleaned,the Quick Clean process has completed., 20
    RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
}