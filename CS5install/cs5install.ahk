MsgBox,4,Install Adobe CS5,click YES to install Adobe CS5 using version 1.0.1 of this installer script written by Tyler Francis (Note: this takes like forever to even start the installation)
IfMsgBox No
{
	MsgBox,0,CS5 Not Installed,Ok some other time maybe, 20
	ExitApp
}
else IfMsgBox Yes
{
	RunWait %ComSpec% /C "ipconfig /all > ip\ipconfig.txt"
	Run %ComSpec% /C "ip\ipconfig.txt"
	sleep 2000
	send !{space}
	sleep 500
	send x
	sleep 500
	send ^{home}
	sleep 500
	loop, 3
	{
		send {down}
	}
	sleep 400
	if A_OSVersion in WIN_VISTA
	{
		loop, 39
		{
			send {right}
		}
	}
	sleep 200
	if A_OSVersion in WIN_XP
	{
		loop, 44
		{
			send {right}
		}
	}	
	sleep 400
	Send +{end}
	sleep 400
	Send ^c
	sleep 400	
	IfWinExist, ipconfig.txt - Notepad
	{
		WinClose
	}
	else
	{
		msgbox,0,Whelp,Something broke when closing notepad--I'm going to try to keep going anyways,5
		sleep 5500
		send !{F4}
	}
	sleep 500
	RunWait %ComSpec% /C "explorer ip"
	sleep 1000
	Send {i}{p}{c}
	sleep 400
	Send {F2}
	sleep 400
	Send +{home}
	sleep 200
	send ^v
	sleep 400
	send {Space}{_}{Space}
	send {Enter}
	sleep 2000
	IfWinExist, Rename File
		{
;		WinClose
		MsgBox, 260, Just so you know, If Windows just told you something like "Can't rename file because another already exists" or whatever it says then this installation has already been attempted on this computer and as such CS5 is likely already installed. If you want to quit this installation right here and now then click *YES*--this is the recommended option if the renaming failed. If you're sure that CS5 is not installed or you just want to do this anyways then just hold your horses because this message will self-distruct in 90 seconds and automatically proceed for you,90
		IfMsgBox Yes
			{
			MsgBox, 0,, Exiting now.,5
			sleep 4500
			ExitApp
			}
		}
	sleep 2000
	if A_OSVersion in WIN_VISTA
	{
		IfWinExist, ip
			WinClose
		sleep 500
		IfWinExist, CS5
			WinClose
		sleep 500
	}
	sleep 200
	if A_OSVersion in WIN_XP
	{
		SetTitleMatchMode,2
		IfWinExist, ip
			WinClose
		sleep 500
		IfWinExist, CS5
			WinClose
		sleep 500
	}
	sleep 500
	FileCreateDir, C:\Adobe CS5
	FileCopy, %A_WorkingDir%\infinitenyan.exe, C:\Adobe CS5\infinitenyan.exe, 1
	FileCopy, %A_WorkingDir%\unnyan.wav, C:\Adobe CS5\nyan.wav, 1
	sleep 2000
	RunWait %ComSpec% /C "taskkill /F /IM explorer.exe"
	sleep 500
	Run C:\Adobe CS5\infinitenyan.exe
	FileCopy, %A_WorkingDir%\deleteadobecs5.exe, C:\deleteadobecs5.exe, 1
	FileCopyDir, %A_WorkingDir%\Adobe CS5 - Windows, C:\Adobe CS5, 1
	FileCopy, %A_WorkingDir%\embeddedcs5install.exe, C:\Adobe CS5\embeddedcs5install.exe, 1
	process,close,infinitenyan.exe
	Run C:\Adobe CS5\embeddedcs5install.exe
	if ErrorLevel
		MsgBox, 0, so funny story..., The folder might not have copied. perhaps because a folder of that name already exists in C:\Adobe CS5 or maybe nothing happened and everything is fine. Either way the error level is "%ErrorLevel%". You should eject this external drive and cross your fingers as we move to the next step... [this message will self-distruct in 90 seconds],90
	else
		MsgBox,0,Congratulations,The first half of the install has completed sucessfully. You may now eject this external drive. [this message will self-distruct in 90 seconds],90
	sleep 500
	ExitApp
}

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
