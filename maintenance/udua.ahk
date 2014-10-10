;; update ua installers v0.5

;;test-only variables. Delete after version 1
rej = open

;; set up variables
IsTheLatestFlashReleaseAvailableOnWindows = false
FlashFetchIterations = 0
FirefoxTimoutCount = 0
JavaTimoutCount = 0
FlashTimoutCount = 0
UpdateFirefox = true
UpdateJava = true
UpdateFlash = true
JavaRemoteInstallerLink = 0
InstallFirefoxFromIntranet = true
InstallJavaFromIntranet = true
InstallFlashFromIntranet = true

;; clean up workspace
Runwait %ComSpec% /C "del /q c:\udua"
Runwait %ComSpec% /C "rmdir /s /q c:\udua"
sleep 1000
;; recreate workspace
Runwait %ComSpec% /C "mkdir c:\udua"
Runwait %ComSpec% /C "mkdir c:\udua\flash"
Runwait %ComSpec% /C "mkdir c:\udua\firefox"
Runwait %ComSpec% /C "mkdir c:\udua\reader"
Runwait %ComSpec% /C "mkdir c:\udua\java"
IfWinExist,Archived Flash Player versions - Mozilla Firefox
{
	winactivate,Archived Flash Player versions - Mozilla Firefox
	send ^w
	sleep 500
}
ifwinexist,Java Downloads for All Operating Systems - Mozilla Firefox
{
	winactivate,Java Downloads for All Operating Systems - Mozilla Firefox
	send ^w
	sleep 500
}
ifwinexist,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox
{
	winactivate,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox
	send ^w
	sleep 500
}

; listvars
; pause

errorlevel = 0


;; measure local installer versions
;; find version of Firefox installer
loop, Firefox*.version
FirefoxInstallerVersionRaw = %A_LoopFileName%
StringSplit,FirefoxInstallerVersionArray,FirefoxInstallerVersionRaw,%A_Space%,.exe.version

;; find version of Adobe Reader installer
loop, AdbeRdrUpd*.msp.version
ReaderInstallerVersion = %A_LoopFileName%

;; find version of Adobe Flash IE installer
loop, flashplayer*winax.msi.version
FlashIeInstallerVersion = %A_LoopFileName%

;; find version of Adobe Flash Firefox installer
loop, flashplayer*win.msi.version
FlashFfInstallerVersion = %A_LoopFileName%

;; find version of Internet Explorer installer
loop, ie*_win7_x86.msi.version
IEWin7x86InstallerVersion = %A_LoopFileName%

;; find version of Java installer
loop, jre*.msi.version
JavaInstallerVersion = %A_LoopFileName%



;; measure remote installer versions
;; find version of Firefox installer
FirefoxUpdateCheck:
listvars
; pause
if UpdateFirefox in true
{
	Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" about:blank" ; open a blank page to keep Firefox open while opening and closing these other tabs.
	settitlematchmode,2
	winwait,Mozilla Firefox
	Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://www.mozilla.org/en-US/firefox/organizations/all/"
;	msgbox,0,0,error level is %errorlevel%,2
	settitlematchmode,3
	winwait,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox,,30
	if errorlevel
	{
		if FirefoxTimoutCount > 1
		{
			msgbox,0,Twice now it's failed!,Well this is lame`, is the internet down? `nWhatever`, I'll just skip the Firefox update.,5
			winactivate,Mozilla Firefox
			sleep 500
			send ^w
			UpdateFirefox = false
			goto,FirefoxUpdateCheck
		}
		else
		{
			msgbox,0,This is taking too long,This is taking too long. I'm going to try it again,5
			FirefoxTimoutCount ++
			settitlematchmode,2
			winactivate,Mozilla Firefox
			sleep 500
			send ^w
			goto,FirefoxUpdateCheck
		}
	}
	sleep 7000
	winactivate,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox
	send /
	sleep 500
	send English (US)
	sleep 500
	send {tab}
	sleep 500
	send {enter}
	winwait,ahk_class MozillaDialogClass,,20
	winactivate,ahk_class MozillaDialogClass
	WinGetTitle, RemoteFirefoxVersionRaw, A
	winclose
	StringSplit,RemoteFirefoxVersionArray,RemoteFirefoxVersionRaw,%A_Space%,esr.exe
	ifwinexist,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox
	{
		winactivate,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox
		send ^w
	}
}



;; find version of Java installer
JavaUpdateCheck:
listvars
if UpdateJava in true
{
	Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://www.java.com/en/download/manual.jsp"
	settitlematchmode,3
	winwait,Java Downloads for All Operating Systems - Mozilla Firefox,,30
	if errorlevel
	{
		if JavaTimoutCount > 1
		{
			msgbox,0,Twice now it's failed!,Well this is lame`, is the internet down? `nWhatever`, I'll just skip the Java update.,5
			winactivate,Mozilla Firefox
			sleep 500
			send ^w
			UpdateJava = false
			goto,JavaUpdateCheck
		}
		else
		{
			msgbox,0,This is taking too long,This is taking too long. I'm going to try it again...,5
			JavaTimoutCount ++
			settitlematchmode,2
			winactivate,Mozilla Firefox
			sleep 500
			send ^w
			goto,JavaUpdateCheck
		}
	}
	sleep 7000
	winactivate,Java Downloads for All Operating Systems - Mozilla Firefox
	send '
	sleep 500
	send Windows Offline
	sleep 500
	send {enter}
	winwait,ahk_class MozillaDialogClass,,20
	winactivate,ahk_class MozillaDialogClass
	WinGetTitle, RemoteJavaVersionRaw, A
	winclose
	StringSplit,RemoteJavaVersionArray,RemoteJavaVersionRaw,%A_Space%
	winactivate,Java Downloads for All Operating Systems - Mozilla Firefox
	send +{F10}
	sleep 500
	send a
	JavaRemoteInstallerLink = %clipboard%
	winactivate,Java Downloads for All Operating Systems - Mozilla Firefox
	send ^w
}


;; find version of Internet Explorer
;http://windows.microsoft.com/en-us/internet-explorer/ie-11-worldwide-languages
;http://windows.microsoft.com/en-us/internet-explorer/ie-12-worldwide-languages



;; find version of Adobe Flash installer
flashfetch:
listvars
if UpdateFlash in true
{
	Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html"
	settitlematchmode,3
	winwait,Archived Flash Player versions - Mozilla Firefox,,30
	if errorlevel
	{
		if FlashTimoutCount > 1
		{
			msgbox,0,Twice now it's failed!,Well this is lame`, is the internet down? `nWhatever`, I'll just skip the Flash update.,5
			winactivate,Mozilla Firefox
			sleep 500
			send ^w
			UpdateFlash = false
			goto,flashfetch
		}
		else
		{
			msgbox,0,This is taking too long,This is taking too long. I'm going to try it again...,5
			FlashTimoutCount ++
			settitlematchmode,2
			winactivate,Mozilla Firefox
			sleep 500
			send ^w
			goto,flashfetch
		}
	}
	;winactivate
	sleep 7000
	winactivate,Archived Flash Player versions - Mozilla Firefox
	send /
	sleep 500
	send (released 
	sleep 500
	send {tab}
	send '
	sleep 500
	send Flash Player
	loop,%FlashFetchIterations%
	{
		sleep 500
		send ^g
	}
	sleep 500
	send {enter}
	winwait,ahk_class MozillaDialogClass,,20
	winactivate,ahk_class MozillaDialogClass
	WinGetTitle, RemoteFlashVersionRaw, A
	winclose
	sleep 500
	IfWinExist,Archived Flash Player versions - Mozilla Firefox
	{
		winactivate,Archived Flash Player versions - Mozilla Firefox
		send ^w
	}
	StringSplit,RemoteFlashVersionArray,RemoteFlashVersionRaw,%A_Space%,"_archive.zip"
	msgbox,0,Hold your horses,I'm going to download (but not install) the latest version of Flash to see `if it's compatible with Windows.`nJust give me a few seconds.,4
	UrlDownloadToFile,http://download.macromedia.com/pub/flashplayer/installers/archive/%RemoteFlashVersionArray2%_archive.zip,c:\udua\flash%RemoteFlashVersionArray2%.zip
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe e -y -oc:\udua\flash c:\udua\flash%RemoteFlashVersionArray2%.zip"
	loop, c:\udua\flash\flashplayer*_win.msi,0,1
	IsTheLatestFlashReleaseAvailableOnWindows = %A_LoopFileName%
	FlashFetchIterations ++
	if IsTheLatestFlashReleaseAvailableOnWindows in false
	{
		msgbox,0,bummer,It looks like that version of Flash is not available for Windows. I'll try the next one on the list,2
		IfWinExist,Archived Flash Player versions - Mozilla Firefox
		{
			winactivate,Archived Flash Player versions - Mozilla Firefox
			send ^w
		}
		goto,flashfetch
	}
	else
	{
		msgbox,0,Good news`, everyone,The latest version of flash is available for Windows.,3
	}
	settitlematchmode,2
	;winclose,Mozilla Firefox
}
listvars



;;	Check Firefox installed version against installer version

IniRead, FirefoxVersion, %ProgramFiles%\Mozilla Firefox\application.ini, App, Version
IniRead, FirefoxRepo, %ProgramFiles%\Mozilla Firefox\application.ini, App, SourceRepository


FoundPos := RegExMatch(FirefoxRepo, "(esr)", FirefoxRepoFiltered)
msgbox,0,The version of Firefox you currently have installed,Firefox %FirefoxVersion% %FirefoxRepoFiltered% is currently installed,3

StringReplace,LocalFirefoxInstallerVersionWithoutPeriods,FirefoxInstallerVersionArray3,.,,All
StringReplace,RemoteFirefoxInstallerVersionWithoutPeriods,RemoteFirefoxVersionArray4,.,,All



if (LocalFirefoxInstallerVersionWithoutPeriods > RemoteFirefoxInstallerVersionWithoutPeriods)
{
	msgbox,0,Whelp something broked,This is odd... The Firefox version I had planned on installing is supposedly NEWER than the latest version available from the folks who make it. `nI don't really understand what must have gone wrong but I'm going to ignore this oddity and try to keep going.,15
}

if (LocalFirefoxInstallerVersionWithoutPeriods == RemoteFirefoxInstallerVersionWithoutPeriods)
{
	msgbox,0,Hey guess what,Good news: the version of Firefox that I had planned on installing is the latest version.,5
}

if (LocalFirefoxInstallerVersionWithoutPeriods < RemoteFirefoxInstallerVersionWithoutPeriods)
{
	msgbox,0,It looks like I need to update,The local installer is out of date. I'm gonna go fetch the newest version--I'll be right back.,4
	UrlDownloadToFile,https://download.mozilla.org/?product=firefox-%RemoteFirefoxVersionArray4%esr&os=win&lang=en-US,C:\udua\firefox\FirefoxSetup%RemoteFirefoxVersionArray4%esr.exe
	filemove,FirefoxSetup.exe,FirefoxSetup.exe.%FirefoxInstallerVersionArray3%.bak,1
	if errorlevel
	{
		msgbox,0,Hey look`, I found a snag!,Long story short: someone `else is running this same script`, so I can't replace my usual version of Firefox with the update I just got.`nDon't worry`,I'll still update YOUR Firefox`, just not anyone else's.,15
		InstallFirefoxFromIntranet = false
	}
	else
	{
		filemove,C:\udua\firefox\Firefox*.exe,FirefoxSetup.exe,0
		filemove,Firefox*.exe.version,Firefox Setup %RemoteFirefoxVersionArray4%esr.exe.version
		InstallFirefoxFromIntranet = true
		msgbox,0,Everything's Shiny here`, captain,It looks like everything went smoothly enough. Now you and anyone `else who runs this script will have the latest version of Firefox available to install. `nI'll get around to actually installing it later`, but I just wanted to take this moment to congratulate myself.,10
	}
}

;msgbox,0,0,RemoteFirefoxVersionArray4 equals %RemoteFirefoxVersionArray4% `nFirefoxInstallerVersionArray3 equals %FirefoxInstallerVersionArray3%

;msgbox,0,0,%FirefoxInstallerVersion% is the version I want to install.,3
listvars



;;	Check Java installed version against installer version
; Java version check
if rej in open
{
	RunWait %ComSpec% /C "REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in" > c:\udua\java\t.txt"
	sleep 1000
	fileread,javaraw,c:\udua\java\t.txt
	StringReplace,ojavr,javaraw,HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Plug-in\,,All
	StringReplace,ojavr,ojavr,`r`n,,All
	msgbox,0,Oracle Java found,You already have Oracle Java installed (version %ojavr%),5
	
	StringReplace,RemoteJavaVersionJustNumbers,RemoteJavaVersionArray2,jre-,,All
	StringReplace,RemoteJavaVersionJustNumbers,RemoteJavaVersionJustNumbers,-windows-i586.exe,,All
	StringReplace,RemoteJavaVersionJustNumbers,RemoteJavaVersionJustNumbers,u,,All

	StringReplace,JavaInstallerVersionJustNumbers,JavaInstallerVersion,jre1.,,All
	StringReplace,JavaInstallerVersionJustNumbers,JavaInstallerVersionJustNumbers,.msi.version,,All
	StringReplace,JavaInstallerVersionJustNumbers,JavaInstallerVersionJustNumbers,.0_,,All
}
else
{
	msgbox,0,Sorry,I can't figure out what version of Oracle Java you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
	ojavr = unknown
}
if rej in open
{
	if (ojavr == "")													; unset
	{
		msgbox,0,Sorry,I can't figure out what version of Oracle Java you're using which probably means you don't have it installed. I'm going to install the latest one I have`, even `if you don't need it.,5
	}
}

if (JavaInstallerVersionJustNumbers > RemoteJavaVersionJustNumbers)
{
	msgbox,0,Whelp something broked,This is odd... The Java version I had planned on installing is supposedly NEWER than the latest version available from the folks who make it. `nI don't really understand what must have gone wrong but I'm going to ignore this oddity and try to keep going.,15
}

if (JavaInstallerVersionJustNumbers == RemoteJavaVersionJustNumbers)
{
	msgbox,0,Hey guess what,Good news: the version of Java that I had planned on installing is the latest version.,5
	InstallJavaFromIntranet = true
}

if (JavaInstallerVersionJustNumbers < RemoteJavaVersionJustNumbers)
{
	msgbox,0,It looks like I need to update,The local installer is out of date. I'm gonna go fetch the newest version--I'll be right back.,4
	UrlDownloadToFile,%JavaRemoteInstallerLink%,C:\udua\java\%RemoteJavaVersionArray2%.exe
	
;	%HOMEDRIVE%%HOMEPATH%\AppData\LocalLow\Sun\Java
	InstallJavaFromIntranet = false
}


;;	Check Flash installed version against installer version
if rej in open
{
	RunWait %ComSpec% /C "REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Macromedia\FlashPlayerActiveX" /V Version > c:\udua\flash\ie.txt" ;get Flash IE version from registry, commit to file for reading back in
	RunWait %ComSpec% /C "REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Macromedia\FlashPlayerPlugin" /V Version > c:\udua\flash\ff.txt" ;get Flash FF version from registry, commit to file for reading back in
	sleep 1000
	fileread,installedIeFlashRaw,c:\udua\flash\ie.txt 					; read back in to variable
	fileread,installedFfFlashRaw,c:\udua\flash\ff.txt 					; read back in to variable
																		;;whittle down Flash IE REG string to usable numbers
	StringReplace,installedIeFlash,installedIeFlashRaw,HKEY_LOCAL_MACHINE\SOFTWARE\Macromedia\FlashPlayerActiveX,,All ; take out first line
	StringReplace,installedIeFlash,installedIeFlash,`r`n,,All			; take out new lines
	StringReplace,installedIeFlash,installedIeFlash,` ,,All 			; take out spaces
	StringReplace,installedIeFlash,installedIeFlash,REG_SZ,,All			; take out remaining REG cruft info
	StringReplace,installedIeFlash,installedIeFlash,Version,,All		; take out remaining REG cruft info
	StringReplace,installedIeFlashOnlyNumbers,installedIeFlash,.,,All	; take out version-type separators for math later
																		;;whittle down Flash FF REG string to usable numbers
	StringReplace,installedFfFlash,installedFfFlashRaw,HKEY_LOCAL_MACHINE\SOFTWARE\Macromedia\FlashPlayerPlugin,,All 	; take out first line
	StringReplace,installedFfFlash,installedFfFlash,`r`n,,All 			; take out new lines
	StringReplace,installedFfFlash,installedFfFlash,` ,,All				; take out spaces
	StringReplace,installedFfFlash,installedFfFlash,REG_SZ,,All			; take out remaining REG cruft info
	StringReplace,installedFfFlash,installedFfFlash,Version,,All 		; take out remaining REG cruft info
	StringReplace,installedFfFlashOnlyNumbers,installedFfFlash,.,,All	; take out version-type separators for math later	
																		;;whittle down Flash IE .version string to usable number
	StringReplace,FlashIeInstallerVersionJustNumbers,FlashIeInstallerVersion,flashplayer,,All	; take out beginning
	StringReplace,FlashIeInstallerVersionJustNumbers,FlashIeInstallerVersionJustNumbers,winax.msi.version,,All	; take out ending
	StringReplace,FlashIeInstallerVersionJustNumbers,FlashIeInstallerVersionJustNumbers,_,,All	; take out the three underscores in middle
	StringReplace,FlashIeInstallerVersionJustNumbers,FlashIeInstallerVersionJustNumbers,r,,All	; take out a single 'r' separating major and minor version
																		;;whittle down Flash FF .version string to usable number
	StringReplace,FlashFfInstallerVersionJustNumbers,FlashFfInstallerVersion,flashplayer,,All	; take out beginning
	StringReplace,FlashFfInstallerVersionJustNumbers,FlashFfInstallerVersionJustNumbers,win.msi.version,,All	; take out ending
	StringReplace,FlashFfInstallerVersionJustNumbers,FlashFfInstallerVersionJustNumbers,_,,All	; take out the three underscores in middle
	StringReplace,FlashFfInstallerVersionJustNumbers,FlashFfInstallerVersionJustNumbers,r,,All	; take out a single 'r' separating major and minor version
}
else
{
	msgbox,0,Sorry,I can't figure out what version of Adobe Flash you're using`, so I'm just going to install the latest one I have`, even `if you don't need it.,5
	installedIeFlash = unknown
	installedFfFlash = unknown
}

if rej in open
{
	if (installedIeFlash == "")											; unset
	{
		if (installedFfFlash == "")										; unset
		{
			msgbox,0,Sorry,I can't figure out what version of Adobe Flash you're using`, which probably means you don't have it installed. `nI'm going to install the latest one I have`, even `if you don't need it.,5
		}
	}
}




if (FlashIeInstallerVersionJustNumbers > RemoteJavaVersionJustNumbers)
{
	msgbox,0,Whelp something broked,This is odd... The Java version I had planned on installing is supposedly NEWER than the latest version available from the folks who make it. `nI don't really understand what must have gone wrong but I'm going to ignore this oddity and try to keep going.,15
}

if (JavaInstallerVersionJustNumbers == RemoteJavaVersionJustNumbers)
{
	msgbox,0,Hey guess what,Good news: the version of Java that I had planned on installing is the latest version.,5
	InstallJavaFromIntranet = true
}

if (JavaInstallerVersionJustNumbers < RemoteJavaVersionJustNumbers)
{
	msgbox,0,It looks like I need to update,The local installer is out of date. I'm gonna go fetch the newest version--I'll be right back.,4
	UrlDownloadToFile,%JavaRemoteInstallerLink%,C:\udua\java\%RemoteJavaVersionArray2%.exe
	

	InstallJavaFromIntranet = false
}

	
;;WIP





; if (JavaInstallerVersionJustNumbers > RemoteJavaVersionJustNumbers)
; {
	; msgbox,0,Whelp something broked,This is odd... The Java version I had planned on installing is supposedly NEWER than the latest version available from the folks who make it. `nI don't really understand what must have gone wrong but I'm going to ignore this oddity and try to keep going.,15
; }

; if (JavaInstallerVersionJustNumbers == RemoteJavaVersionJustNumbers)
; {
	; msgbox,0,Hey guess what,Good news: the version of Java that I had planned on installing is the latest version.,5
	; InstallJavaFromIntranet = true
; }

; if (JavaInstallerVersionJustNumbers < RemoteJavaVersionJustNumbers)
; {
	; msgbox,0,It looks like I need to update,The local installer is out of date. I'm gonna go fetch the newest version--I'll be right back.,4
	; UrlDownloadToFile,%JavaRemoteInstallerLink%,C:\udua\java\%RemoteJavaVersionArray2%.exe
	

	; InstallJavaFromIntranet = false
; }



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
		msgbox,0,Sorry,I can't figure out what version of Microsoft Internet Explorer you're using, which is odd. I'm going to install the latest one I have`, even `if you don't need it.,5
	}
}
	






settitlematchmode,3
winactivate,Mozilla Firefox
sleep 1000
send ^w

listvars
msgbox,0,0,pausing,1
pause

Runwait %ComSpec% /C "del /q c:\udua"
Runwait %ComSpec% /C "rmdir /s /q c:\udua"


exitapp

Esc::exitapp
