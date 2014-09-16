;; addPrinter.ahk

if A_OSVersion in WIN_XP
{
	msgbox,0,Sorry buddy,Apologies`, but Windows XP (the 12-year-old operating system you're using) doesn't work well with networked printers.,60
	exitapp
}

msgbox,4,Install printer script v1,I'm about to install the Brother Printer from room 3103. Are you OK with this?,120
IfMsgBox No
{
	MsgBox,0,Nothing Installed,Ok some other time maybe,10
	exitapp
}
else
{
	progress,FS10 W600 Y650,%A_Space% `n %A_Space%,Please Wait,The Unfaltering March Of `Progress,Segoe UI
	run control printers
	winwait,Devices and Printers,Address: Control Panel\Hardware and Sound\Devices and Printers
	progress,2,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	winactivate
	progress,5,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,7,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,9,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,11,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,13,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,15,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,17,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,19,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,20,Preparing your computer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	winactivate
	send !f
	sleep 1000
	send t
	winwait,Add Printer,Local or network printer
	progress,30,About to actually add the printer,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	winactivate
	send w
	sleep 1000
;	send {tab}
	progress,40,About to actually add the printer,Please Wait,The Unfaltering March Of `Progress
	loop
	{
		IfWinExist,Add Printer,Add a printer using a TCP/&IP address or hostname
		{
			break
		}
		else
		{
			send !r
		}
		sleep 1000
		if A_Index > 10
		{
			send {tab}
			if A_Index > 20
			{
				msgbox,0,Ooops,I'm having some trouble here. `n`nCould you `click the button labelled "The printer that I want isn't listed" for me?,10
				sleep 10000
			}
		}
	}
	winactivate
	send i
	sleep 1000
	send {enter}
	sleep 1000
	send !a
	progress,50,Selecting the printer,Please Wait,The Unfaltering March Of `Progress
	sleep 1000
	winactivate
	send BRN30055C18034C
	sleep 1000
;	send !q
	sleep 1000
	send {enter}
	winwait,Add Printer,Choose your printer from the list. Click Windows Update to see more models
	sleep 4000
	winactivate
	send !h
	sleep 4000
	send !c
	progress,60,Finding the correct drivers,Please Wait,The Unfaltering March Of `Progress
	sleep 4000
	sendraw i:\it\p\b\hl-2270dw
	sleep 4000
	send {enter}
	sleep 5000
	winactivate,Add Printer
	send +{tab}
	sleep 1000
	send +{tab}
	sendraw Brother hl-2270dw
	sleep 1000
	send {enter}
	progress,70,Installing the printer,Please Wait,The Unfaltering March Of `Progress
	winwait,Add Printer,This printer will be installed with the Brother HL-2280DW Printer driver.
	sleep 2000
	winactivate
	send !p
	sleep 1000
	send The Printer in room 3103 of HHS
	sleep 1000
	send {enter}
	progress,80,Configuring the printer,Please Wait,The Unfaltering March Of `Progress
	winwait,Add Printer,Printer sharing
	sleep 4000
	winactivate
	send !o
	sleep 1000
	send {enter}
	progress,90,Finishing up with the printer,Please Wait,The Unfaltering March Of `Progress
	winwait,Add Printer,To check if your printer is working properly
	sleep 5000
	winactivate
	send !d
	sleep 1000
	send {enter}
	progress,100,%A_Space%,Done!,The Unfaltering March Of `Progress
	sleep 2000
	msgbox,0,All done,OK you're good to go,60
}



exitapp

esc::exitapp
