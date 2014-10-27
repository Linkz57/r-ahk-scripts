MsgBox,4,Update Automatically v2.6.1,This script written by Tyler Francis wants to install the latest version of "Firefox" "Flash" "Java" "Adobe Reader" and "Internet Explorer" as well as remove a few of the junk programs that you probably don't want. Are you ok with this? Please close all open programs before answering.,120
IfMsgBox No
{
	MsgBox,0,Nothing Installed,Ok some other time maybe,10
	exitapp
}
else
{
	;; Variables, flags, and other pre-run setup
	rej = unset
	kronus = unset
	areedr = unset
	aflsh = unset
	ojavr = unset
	ieversion = unset
	restaart = true
	remuve = true
	udua = false
	currentCompatibilityKey = 665
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
	
	;; Ask for update permission
	msgbox,4,Would you like me to check for updates first?,The software I plan to install may be out of date. I don't know that it is`, I'm just guessing that it might be. `nWould you like me to check for updates and then download the newest version of Firefox`, Flash`, and Java before installing them?,60
	IfMsgBox No
	{
		MsgBox,0,No problem,Yeah`,that's probably just as well. I doubt much has changed in the world since the last time I've checked.,10
		udua = false
	}
	IfMsgBox Yes
	{
		msgbox,0,Alright I'll check soon,Ok you've convinced me. I'll check for updates in a few minutes before I install anything.,10
		udua = true
	}
	IfMsgBox Timeout
	{
		msgbox,0,Hello? Is anyone in there? Just nod `if you can hear me.,Maybe you've nodded off or something. No matter`, I won't check for updates before I install Firefox`, Flash`, Java`, Internet Explorer`, and Adobe Reader.,5
		udua = false
	}

	; Regestry and IE success test
	msgbox,0,Alright let's do this,Thanks`, that's all of my questions for now.,10
	
	MsgBox,0,Ok here we go,Remove your hands from the mouse and keyboard!`n`nAt the very end you'll be asked `if you want to shut down your computer and that is the ONLY time you can `click anything. At times it will look like your computer is just sitting here doing nothing. Please resist the urge to "help it along". DO NOT `click anything. DO NOT type anything. This entire `process is automated. Any interaction on your part will cause this update to go all haywire and you'll have to start it all over again. Don't even `click "ok" on this box. In fact get up and walk away. Make yourself some tea and come back in about 10 minutes and this will be done. Don't keep reading this to see what will happen--leave. Go. Now. Make like a tree and turn off your monitor.,30
	
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
	progress,9,if there any programs left open`, please `send an email to Mr. Francis--obviously not now`, wait until I'm done here.,Finished closing programs,The Unfaltering March Of `Progress
	sleep 2000
	
	progress,10,,Checking probability of success,The Unfaltering March Of `Progress
	sleep 1000
	
	; prepare SizeCheck
	RunWait %ComSpec% /C "del /F /Q c:\t.txt"

	RunWait %ComSpec% /C "REG QUERY "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" > C:\t.txt"
	sleep 1000
	
	; SizeCheck
	FileGetSize, Size, C:\t.txt
	;msgbox,0,0,size is %Size%
	if (Size == currentCompatibilityKey) ;equal to 665B
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
;		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411F00005308ADBA030000009A00000001000000030000000C000000980F7F42A0E0CE010100000009006B0072006F006E006F0073002D00610073000C0000009DE374514D23CF01010000000B00730074006100740065002E00740078002E00750073000C000000FF2D9D320D2CCF0101000000180074006500730074007300650063007500720069007400790074007200610069006E0069006E0067002E0063006F006D00" /F" ; kronos-as && state.tx.us && testsecuritytraining.com
;		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411f00005308adba04000000bc00000001000000040000000c000000980f7f42a0e0ce010100000009006b0072006f006e006f0073002d00610073000c0000009de374514d23cf01010000000b00730074006100740065002e00740078002e00750073000c000000ff2d9d320d2ccf0101000000180074006500730074007300650063007500720069007400790074007200610069006e0069006e0067002e0063006f006d000c000000ad1562e78c55cf010100000008006d0075006e00690073002d0061007300" /F" ; kronos-as && state.tx.us && testsecuritytraining.com && munis-as
;		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411f00005308adba05000000e200000001000000050000000c000000980f7f42a0e0ce010100000009006b0072006f006e006f0073002d00610073000c0000009de374514d23cf01010000000b00730074006100740065002e00740078002e00750073000c000000ff2d9d320d2ccf0101000000180074006500730074007300650063007500720069007400790074007200610069006e0069006e0067002e0063006f006d000c000000ad1562e78c55cf010100000008006d0075006e00690073002d00610073000c000000470d364f98bccf01010000000a00680075006d0062006c0065002e0069006e007400" /F" ; kronos-as && state.tx.us && testsecuritytraining.com && munis-as && humble.int
		RunWait %ComSpec% /C "REG ADD "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" /T REG_BINARY /D "411F00005308ADBA060000000001000001000000060000000C0000002F35D80292C3CF010100000009006B0072006F006E006F0073002D00610073000C000000DD528F0392C3CF01010000000B00730074006100740065002E00740078002E00750073000C0000009D88600492C3CF0101000000180074006500730074007300650063007500720069007400790074007200610069006E0069006E0067002E0063006F006D000C000000CD680F0592C3CF010100000008006D0075006E00690073002D00610073000C00000006BAC00592C3CF01010000000A00680075006D0062006C0065002E0069006E0074000C000000DFF9AF6F77DECF01010000000600650064002E0067006F007600" /F" ; kronos-as && state.tx.us && testsecuritytraining.com && munis-as && humble.int && ed.gov
		sleep 500
		RunWait %ComSpec% /C "REG QUERY "HKCU\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData" /V "UserFilter" > C:\t.txt"
		sleep 1000
		FileGetSize, newSize, C:\t.txt
		if (newSize == currentCompatibilityKey)
		{
			progress,11,Probability is... high,Checking probability of success,The Unfaltering March Of `Progress
			rej = open
			kronus = good
			goto,scriptstart
		}
		
		if (newSize < currentCompatibilityKey)
		{
			if A_OSVersion in WIN_7,WIN_VISTA
			{
				Run %ComSpec% /C ""%ProgramFiles%\Internet Explorer\iexplore.exe" about:blank"

				settitlematchmode,2
				winwait,Internet Explorer
				sleep 5000
				loop
				{
					winactivate,Internet Explorer
					sleep 1000
					send !x
					sleep 1000
					send b
					sleep 2000

					settitlematchmode,2
					ifwinexist,Compatibility View Settings
					{
						break
					}
					if A_INDEX > 10
					{
						send {tab}
					}
					if A_INDEX > 20
					{
						break
						msgbox,0,Well This is embarrassing,I can't figure out how to manually add those sites. I won't be able to install the latest Internet Explorer.`n`nSorry...,20
						kronus = bad
						rej = locked
						goto,scriptstart
					}
				}
				settitlematchmode,2
				ifwinexist,Compatibility View Settings
				{
					winactivate,Compatibility View Settings
					sleep, 1000
					send kronos-as
					sleep 500
					send {enter}
					sleep 500
					send state.tx.us
					sleep 500
					send {enter}
					sleep 500
					send testsecuritytraining.com
					sleep 500
					send {enter}
					sleep 500
					send munis-as
					sleep 500
					send {enter}
					sleep 500
					send humble.int
					sleep 500
					send {enter}
					sleep 500
					send ed.gov
					sleep 500
					send {enter}
					sleep 1000
					send !c
					settitlematchmode,2
					winclose,Internet Explorer
				}
				else
				{
					msgbox,0,I'm confused,Well this is odd... I swear I just opened Internet Explorer`, but now I can't find it.`nOh well`, I suppose I won't be able to install the latest Internet Explorer.,20
					kronus = bad
					rej = locked
					goto,scriptstart
				}
			}
		}
		else
		{
			if A_OSVersion in WIN_7
			{
				msgbox,0,Well this is odd,The internet explorer compatibility list might be bigger than %currentCompatibilityKey% bytes. I don't really know how to handle this situation`, so I'll just ignore it and keep going.,10
			}
			if A_OSVersion in WIN_XP
			{
				msgbox,0,All shiny here`, captain,Everything seems to check out`, except that you're running Windows XP`, which is a dangerous habit. Regardless`, I'll be continuing as planned.,5
			}
			rej = toobig
			kronos = bad
			goto,scriptstart
		}
	}
	RunWait %ComSpec% /C "del /F /Q c:\t.txt"
	; if udua in true
	; {
		; progress,12,Checking Firefox,Checking versions of installed programs,The Unfaltering March Of `Progress
		; sleep 1000
		
	;;	Check Firefox installed version against installer version
		

		; progress,13,Checking Adobe Reader,Checking versions of installed programs,The Unfaltering March Of `Progress
		; sleep 1000
		
		;; Adobe Reader version check
		; if rej in open
		; {
			; RunWait %ComSpec% /C "REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\Acrobat Reader" > c:\t.txt"
			; sleep 1000
			; run %ComSpec% /C "notepad c:\t.txt"
			; sleep 3000
			; send ^{home}
			; sleep 500
			; send ^f
			; sleep 500
			; send Reader\
			; sleep 500
			; send {enter}
			; sleep 500
			; send !{F4}
			; sleep 500
			; send +{home}
			; sleep 500
			; send {backspace 2}
			; sleep 500
			; send {del 6}
			; sleep 500
			; send +{end}
			; sleep 500
			; send ^c
			; sleep 500
			; send !{F4}
			; sleep 1000
			; send !n
			; sleep 2000
			; areedr = %clipboard%
			; RunWait %ComSpec% /C "del /F /Q c:\t.txt"
			; msgbox,0,Adobe Reader found,You already have Adobe Reader installed (major version %areedr%),5
		; }
		; else
		; {
			; msgbox,0,Sorry,I can't figure out what version of Adobe Reader you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
			; areedr = unknown
		; }
		; if rej in open
		; {
			; if (areedr == "unset")
			; {
				; msgbox,0,Sorry,I can't figure out what version of Adobe Reader you're using which probably means you don't have it installed. I'm going to install the latest one I have`, even `if you don't need it.,5
			; }
		; }
		
		; progress,14,Checking Adobe Flash Player,Checking versions of installed programs,The Unfaltering March Of `Progress
		; sleep 1000
		
		;; Adobe Flash version check

		
		; progress,15,Checking Java,Checking versions of installed programs,The Unfaltering March Of `Progress
		; sleep 1000
		
		;; Java version check
		
		
		
		; IE version check
		; if rej in open
		; {
			; RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
			; sleep 1000
			; RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Internet Explorer" /V "svcVersion" > C:\ci.txt"
			; sleep 1000
;			; SizeCheck
			; FileGetSize, ciSize, C:\ci.txt
;			; msgbox,0,0,size is %Size%
			; if (ciSize < 5) ; less than 5B
			; {
				; RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
				; sleep 1000
				; RunWait %ComSpec% /C "REG QUERY "HKLM\SOFTWARE\Microsoft\Internet Explorer" /V "Version" > C:\ci.txt"
				; sleep 1000
				; FileGetSize, ci2Size, C:\ci.txt
				; if (ci2Size < 5) ; less than 5B
				; {
					; RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
					; msgbox,0,Sorry about this,Sorry but I'm unable to get access to the specific information your want.
				; }
			; }
			; Run %ComSpec% /C "notepad c:\ci.txt"
			; sleep 3000
			; send ^{home}
			; sleep 500
			; send ^f
			; sleep 500
			; send REG_SZ
			; sleep 500
			; send {enter}
			; sleep 500
			; send !{F4}
			; sleep 500
			; send +^{home}
			; sleep 500
			; send {backspace}
			; sleep 500
			; send {del 10}
			; sleep 500
			; send +{end}
			; sleep 500
			; send ^c
			; sleep 500
			; send !{F4}
			; sleep 1000
			; send !n
			; sleep 2000
			; ieversion = %clipboard%
			; RunWait %ComSpec% /C "del /F /Q c:\ci.txt"
			; msgbox,0,Microsoft Internet Explorer found,You already have Microsoft Internet Explorer installed (version %ieversion%),7
		; }
		; else
		; {
			; msgbox,0,Sorry,I can't figure out what version of Microsoft Internet Explorer you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
			; ojavr = unknown
		; }
		; if rej in open
		; {
			; if (ieversion == "unset")
			; {
				; msgbox,0,Sorry,I can't figure out what version of Microsoft Internet Explorer you're using, which is odd. I'm going to install the latest one I have`, even `if you don't need it.,5
			; }
		; }
	; }
	
	
	scriptstart:
	RunWait %ComSpec% /C "del /F /Q c:\t.txt"

	;; The time assumption on the next line is out of date; one of these days I'll re-calculate and version-stamp it.
	;; All of the sleep timers and message box timeouts add up to about 16 minutes. This time doesn't take into account the runwait time on mr.bat, adobereader.msi or either IE*.exe executions, but I'll assume they aren't in excess of 45 minutes. Therefore, if this script takes longer than an hour to run, I'll assume it's broken. As a "fix", here is a timed shutdown at the beginning of this script.

	if A_OSVersion in WIN_VISTA,WIN_7 ; Vista and 7 only. I think XP's shutdown program can't take a delay longer than 99 seconds.
	{
		progress,20,%A_Space%,Preparing provisions for potential problems,The Unfaltering March Of `Progress
		sleep 500
		Run %ComSpec% /C "shutdown -s -t 3600"
	}
	
	;; remove old debugging information
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Start Menu\Programs\Startup\A_Message_from_Tyler_Francis.txt""
	Run %ComSpec% /C "del /F /Q "C:\Documents and Settings\Student\Desktop\remove_message.bat""
	Run %ComSpec% /C "del /F /Q "C:\Users\Student\Desktop\remove_message.bat""

	;; Install Firefox silently
	progress,20,%A_Space%,Updating Firefox,The Unfaltering March Of `Progress
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
		RunWait %ComSpec% /C "del /F /Q C:\Programs_To_Uninstall.txt"
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
	progress,80,%A_Space%,Patching Adobe Reader,The Unfaltering March Of `Progress
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
	
	;; install Intel q45/q43 express chipset drivers
	if A_OSVersion in WIN_7
	{
		fileread,imagetypetext,c:\780w72010.txt
		FoundPos := RegExMatch(imagetypetext, "(Jun-25-2014)", imagetypetextcut)
		if imagetypetextcut in Jun-25-2014
		{
			Runwait,%ComSpec% /C "PnPutil.exe -i -a "igdlh.inf" && timeout /t 15",i:\it\o\intelq45
		}
	}

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
		settitlematchmode,2
		IfWinExist,RunDLL,There was a problem starting C:\Program Files\Java\jre7\bin\\installer.dll
		WinActivate
		send {space}
	}
	
	msiissues:
	{
		sleep 10000
		settitlematchmode,2
		IfWinExist,Windows Installer,OK  ; Should automatically dismiss Adobe Reader installation errors.
		{
			WinActivate
			send {space}
			goto,msiissues
		}
		settitlematchmode,2
		IfWinExist,,Error 1722  ; Should automatically dismiss Adobe Flash Player installation errors.
		{
			WinActivate
			send {space}
			goto,msiissues
		}
		sleep 15000
		settitlematchmode,2
		IfWinExist,Open File - Security Warning,Run
		{
			goto,altr
		}
		settitlematchmode,2
		IfWinExist,Windows Installer,OK  ; Should automatically dismiss Adobe Reader installation errors.
		{
			WinActivate
			send {space}
			goto,msiissues
		}
		settitlematchmode,2
		IfWinExist,,Error 1722  ; Should automatically dismiss Adobe Flash Player installation errors.
		{
			WinActivate
			send {space}
			goto,msiissues
		}
		settitlematchmode,2
		IfWinExist,,what is currently installed  ; Should automatically dismiss Adobe Flash Player installation errors.
		{
			WinActivate
			send {space}
			sleep 10000
			goto,msiissues
		}
		sleep 15000
		settitlematchmode,2
		IfWinExist,Open File - Security Warning,Run
		{
			goto,altr
		}
		return
	}
	
	movewin:
	{
		settitlematchmode,2
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
