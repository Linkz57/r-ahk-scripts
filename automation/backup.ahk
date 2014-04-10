msgbox,0,Ok ready to backup your files? (v1),Alright I'm about to copy your Desktop`, Documents and R:\ `drive each into their own ZIP files. That part is easy`, though may take some time depending on how many files you have. Then I'll leave it to you to drag those finished ZIP files into Google Drive.`n`nIf at any time (like now) you want me to stop`, just hit the Esc key at the top left of your keyboard.,30
msgbox,0,Let's go,Alright let's get started.,2

;	closing firefox
process,exist,firefox.exe
while (%errorlevel% != 0)
{
	SetTitleMatchMode,2
	ifwinexist,  - Mozilla Firefox
	{
		winactivate
		sleep 1000
		Winclose
		msgbox,0,Closing Firefox,Closing Firefox,1
		if (%A_Index% > 5)
		{
			Runwait %ComSpec% /C "taskkill /F /IM firefox.exe"
		}
	}
	else
	{
		msgbox,0,whelp,Still trying to close Firefox,2
	}
	sleep 2000
	process,exist,firefox.exe
}

Run FirefoxSetup.exe -ms

if A_OSVersion in WIN_7,WIN_VISTA
{
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe a `%HOMEDRIVE`%\backup_Desktop_%A_YYYY%-%A_Mon%-%A_Mday%__%A_Hour%-%A_Min%-%A_Sec%.zip `%HOMEDRIVE`%`%Homepath`%\Desktop"
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe a `%HOMEDRIVE`%\backup_Documents_%A_YYYY%-%A_Mon%-%A_Mday%__%A_Hour%-%A_Min%-%A_Sec%.zip `%HOMEDRIVE`%`%Homepath`%\Documents"
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe a `%HOMEDRIVE`%\backup_R-drive_%A_YYYY%-%A_Mon%-%A_Mday%__%A_Hour%-%A_Min%-%A_Sec%.zip R:\"
}
if A_OSVersion in WIN_XP
{
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe a `%HOMEDRIVE`%\backup_Desktop_%A_YYYY%-%A_Mon%-%A_Mday%__%A_Hour%-%A_Min%-%A_Sec%.zip "`%HOMEDRIVE`%\Documents and Settings\student\Desktop""
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe a `%HOMEDRIVE`%\Documents%A_YYYY%-%A_Mon%-%A_Mday%__%A_Hour%-%A_Min%-%A_Sec%.zip "`%HOMEDRIVE`%\Documents and Settings\student\My Documents""
	Runwait %ComSpec% /C "..\7-ZipPortable\App\7-Zip\7z.exe a `%HOMEDRIVE`%\backup_R-drive_%A_YYYY%-%A_Mon%-%A_Mday%__%A_Hour%-%A_Min%-%A_Sec%.zip R:\"
}
filemove,c:\backup_*.zip,c:\Documents and Settings\student\Desktop,1
if errorlevel > 0
{
	msgbox,0,Well this is embarrassing,Something went wrong`,I couldn't backup your files for you. Sorry.
	exitapp
}
else
{
	Run %ComSpec% /C ""C:\Program Files\Mozilla Firefox\firefox.exe" https://drive.google.com/a/humbleisd.net/"
	msgbox,0,Please log in,Please wait for Firefox to open and then log into your district assigned Google `Drive account. Your username is "first.last@humbleisd.net" and your password is your employee ID number as used in Munis. `If you don't remember your ID or `if you want to use a different Google account`, go ahead and type in "drive.google.com" to the address bar up there and log into your personal Google account.,60
	
	SetTitleMatchMode,2
	winwait, - Google Drive - Mozilla Firefox
	sleep 1000
	send !{space}
	sleep 500
	send x
	sleep 1000
	if A_OSVersion in WIN_XP
	{
		Run %ComSpec% /C "explorer "`%HOMEDRIVE`%\Documents and Settings\student\Desktop""
	}
	if A_OSVersion in WIN_7,WIN_VISTA
	{
		send #{left}
		Run %ComSpec% /C "`%HOMEDRIVE`%`%Homepath`%\Desktop"
		sleep 2000
		send #{right}
	}
	msgbox,0,Alright it looks like we're ready to go,Ok I think I see Google `Drive open now. I'm going to leave the rest to you. `if my calculations are correct`, you just need to drag the three "backup_*_today.zip" file into the Google `Drive window. `If it asks you about conversion, just accept the default options because they don't apply to ZIP files.`n`nThe zip files are on your desktop.`nGood luck`, I'm out.
	exitapp
}

exitapp

Esc::
{
	msgbox,0,Exiting,Exiting now.,1
	exitapp
}