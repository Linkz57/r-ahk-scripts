RunWait %ComSpec% /C "del /F /Q /S C:\Users\student\Desktop\LiterActive"
sleep 500
progress,FS10 W600 Y650,%A_Space%,Opening LiterActive...,Please Wait,Segoe UI
sleep 500
progress,50,This can take a bit`, so just chill out,Opening LiterActive...,Please Wait
sleep 500
FileCopyDir, %A_WorkingDir%, C:\Users\student\Desktop\LiterActive, 1
progress,100,Done,Opening LiterActive...,Please Wait
sleep 1000
run C:\Users\student\Desktop\LiterActive\LiterActive.exe
exitapp
