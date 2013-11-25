;Helps launch FF7 from Steam Big Picture Mode
loop
{
	sleep 2000
	checkbegin:
	sleep 500
	IfWinExist,FINAL FANTASY VII Launcher
		{
			winactivate
			sleep 1000
			click 467,262
			sleep 5000
			send x
			sleep 5000
			send x
			exitapp

		}
	sleep 5000
}

q::exitapp
