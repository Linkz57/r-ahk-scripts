;Helps launch FF7 from Steam Big Picture Mode
loop
{
	IfWinExist,FINAL FANTASY VII Launcher
		{
		winactivate
		sleep 2000
		click 467,262
		sleep 1000
		;wip
		
		exitapp
		}
	sleep 5000
}