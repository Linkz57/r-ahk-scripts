sleep 5000
RunWait c:\Adobe CS5\CS5\disk 1\Adobe CS5_5\Set-up.exe
sleep 60000
send {tab}
sleep 1000
send {enter}
sleep 3000
send xxxx ; replace "xxxx" with actual serial number
sleep 200
send xxxx ; replace "xxxx" with actual serial number
sleep 200
send xxxx ; replace "xxxx" with actual serial number
sleep 200
send xxxx ; replace "xxxx" with actual serial number
sleep 200
send xxxx ; replace "xxxx" with actual serial number
sleep 200
send xxxx ; replace "xxxx" with actual serial number
sleep 2000
send {enter}
sleep 2000
send {tab}{tab}{tab}{tab}{tab}
sleep 3000
send {enter}
sleep 2000
send {enter} ; an extra one, just to make sure
sleep 2100000
send {enter}
sleep 2000
send {enter}
sleep 2000
/*
RunWait c:\Adobe CS5\CS5\disk extra\Adobe After Effects and Premiere Pro CS4 for win 32 bit\Adobe CS4\Setup.exe
*/
if ErrorLevel
    MsgBox,0,Something went horribly wrong,My guess is that the "Adobe After Effects and Premiere Pro CS4" package refused to install--it does that sometimes. [this message will self-distruct in 90 seconds],90
MsgBox,0,Congratulations,The second and final half of the install has probably completed sucessfully.[this message will self-distruct in 5 seconds],5
Run c:\deleteadobecs5.exe
Run %ComSpec% /C "shutdown -s -t 600"
MsgBox, 3, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown now or *No* to abort the automatic Shutdown of 10 minutes. BTdubs the error level is "%ErrorLevel%" [this message will self-distruct in 7 minutes],420
IfMsgBox Yes
    {
    Run %ComSpec% /C "shutdown -a"
	sleep 500
	Run %ComSpec% /C "shutdown -s"
	MsgBox, 4096, Shutdown, Alright--shutting down in 10..., 5
	}
else IfMsgBox No
	{
	Run %ComSpec% /C "shutdown -a"
	MsgBox, 4096, Abort Shutdown, Alright--aborting shutdown.,10
	}