FileCopyDir, %A_WorkingDir%, C:\Users\student\Desktop\moss, 1
runwait C:\Users\student\Desktop\moss\setup.exe
msgbox,0,done,done,10
RunWait %ComSpec% /C "del /F /Q /S C:\Users\student\Desktop\moss"
exitapp
