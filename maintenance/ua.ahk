MsgBox,4,Update Automatically v1.1,This script written by Tyler Francis wants to install the latest version of "Firefox" "Flash" "Java" "Adobe Reader" and "Internet Explorer" as well as remove a few of the junk programs that you probably don't want. Are you ok with this?,120
IfMsgBox No
{
    MsgBox,0,Nothing Installed,Ok some other time maybe
	exitapp
}
else
{
	MsgBox,0,Ok here we go,Remove your hands from the mouse and keyboard! At the very end you'll be asked if you want to shut down your computer and that is the ONLY time you can click anything. At times it will look like your computer is just sitting here doing nothing. Please resist the urge to "help it along". DO NOT click anything. DO NOT type anything. This entire process is automated. Any interaction on your part will cause this update to go all haywire and you'll have to start it all over again. Don't even click "ok" on this box. In fact get up and walk away. Make yourself some tea and come back in about 17 minutes and this will be done. Don't keep reading this to see what will happen--leave. Go. Now. Make like a tree and turn off your monitor.,30
	;; Kill Windows Explorer to discourage the user from interacting with the computer, and also to reduce the chance of problems that are inherent with macros.
	RunWait %ComSpec% /C "taskkill /F /IM explorer.exe"

	;; All of the sleep timers and message box timeouts add up to about 16 minutes. This time doesn't take into account the runwait time on mr.bat, adobereader.msi or either IE*.exe executions, but I'll assume they aren't in excess of 45 minutes. Therefore, if this script takes longer than an hour to run, I'll assume it's broken. As a "fix" here is a timed shutdown at the beginning of this script.

	if A_OSVersion in WIN_VISTA ; Vista and 7 only. I think XP's shutdown program can't take a delay longer than 99 seconds.
	{
		RunWait %ComSpec% /C "copy notes\A_Message_from_Tyler_Francis.txt "%USERPROFILE%\Start Menu\Programs\Startup"" ; This is a small message telling the user that the update process failed and that they should send me an email saying as much. Were this a *Nix machine I'd CAT in some info like where it failed. I'll have to find out how to do that in Windows without opening Notepad at every action.
		sleep 500
		RunWait %ComSpec% /C "copy notes\remove_message.bat "%USERPROFILE%\Desktop""
		sleep 500
		Run %ComSpec% /C "shutdown -s -t 3600"
	}

	;; Install Firefox silently
	Run FirefoxSetup.exe -ms

	;; Remove Internet Explorer proxy settings
	Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
	Sleep 1000

	;; Change Internet Explorer homepage back to default
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

	;; Flash Player Internet Explorer installation
	sleep 2000
	Run flashplayerIE.exe
	sleep 12000
	send +{tab}
	sleep 200
	send {space}
	sleep 200
	send {tab}
	sleep 200
	send {tab}
	sleep 200
	send {enter}
	sleep 2000
	send {tab}
	sleep 200
	send {enter}

	;; Flash Player Firefox plugin installation
	sleep 2000
    if A_OSVersion in WIN_XP
    {
		Run fp117fx.exe
	}
	if A_OSVersion in WIN_VISTA
	{
	    Run flashplayerFF.exe
    }
    sleep 12000
	send +{tab}
	sleep 200
	send {space}
	sleep 200
	send {tab}
	sleep 200
	send {tab}
	sleep 200
	send {enter}
	sleep 2000
    if A_OSVersion in WIN_XP
    {
		send {down}
		sleep 200
		send {down}
	}
	if A_OSVersion in WIN_VISTA
	{
    	send {tab}
	}
    sleep 200
	send {enter}

	;; Misc Removal Script setup
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"
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
    if A_OSVersion in WIN_XP
    {
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
		
		;;finish replacement
		send !{F4}
		sleep 500
	}
	send ^s
	sleep 500
	send !{F4}

	;; Misc Removal Script execution
	sleep 2000
	RunWait %ComSpec% /C "C:\mr.bat"
    sleep 1000
	RunWait %ComSpec% /C "del /F /Q c:\mr.bat"

	;; Java selection
    RunWait %ComSpec% /C "java.msi /passive /norestart"

	;; Adobe Reader installation
	sleep 2000
	RunWait %ComSpec% /C "adobereader.msi /passive /norestart"
	; sleep 384000 ;; Confirmed: does not need sleep

	;; Internet Explorer installation
	sleep 2000

	if A_OSVersion in WIN_VISTA
	{
		RunWait %ComSpec% /C "IE9-Windows7-x86-enu.exe /passive /norestart"
	}
	sleep 200
	if A_OSVersion in WIN_XP
	{
		RunWait %ComSpec% /C "IE8-WindowsXP-x86-ENU.exe /passive /norestart /sqm"
	}
	sleep 1000

	;; One Final cleanup
	sleep 2000
	Run %ComSpec% /C "del /F /Q c:\mr.bat"

	;; Automatic Shutdown
	sleep 2000
	Run %ComSpec% /C "shutdown -a"
	sleep 500
	if A_OSVersion in WIN_VISTA
	{
		RunWait %USERPROFILE%\Desktop\remove_message.bat ; If the script got this far in execution, I'll assume everything went smoothly and remove the error message from the startup folder.
		sleep 500
	}
	sleep 1000
	Run %ComSpec% /C "shutdown -s -t 600"
	MsgBox, 4, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown now or *NO* to abort the automatic Shutdown of 10 minutes already inprogress. BTdubs the error level is "%ErrorLevel%" on the off chance that you're interested. [this message will self-distruct in seven minutes],420
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
	esc::
	{
        Run %ComSpec% /C "shutdown -a
		Run %ComSpec% /C "explorer"
		ExitApp
	}
}