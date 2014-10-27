RunWait %ComSpec% /C "del /F /Q /S C:\Users\student\Desktop\WriteSmart"
sleep 500
progress,FS10 W600 Y650,%A_Space%,Opening WriteSmart...,Please Wait,Segoe UI
sleep 500
progress,50,,Opening WriteSmart...,Please Wait
sleep 500
FileCopyDir, %A_WorkingDir%, C:\Users\student\Desktop\WriteSmart, 1
progress,100,Done,Opening WriteSmart...,Please Wait
sleep 1000
run C:\Users\student\Desktop\WriteSmart\WriteSmart.exe
exitapp
