;; Install Firefox silently
Run FirefoxSetup.exe -ms

;; Remove Internet Explorer proxy settings
Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS" /V "PROXYENABLE" /T REG_DWORD /D "0" /F"
Sleep, 1000

;; Change Internet Explorer homepage back to default
Run %ComSpec% /C "REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "http://humble.k12.tx.us/" /F"
Sleep, 2000

;; Shockwave - Automatic installation of Shockwave is not reliable because the "Don't install the advertisement" button is in one of two places inconsistantly. I probably don't need shockwave, and if I find I do then I'll look for an MSI or something more reliable than Adobe's default offering.
; Run shockwave.exe
; sleep 210000
; send +{tab}
; send +{tab}{space} ;;two shift+tab's for the "don't install Google Chrome" option which I find is the most common advertisement.
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
Run flashplayerFF.exe
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
send {esc}
sleep 1000
send ^+{end}
sleep 1000
send {backspace}
sleep 1000
send ^s
sleep 500
send !{F4}

;; Misc Removal Script execution
sleep 2000
Run 200enters500msinc.exe
RunWait C:\mr.bat
Run %ComSpec% /C "del /F /Q c:\mr.bat"

;; Java selection
MsgBox, 4, Kronos question, Is this a "Teacher Computer"?, 60
IfMsgBox Yes
{
Run java6u24.exe
}
else IfMsgBox No
{
Run java.exe
}
else IfMsgBox TIMEOUT
{
Run java.exe
}

;; Java Installation
sleep 180000
send {tab}
sleep 200
send {tab}
sleep 200
send {tab}
sleep 200
send {enter}
sleep 240000
send {tab}
sleep 200
send {enter}

;; Adobe Reader installation
sleep 2000
RunWait %ComSpec% /C "adobereader.msi /passive"
; sleep 384000 ;; Confirmed: does not need sleep

;; Internet Explorer installation
sleep 2000
RunWait %ComSpec% /C "IE8-WindowsXP-x86-ENU.exe /passive /norestart /sqm"
ifEqual, ErrorLevel, 7
    RunWait %ComSpec% /C "IE9-Windows7-x86-enu.exe /passive /norestart"
else
	MsgBox, 0, FYI, You are not running Windows 7.,5
sleep 1000

;; One Final cleanup
sleep 2000
Run %ComSpec% /C "del /F /Q c:\mr.bat"

;; Automatic Shutdown
sleep 2000
Run %ComSpec% /C "shutdown -s -t 600"
MsgBox, 3, Alright you're done, Do you wanna shutdown or something? *YES* to shutdown now or *NO* to abort the automatic Shutdown of 10 minutes. Clicking *CANCEL* will probably dismiss this window but not abort the automatic shutdown (I'm actually not sure so do me a favor and don't click it please). BTdubs the error level is "%ErrorLevel%" on the off chance that you're interested. [this message will self-distruct in 7 minutes],420
IfMsgBox Yes
	{
	Run %ComSpec% /C "shutdown -a"
	sleep 500
	Run %ComSpec% /C "shutdown -s"
	MsgBox, 4096, Shutdown, Alright--shutting down..., 5
	}
else IfMsgBox No
	{
	Run %ComSpec% /C "shutdown -a"
	MsgBox, 4096, Abort Shutdown, Alright--aborting shutdown.,10
	}