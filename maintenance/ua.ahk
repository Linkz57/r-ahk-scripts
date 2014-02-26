MsgBox,4,Update Automatically v2.2.1,This script written by Tyler Francis wants to install the latest version of "Firefox" "Flash" "Java" "Adobe Reader" and "Internet Explorer" as well as remove a few of the junk programs that you probably don't want. Are you ok with this? Please close all open programs before answering.,120
IfMsgBox No
{
	MsgBox,0,Nothing Installed,Ok some other time maybe,10
	exitapp
}
else
{
	;; Variables, flags and other pre-run setup
	rej = unset
	kronus = unset
	areedr = unset
	aflsh = unset
	ojavr = unset
	ieversion = unset
	restaart = true
	remuve = true
	currentCompatibilityKey = 461
	;; check for restart flag
	if A_OSVersion in WIN_7,WIN_VISTA
	{
		ifexist, %HOMEDRIVE%%HOMEPATH%\Desktop\ahknorestart.txt
		{
			restaart = false
			RunWait %ComSpec% /C "del /F /Q %HOMEDRIVE%%HOMEPATH%\Desktop\ahknorestart.txt"
		}
	}
	if A_OSVersion in WIN_XP
	{
		ifexist, "C:\Documents and Settings\student\Desktop\ahknorestart.txt"
		{
			restaart = false
			RunWait %ComSpec% /C "del /F /Q "C:\Documents and Settings\student\Desktop\ahknorestart.txt""
		}
	}
	;; check for remove flag
	if A_OSVersion in WIN_7,WIN_VISTA
	{
		ifexist, %HOMEDRIVE%%HOMEPATH%\Desktop\ahknoremove.txt
		{
			remuve = false
			RunWait %ComSpec% /C "del /F /Q %HOMEDRIVE%%HOMEPATH%\Desktop\ahknoremove.txt"
		}
	}
	if A_OSVersion in WIN_XP
	{
		ifexist, "C:\Documents and Settings\student\Desktop\ahknoremove.txt"
		{
			remuve = false
			RunWait %ComSpec% /C "del /F /Q "C:\Documents and Settings\student\Desktop\ahknoremove.txt""
		}
	}

	; Regestry and IE success test
	msgbox,0,Alright let's do this,Sounds like a plan.`nBefore we start I'm going to test your chances of success and make some recommendations from there.,10
	RunWait %ComSpec% /C "del /F /Q c:\t.txt"

	RunWait %ComSpec% /C "REG QUERY "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" > C:\t.txt"
	sleep 1000
	
	; SizeCheck
	FileGetSize, Size, C:\t.txt
	;msgbox,0,0,size is %Size%
	if (Size == currentCompatibilityKey) ;equal to 461B
	{
		msgbox,0,This computer looks familiar,I think this script has ran on this machine before. No worries`, I'll just skip some of the one-time tasks. `nAll is well so far as I can tell,10
		rej = open
		kronus = good
		goto,scriptstart
	}
	else
	{
	
		RunWait %ComSpec% /C "del /F /Q c:\t.txt"
;		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411f00005308adba010000003000000001000000010000000c000000980f7f42a0e0ce010100000009006b0072006f006e006f0073002d0061007300" /F" ; kronos-as
;		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411f00005308adba020000005800000001000000020000000c000000980f7f42a0e0ce010100000009006b0072006f006e006f0073002d00610073000c0000009de374514d23cf01010000000b00730074006100740065002e00740078002e0075007300" /F" ; kronos-as && state.tx.us
		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411F00005308ADBA030000009A00000001000000030000000C000000980F7F42A0E0CE010100000009006B0072006F006E006F0073002D00610073000C0000009DE374514D23CF01010000000B00730074006100740065002E00740078002E00750073000C000000FF2D9D320D2CCF0101000000180074006500730074007300650063007500720069007400790074007200610069006E0069006E0067002E0063006F006D00" /F" ; kronos-as && state.tx.us && testsecuritytraining.com
		sleep 500
		RunWait %ComSpec% /C "REG QUERY "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" > C:\t.txt"
		sleep 1000
		FileGetSize, newSize, C:\t.txt
		if (newSize == currentCompatibilityKey)
		{
			msgbox,0,All shiny here`, captain,Everything seems to check out. Continuing as planned.,5
			rej = open
			kronus = good
			goto,scriptstart
		}
		if (newSize < currentCompatibilityKey)
		{
			msgbox,0,Bad news`, bro,Bad news`, it seems that I'm unable to automatically add Kronos to the Internet Explorer compatibility list. This is a problem`, because Internet Explorer 11 (the version I want to install) doesn't work with Kronos except in compatibility mode. `nThis is really only a problem for non-teacher staff members who clock in and out with Kronos. Because I can't automatically add Kronos to the list`, I'm going to install an older version of Internet Explorer.,30
			kronus = bad
			rej = locked
			goto,scriptstart
		}
		else
		{
			msgbox,0,Well this is odd,The internet explorer compatibility list might be bigger than %currentCompatibilityKey% bytes. I don't really know how to handle this situation`, so I'll just ignore it and keep going.,10
			rej = toobig
			kronos = bad
			goto,scriptstart
		}
	}
	RunWait %ComSpec% /C "del /F /Q c:\t.txt"
	
	; Adobe Reader version check
	if rej in open
	{
		RunWait %ComSpec% /C "REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\Acrobat Reader" > c:\t.txt"
		sleep 1000
		run %ComSpec% /C "notepad c:\t.txt"
		sleep 3000
		send ^{home}
		sleep 500
		send ^f
		sleep 500
		send Reader\
		sleep 500
		send {enter}
		sleep 500
		send !{F4}
		sleep 500
		send +{home}
		sleep 500
		send {backspace 2}
		sleep 500
		send {del 6}
		sleep 500
		send +{end}
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 1000
		send !n
		sleep 2000
		areedr = %clipboard%
		RunWait %ComSpec% /C "del /F /Q c:\t.txt"
		msgbox,0,Adobe Reader found,You already have Adobe Reader installed (major version %areedr%),5
	}
	else
	{
		msgbox,0,Sorry,I can't figure out what version of Adobe Reader you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
		areedr = unknown
	}
	if rej in open
	{
		if (areedr == "unset")
		{
			msgbox,0,Sorry,I can't figure out what version of Adobe Reader you're using which probably means you don't have it installed. I'm going to install the latest one I have`, even `if you don't need it.,5
		}
	}
	
	; Adobe Flash version check
	if rej in open
	{
		RunWait %ComSpec% /C "del /F /Q c:\t.txt"
		sleep 1000
		RunWait %ComSpec% /C "REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Macromedia\FlashPlayer /V "CurrentVersion" > c:\t.txt"
		sleep 1000
		run %ComSpec% /C "notepad c:\t.txt"
		sleep 3000
		send ^{home}
		sleep 500
		send ^f
		sleep 500
		send REG_SZ
		sleep 500
		send {enter}
		sleep 500
		send !{F4}
		sleep 500
		send +^{home}
		sleep 500
		send {backspace}
		sleep 500
		send {del 10}
		sleep 500
		send ^h
		sleep 500
		send `,
		sleep 500
		send {tab}
		sleep 500
		send `.
		sleep 500
		send !a
		sleep 1000
		send !{F4}
		sleep 500
		send +{end}
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 1000
		send !n
		sleep 2000
		aflsh = %clipboard%
		RunWait %ComSpec% /C "del /F /Q c:\t.txt"
		msgbox,0,Adobe Flash found,You already have Adobe Flash installed (version %aflsh%),5
	}
	else
	{
		msgbox,0,Sorry,I can't figure out what version of Adobe Flash you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
		aflsh = unknown
	}
	if rej in open
	{
		if (aflsh == "unset")
		{
			msgbox,0,Sorry,I can't figure out what version of Adobe Flash you're using which probably means you don't have it installed. I'm going to install the latest one I have`, even `if you don't need it.,5
		}
	}
	
	; Java version check
	if rej in open
	{
		RunWait %ComSpec% /C "del /F /Q c:\t.txt"
		sleep 1000
		RunWait %ComSpec% /C "REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in" > c:\t.txt"
		sleep 1000
		run %ComSpec% /C "notepad c:\t.txt"
		sleep 3000
		send ^{home}
		sleep 500
		send ^f
		sleep 500
		send Plug-in\
		sleep 500
		send {enter}
		sleep 500
		send !{F4}
		sleep 500
		send +^{home}
		sleep 500
		send {backspace}
		sleep 500
		send {del 8}
		sleep 500
		send +{end}
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 1000
		send !n
		sleep 2000
		ojavr = %clipboard%
		RunWait %ComSpec% /C "del /F /Q c:\t.txt"
		msgbox,0,Oracle Java found,You already have Oracle Java installed (version %ojavr%),5
	}
	else
	{
		msgbox,0,Sorry,I can't figure out what version of Oracle Java you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
		ojavr = unknown
	}
	if rej in open
	{
		if (ojavr == "unset")
		{
			msgbox,0,Sorry,I can't figure out what version of Oracle Java you're using which probably means you don't have it installed. I'm going to install the latest one I have`, even `if you don't need it.,5
		}
	}
	
	; IE version check
	if rej in open
	{
		RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
		sleep 1000
		RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Internet Explorer" /V "svcVersion" > C:\ci.txt"
		sleep 1000
		; SizeCheck
		FileGetSize, ciSize, C:\ci.txt
		;msgbox,0,0,size is %Size%
		if (ciSize < 5) ; less than 5B
		{
			RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
			sleep 1000
			RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Internet Explorer" /V "Version" > C:\ci.txt"
			sleep 1000
			FileGetSize, ci2Size, C:\ci.txt
			if (ci2Size < 5) ; less than 5B
			{
				RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
				msgbox,0,Sorry about this,Sorry but I'm unable to get access to the specific information your want.
			}
		}
		Run %ComSpec% /C "notepad c:\ci.txt"
		sleep 3000
		send ^{home}
		sleep 500
		send ^f
		sleep 500
		send REG_SZ
		sleep 500
		send {enter}
		sleep 500
		send !{F4}
		sleep 500
		send +^{home}
		sleep 500
		send {backspace}
		sleep 500
		send {del 10}
		sleep 500
		send +{end}
		sleep 500
		send ^c
		sleep 500
		send !{F4}
		sleep 1000
		send !n
		sleep 2000
		ieversion = %clipboard%
		RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
		msgbox,0,Microsoft Internet Explorer found,You already have Microsoft Internet Explorer installed (version %ieversion%),7
	}
	else
	{
		msgbox,0,Sorry,I can't figure out what version of Microsoft Internet Explorer you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
		ojavr = unknown
	}
	if rej in open
	{
		if (ieversion == "unset")
		{
			msgbox,0,Sorry,I can't figure out what version of Microsoft Internet Explorer you're using which probably means you don't have it installed. I'm going to install the latest one I have`, even `if you don't need it.,5
		}
	}
	
	
	
	scriptstart:
	RunWait %ComSpec% /C "del /F /Q c:\t.txt"

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
	Runwait %ComSpec% /C "taskkill /F /IM notepad.exe"
	progress,8,here goes GroupWise,Closing some remaining programs,The Unfaltering March Of `Progress
	sleep 1000
	Runwait %ComSpec% /C "taskkill /F /IM grpwise.exe"
	progress,10,if there any programs left open`, please `send an email to Mr. Francis--obviously not now`, wait until I'm done here.,Finished closing programs,The Unfaltering March Of `Progress
	sleep 2000

	;; The time assumption on the next line is out of date; one of these days I'll re-calculate and version-stamp it.
	;; All of the sleep timers and message box timeouts add up to about 16 minutes. This time doesn't take into account the runwait time on mr.bat, adobereader.msi or either IE*.exe executions, but I'll assume they aren't in excess of 45 minutes. Therefore, if this script takes longer than an hour to run, I'll assume it's broken. As a "fix", here is a timed shutdown at the beginning of this script.

	if A_OSVersion in WIN_VISTA,WIN_7 ; Vista and 7 only. I think XP's shutdown program can't take a delay longer than 99 seconds.
	{
		progress,15,%A_Space%,Preparing provisions for potential problems,The Unfaltering March Of `Progress
		sleep 500
		Run %ComSpec% /C "shutdown -s -t 3600"
	}
	
	;; remove old debugging information
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Desktop\remove_message.bat""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Desktop\remove_message.bat""

	;; Install Firefox silently
	progress,17,%A_Space%,Updating Firefox,The Unfaltering March Of `Progress
	Runwait FirefoxSetup.exe -ms
	sleep 2000

	;; Remove Internet Explorer proxy settings
	progress,22,disabling system proxies,Adjusting Internet Options,The Unfaltering March Of `Progress
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
	Sleep 4000

	;; Change Internet Explorer homepage back to default
	progress,24,resetting Internet Explorer homepage,Adjusting Internet Options,The Unfaltering March Of `Progress
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
	Sleep 2000

;	; Flash Player Internet Explorer installation
	progress,26,for Internet Explorer,Updating Adobe Flash,The Unfaltering March Of `Progress
	SetTimer,altr,-15000
	Runwait %ComSpec% /C "flashplayerIE.msi /qb /norestart"
	sleep 2000

;	; Flash Player Firefox plugin installation
	sleep 2000
	progress,35,for Firefox,Updating Adobe Flash,The Unfaltering March Of `Progress
	SetTimer,altr,-13000
	Runwait %ComSpec% /C "flashplayerFF.msi /qb /norestart"
	sleep 2000
	
	;; Misc Removal Script setup
	if remuve in true
	{
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
			send \Documents and Settings\student
			sleep 500
			send !a
			sleep 4500
			
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
		sleep 1000
		
		;; setup error catching
		IfWinExist, mr.bat - Notepad
		{
			WinActivate
			send ^s
			sleep 1000
			send !{F4}
			sleep 500
		
			IfWinExist, mr.bat - Notepad
			{
				Run %ComSpec% /C "taskkill /F /IM notepad.exe"
				sleep 1000
				IfWinExist, mr.bat - Notepad
				{
					msgbox,0,Whelp there's a snag,It seems I can't get Notepad to close. I've tried three times and am still stuck. `nMind giving me a hand with this? `nDon't `click OK until Notepad is SAVED and CLOSED. `If you're not sure what you should do then just don't `click anything and I'll skip this bit in a minute.,120
					IfMsgBox Timeout
					{
						goto,javainstall
					}
				}
			}
		}

		;; Misc Removal Script execution
		progress,50,%A_Space%,Removing a bunch of junk,The Unfaltering March Of `Progress
		sleep 2000
	;	RunWait %ComSpec% /C "%Clipboard%"
		RunWait %ComSpec% /C "C:\mr.bat"
		sleep 1000
		RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
	}

	;; Java Installation
	javainstall:
	progress,60,%A_Space%,Updating Java,The Unfaltering March Of `Progress
	SetTimer,altr,-10000
	SetTimer,javadllerror,-30000
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
	
	if A_OSVersion in WIN_7
	{
		if kronus in good
		{
			progress,90,%A_Space%,Installing Internet Explorer 11,The Unfaltering March Of `Progress
			SetTimer,altr,-15000
			RunWait %ComSpec% /C "IE11-W7.exe /passive /norestart"
		}
		else
		{
			progress,90,%A_Space%,Installing Internet Explorer 9,The Unfaltering March Of `Progress
			SetTimer,altr,-15000
			RunWait %ComSpec% /C "IE9-W7.exe /passive /norestart"
		}
	}
	if A_OSVersion in WIN_VISTA
	{
		progress,90,%A_Space%,Installing Internet Explorer 9,The Unfaltering March Of `Progress
		SetTimer,altr,-15000
		RunWait %ComSpec% /C "IE9-vista.exe /passive /norestart" ; IE 9 is the last version that runs on Vista
	}
	sleep 200
	if A_OSVersion in WIN_XP
	{
		progress,90,%A_Space%,Installing Internet Explorer 8,The Unfaltering March Of `Progress
		SetTimer,altr,-15000
		RunWait %ComSpec% /C "IE8-XP.exe /passive /norestart /sqm" ; IE 8 is the last version that runs on XP
	}
	sleep 1000

	;; One Final cleanup
	sleep 2000
	Run %ComSpec% /C "del /F /Q c:\mr.bat"
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Desktop\remove_message.bat""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Desktop\remove_message.bat""
	sleep 500

	;; Automatic Shutdown
	progress,100,feel free to grab the mouse and keyboard again. `If anything went wrong`, please `send an email,And we're done,The Unfaltering March Of `Progress
	sleep 2000
	Run %ComSpec% /C "shutdown -a"
	sleep 1000
	if restaart in true
	{
		Run %ComSpec% /C "shutdown -s -t 180"
		sleep 1000
		SetTimer,movewin,-100
		MsgBox, 4, Alright you're done, Do you wanna restart or something? *YES* to restart now or *NO* to abort the automatic Shutdown of 3 minutes already in progress. BTdubs the error level is "%ErrorLevel%" on the off chance that you're interested. [this message will self-distruct in two minutes],120
		IfMsgBox Yes
		{
			Run %ComSpec% /C "shutdown -a"
			sleep 500
			Run %ComSpec% /C "shutdown -s -t 5"
			MsgBox, 4096, Shutdown, Alright--shutting down...,5
			ExitApp
		}
		else IfMsgBox No
		{
			Run %ComSpec% /C "shutdown -a"
			Run %ComSpec% /C "explorer"
			MsgBox, 4096, Abort Shutdown, Alright--aborting shutdown.,10
			ExitApp
		}
		IfMsgBox Timeout
		{
			Run %ComSpec% /C "shutdown -r -t 10"
			sleep 1000
			MsgBox, 4096, Restart, Alright--restarting...,5
			ExitApp
		}
	}
	if restaart in false
	{
		msgbox,0,Stick THIS on a fortune cookie and eat it,Well that's all finished. I'd recommend you restart this computer soon`, but then again I'd also recommend you not let a program tell you how to live your life.,10
		Run %ComSpec% /C "explorer"
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
	{
		send !r
		goto,msiissues
		return
	}
	
	javadllerror:
	{
		IfWinExist,RunDLL,There was a problem starting C:\Program Files\Java\jre7\bin\\installer.dll
		WinActivate
		send {space}
	}
	
	msiissues:
	{
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
	}
	
	movewin:
	{
		WinWait, Alright you're done
		WinMove, 375, 45
;		WinMove, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown now or *NO* to abort the automatic Shutdown of,375, 75
		sleep 500
		winactivate, Alright you're done
		return
	}
	
	computerover:
	{
;;		virus=veryYes
		exitapp
	}
}
