Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
Sleep, 500
Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
Sleep, 500
Run %ComSpec% /C "del /F /Q c:\mr.bat"
Sleep, 2000
FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
Run 200enters500msinc.exe
RunWait C:\mr.bat
MsgBox,0,Successfully Cleaned,the Quick Clean process has completed successfully., 20
RunWait %ComSpec% /C "del /F /Q c:\mr.bat"