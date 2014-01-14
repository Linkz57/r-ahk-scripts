MsgBox,4,Update Automatically v1.4.5,This script written by Tyler Francis wants to install the latest version of "Firefox" "Flash" "Java" "Adobe Reader" and "Internet Explorer" as well as remove a few of the junk programs that you probably don't want. Are you ok with this? Please close all open programs before answering.,120
IfMsgBox No
{
	MsgBox,0,Nothing Installed,Ok some other time maybe
	exitapp
}
else
{
	MsgBox,0,Ok here we go,Remove your hands from the mouse and keyboard! At the very end you'll be asked `if you want to shut down your computer and that is the ONLY time you can `click anything. At times it will look like your computer is just sitting here doing nothing. Please resist the urge to "help it along". DO NOT `click anything. DO NOT type anything. This entire `process is automated. Any interaction on your part will cause this update to go all haywire and you'll have to start it all over again. Don't even `click "ok" on this box. In fact get up and walk away. Make yourself some tea and come back in about 10 minutes and this will be done. Don't keep reading this to see what will happen--leave. Go. Now. Make like a tree and turn off your monitor.,30
	;; Kill Windows Explorer to discourage the user from interacting with the computer, and also to reduce the chance of problems that are inherent with macros.
	progress,FS10 W600 Y650,%A_Space% `n %A_Space%,Closing some remaining programs,The Unfaltering March Of `Progress,Segoe UI
	RunWait %ComSpec% /C "taskkill /F /IM explorer.exe"
	progress,2,there goes Windows Explorer,Closing some remaining programs,The Unfaltering March Of `Progress
	
	;; close some other things
	Runwait %ComSpec% /C "taskkill /F /IM iexplore.exe"
	progress,3,there goes Internet Explorer,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM firefox.exe"
	progress,4,there goes Firefox,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM chrome.exe"
	progress,5,there goes Chrome,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM AcroRd32.exe"
	progress,6,there goes Adoobe Reader,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM AcroRd64.exe"
	progress,7,there goes Notepad,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM notepad.exe
	progress,8,here goes GroupWise,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM grpwise.exe"
	progress,10,if there any programs left open`, please `send an email to Mr. Francis--obviously not now`, wait until I'm done here.,Finished closing programs,The Unfaltering March Of `Progress
	sleep 2000

	;; The time assumption on the next line is out of date; one of these days I'll re-calculate and version-stamp it.
	;; All of the sleep timers and message box timeouts add up to about 16 minutes. This time doesn't take into account the runwait time on mr.bat, adobereader.msi or either IE*.exe executions, but I'll assume they aren't in excess of 45 minutes. Therefore, if this script takes longer than an hour to run, I'll assume it's broken. As a "fix" here is a timed shutdown at the beginning of this script.

	if A_OSVersion in WIN_VISTA ; Vista and 7 only. I think XP's shutdown program can't take a delay longer than 99 seconds.
	{
		progress,15,%A_Space%,Preparing provisions for potential problems,The Unfaltering March Of `Progress
;		RunWait %ComSpec% /C "copy notes\A_Message_from_Tyler_Francis.txt "%USERPROFILE%\Start Menu\Programs\Startup"" ; This is a small message telling the user that the update process failed and that they should send me an email saying as much. Were this a *Nix machine I'd CAT in some info like where it failed. I'll have to find out how to do that in Windows without opening Notepad at every action.
;		sleep 500
;		RunWait %ComSpec% /C "copy notes\remove_message.bat "%USERPROFILE%\Desktop""
		sleep 500
		Run %ComSpec% /C "shutdown -s -t 3600"
	}
	
	;; remove old debugging information
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Desktop\remove_message.bat""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Desktop\remove_message.bat""

	;; Install Firefox silently
	progress,17,%A_Space%,Starting the Firefox updater,The Unfaltering March Of `Progress
	Run FirefoxSetup.exe -ms
	sleep 2000

	;; Remove Internet Explorer proxy settings
	progress,22,disabling system proxies,Adjusting Internet Options,The Unfaltering March Of `Progress
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
	Sleep 4000

	;; Change Internet Explorer homepage back to default
	progress,24,resetting Internet Explorer homepage,Adjusting Internet Options,The Unfaltering March Of `Progress
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
	Sleep 2000

	;; Shockwave - Automatic installation of Shockwave is not reliable because the "Don't install the advertisement" button is in one of two places inconsistently. I probably don't need shockwave, and if I find I do then I'll look for an MSI or something more reliable than Adobe's default offering. Come to think of it, I might be able to do a "if WinEquals" check to target specific ads.
	; Run shockwave.exe
	; sleep 210000
	; send +{tab}
	; send +{tab} ;; two shift+tabs for the "don't install Google Chrome" option which I find is the most common advertisement.
	; send {space}
	; send {enter}
	; sleep 3000
	; send {enter}

;	; Flash Player Internet Explorer installation
	progress,26,for Internet Explorer,Updating Adobe Flash,The Unfaltering March Of `Progress
	SetTimer,altr,-15000
	Runwait %ComSpec% /C "flashplayerIE.msi /qb /norestart"
	sleep 2000

;	; Flash Player Firefox plugin installation
	sleep 2000
;	if A_OSVersion in WIN_XP
;	{
		progress,35,for Firefox,Updating Adobe Flash,The Unfaltering March Of `Progress
		SetTimer,altr,-13000
		Runwait %ComSpec% /C "flashplayerFF.msi /qb /norestart"
	; }
	; if A_OSVersion in WIN_VISTA
	; {
		; progress,35,for Firefox--bad news`,bro`,you have to use an older version,Updating Adobe Flash,The Unfaltering March Of `Progress
		; Run flashplayerFF-old_win7.exe
		; sleep 12000
		; send +{tab}
		; sleep 200
		; send {space}
		; sleep 200
		; send {tab}
		; sleep 200
		; send {tab}
		; sleep 200
		; send {enter}
		; sleep 2000
		; send {tab}
		; sleep 200
		; send {enter}
	; }
	sleep 2000
	
	; if A_OSVersion in WIN_XP
	; {
		; send {down}
		; sleep 200
		; send {down}
	; }
	; if A_OSVersion in WIN_VISTA
	; {
		
	; }
	

	;; Misc Removal Script setup
	progress,39,%A_Space%,Getting ready to remove a bunch of junk,The Unfaltering March Of `Progress
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
	RunWait %ComSpec% /C "del /F /Q c:\mr.txt"
	Sleep 2000
	FileCopy, %A_WorkingDir%\mr.txt, C:\mr.bat
	sleep 2000
	Run %ComSpec% /C "notepad c:\mr.bat"
	sleep 3000
	send ^{home}
	sleep 500
	send ^f
	sleep 1000
	send REM ~ begin manual removal ~
	sleep 500
	send {enter}
	sleep 1000
	send !{F4}
	sleep 1000
	send ^+{end}
	sleep 1000
	send {backspace}
	sleep 1000
	
	; Work around for not being allowed to run batch files
	; send ^a
	; sleep 500
	; send ^c
	; sleep 1000
	
	
	if A_OSVersion in WIN_XP
	{
		progress,40,ooh this part is my favorite,Getting ready to remove a bunch of junk,The Unfaltering March Of `Progress
		;; replace homepath
		send ^h
		sleep 500
		send `%Homepath`%
		sleep 500
		send {tab}
		sleep 500
		send C:\Documents and Settings\student
		sleep 500
		send !a
		sleep 2500
		
		;; replace programdata
		send +{tab}
		sleep 500
		send `%ProgramData`%\Microsoft\Windows
		sleep 500
		send {tab}
		sleep 500
		send C:\Documents and Settings\All Users
		sleep 500
		send !a
		sleep 2000
		
		;; replace public
		send +{tab}
		sleep 500
		send `%PUBLIC`%
		sleep 500
		send {tab}
		sleep 500
		send C:\Documents and Settings\All Users
		sleep 500
		send !a
		sleep 2000
		
		;; finish replacement
		send !{F4}
		sleep 500
	}
	send ^s
	sleep 500
	send !{F4}

	;; Misc Removal Script execution
	progress,50,%A_Space%,Removing a bunch of junk,The Unfaltering March Of `Progress
	sleep 2000
;	RunWait %ComSpec% /C "%Clipboard%"
	RunWait %ComSpec% /C "C:\mr.bat"
	sleep 1000
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"

	;; Java Installation
	progress,60,%A_Space%,Updating Java,The Unfaltering March Of `Progress
	SetTimer,altr,-10000
	RunWait %ComSpec% /C "java.msi /passive /norestart"

	;; Adobe Reader installation
	progress,70,%A_Space%,Updating Adobe Reader,The Unfaltering March Of `Progress
	sleep 2000
	SetTimer,altr,-15000
	RunWait %ComSpec% /C "msiexec /package adobereader.msi /qb /norestart" ; /update adobereaderpatch.msp"
	progress,80,and probably failing--this part needs some work,Patching Adobe Reader,The Unfaltering March Of `Progress
	SetTimer,altr,-10000
	RunWait %ComSpec% /C "msiexec.exe /update adobereaderpatch.msp /qb /norestart"

	;; Internet Explorer installation
	sleep 2000

	if A_OSVersion in WIN_VISTA
	{
		progress,90,%A_Space%,Installing Internet Explorer 9,The Unfaltering March Of `Progress
		SetTimer,altr,-15000
		RunWait %ComSpec% /C "IE9-Windows7-x86-enu.exe /passive /norestart"
	}
	sleep 200
	if A_OSVersion in WIN_XP
	{
		progress,90,%A_Space%,Installing Internet Explorer 8,The Unfaltering March Of `Progress
		SetTimer,altr,-15000
		RunWait %ComSpec% /C "IE8-WindowsXP-x86-ENU.exe /passive /norestart /sqm"
	}
	sleep 1000

	;; One Final cleanup
	sleep 2000
	Run %ComSpec% /C "del /F /Q c:\mr.bat"

	;; Automatic Shutdown
	progress,100,feel free to grab the mouse and keyboard again. `If anything went wrong`, please `send an email,And we're done,The Unfaltering March Of `Progress
	sleep 2000
	Run %ComSpec% /C "shutdown -a"
	sleep 500
	if A_OSVersion in WIN_VISTA
	{
;		RunWait %USERPROFILE%\Desktop\remove_message.bat ; If the script got this far in execution, I'll assume everything went smoothly and remove the error message from the startup folder.
		Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
		Run %ComSpec% /C "del /F /Q "C:\Users\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
		Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Desktop\remove_message.bat""
		Run %ComSpec% /C "del /F /Q "C:\Users\Student\Desktop\remove_message.bat""
		sleep 500
	}
	sleep 1000
	Run %ComSpec% /C "shutdown -s -t 180"
	MsgBox, 4, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown now or *NO* to abort the automatic Shutdown of 10 minutes already in progress. BTdubs the error level is "%ErrorLevel%" on the off chance that you're interested. [this message will self-distruct in two minutes],120
	IfMsgBox Yes
	{
		Run %ComSpec% /C "shutdown -a"
		sleep 500
		Run %ComSpec% /C "shutdown -s -t 5"
		MsgBox, 4096, Shutdown, Alright--shutting down..., 5
		ExitApp
	}
	else IfMsgBox No
	{
		Run %ComSpec% /C "shutdown -a"
		Run %ComSpec% /C "explorer"
		MsgBox, 4096, Abort Shutdown, Alright--aborting shutdown.,10
		ExitApp
	}
	ExitApp
	
	
	;;  Hotkeys
	;;  And
	;;  Gotos
	
	esc::
	{
		Run %ComSpec% /C "shutdown -a"
		Run %ComSpec% /C "explorer"
		ExitApp
	}
	goto,computerover
	
	
	;; gotostuff
	
	altr:
	send !r
	goto,msiissues
	return
	
	msiissues:
	sleep 10000
	IfWinExist,Windows Installer,OK  ; Should automatically dismiss Adobe Reader installation errors.
	{
		WinActivate
		send {space}
		goto,msiissues
	}
	IfWinExist,,Error 1722  ; Should automatically dismiss Adobe Flash Player installation errors.
	{
		WinActivate
		send {space}
		goto,msiissues
	}
	sleep 15000
	IfWinExist,Open File - Security Warning,Run
	{
		goto,altr
	}
	IfWinExist,Windows Installer,OK  ; Should automatically dismiss Adobe Reader installation errors.
	{
		WinActivate
		send {space}
		goto,msiissues
	}
	IfWinExist,,Error 1722  ; Should automatically dismiss Adobe Flash Player installation errors.
	{
		WinActivate
		send {space}
		goto,msiissues
	}
	sleep 15000
	IfWinExist,Open File - Security Warning,Run
	{
		goto,altr
	}
	return
	
	computerover:
	;; virus=veryYes
	exitapp
}
