;; update ua installers v0.1

;; set up variables
IsTheLatestFlashReleaseAvailableOnWindows = false
FlashFetchIterations = 0

;; clean up workspace
Runwait %ComSpec% /C "del /q c:\udua"
Runwait %ComSpec% /C "rmdir /s /q c:\udua"
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



;; measure local installer versions
;; find version of Firefox installer
loop, firefox*.version
FirefoxInstallerVersionRaw = %A_LoopFileName%
StringSplit,FirefoxInstallerVersionArray,FirefoxInstallerVersionRaw,%A_Space%,.exe.version

;; find version of Adobe Reader installer
loop, AdbeRdrUpd*.msp.version
ReaderInstallerVersion = %A_LoopFileName%

;; find version of Adobe Flash IE installer
loop, flashplayer*winax.msi.version
FlashIEInstallerVersion = %A_LoopFileName%

;; find version of Adobe Flash Firefox installer
loop, flashplayer*win.msi.version
FlashFXInstallerVersion = %A_LoopFileName%

;; find version of Internet Explorer installer
loop, ie*_win7_x86.msi.version
IEWin7x86InstallerVersion = %A_LoopFileName%

;; find version of Java installer
loop, jre*.msi.version
IEWin7x86InstallerVersion = %A_LoopFileName%



;; measure remote installer versions
;; find version of Firefox installer
Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://www.mozilla.org/en-US/firefox/organizations/all/"
settitlematchmode,3
winwait,Mozilla Firefox Web Browser — Download Firefox Extended Support Release in your language — Mozilla - Mozilla Firefox,,20
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



;; find version of Java installer
Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://www.java.com/en/download/manual.jsp"
settitlematchmode,3
winwait,Java Downloads for All Operating Systems - Mozilla Firefox,,20
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
send ^w



;; find version of Internet Explorer
;http://windows.microsoft.com/en-us/internet-explorer/ie-11-worldwide-languages
;http://windows.microsoft.com/en-us/internet-explorer/ie-12-worldwide-languages



;; find version of Adobe Flash Firefox installer
flashfetch:
Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html"
settitlematchmode,3
winwait,Archived Flash Player versions - Mozilla Firefox,,20
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
Runwait %ComSpec% /C "mkdir c:\udua"
Runwait %ComSpec% /C "mkdir c:\udua\flash"
Runwait %ComSpec% /C "mkdir c:\udua\firefox"
Runwait %ComSpec% /C "mkdir c:\udua\reader"
Runwait %ComSpec% /C "mkdir c:\udua\java"
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

;;	Check Firefox installed version against installer version

IniRead, FirefoxVersion, %ProgramFiles%\Mozilla Firefox\application.ini, App, Version
IniRead, FirefoxRepo, %ProgramFiles%\Mozilla Firefox\application.ini, App, SourceRepository


FoundPos := RegExMatch(FirefoxRepo, "(esr)", FirefoxRepoFiltered)
msgbox,0,0,Firefox %FirefoxVersion% %FirefoxRepoFiltered% is currently installed,3

StringReplace,LocalFirefoxInstallerVersionWithoutPeriods,FirefoxInstallerVersionArray3,.,,All
StringReplace,RemoteFirefoxInstallerVersionWithoutPeriods,RemoteFirefoxVersionArray4,.,,All



if %LocalFirefoxInstallerVersionWithoutPeriods% > %RemoteFirefoxInstallerVersionWithoutPeriods%
{
	msgbox,0,Whelp something broked,This is odd... The Firefox version I had planned on installing is supposedly NEWER than the latest version available from the folks who make it. `nI don't really understand what must have gone wrong but I'm going to ignore this oddity and try to keep going.,15
}

if %LocalFirefoxInstallerVersionWithoutPeriods% == %RemoteFirefoxInstallerVersionWithoutPeriods%
{
	msgbox,0,Hey guess what,Good news: the version of Firefox that I had planned on installing is the latest version.,5
}

if %LocalFirefoxInstallerVersionWithoutPeriods% < %RemoteFirefoxInstallerVersionWithoutPeriods%
{
	msgbox,0,It looks like I need to update,The local installer is out of date. I'm gonna go fetch the newest version--I'll be right back.,4
	UrlDownloadToFile,https://download.mozilla.org/?product=firefox-%RemoteFirefoxVersionArray4%esr&os=win&lang=en-US,C:\udua\firefox\FirefoxSetup%RemoteFirefoxVersionArray4%esr.exe
	filemove,FirefoxSetup.exe,FirefoxSetup.exe.%FirefoxInstallerVersionArray3%.bak,1
	if errorlevel
	{
		msgbox,0,Hey look`, I found a snag!,Long story short: someone `else is running this same script`, so I can't replace my usual version of Firefox with the update I just got.`nDon't worry`,I'll still update YOUR Firefox`, just not anyone else's.,15
		InstallFromIntranet = false
	}
	else
	{
		filemove,C:\udua\firefox\Firefox*.exe,FirefoxSetup.exe,0
		filemove,Firefox*.exe.version,Firefox Setup %RemoteFirefoxVersionArray4%esr.exe.version
		InstallFromIntranet = true
	}
}

;msgbox,0,0,RemoteFirefoxVersionArray4 equals %RemoteFirefoxVersionArray4% `nFirefoxInstallerVersionArray3 equals %FirefoxInstallerVersionArray3%

;msgbox,0,0,%FirefoxInstallerVersion% is the version I want to install.,3
listvars
pause

Runwait %ComSpec% /C "del /q c:\udua"
Runwait %ComSpec% /C "rmdir /s /q c:\udua"
;;WIP

exitapp

Esc::exitapp
