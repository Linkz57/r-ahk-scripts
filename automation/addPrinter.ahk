;; addPrinter.ahk

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
	progress,2,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	winactivate
	progress,5,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	progress,7,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	; progress,9,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	; sleep 2000
	; progress,11,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	; sleep 2000
	; progress,13,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	; sleep 2000
	; progress,15,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	; sleep 2000
	; progress,17,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	; sleep 2000
	; progress,19,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	; sleep 2000
	progress,20,Doing some stuff,Please Wait,The Unfaltering March Of `Progress
	sleep 2000
	winactivate
	send !f
	sleep 1000
	send t
	winwait,Add Printer,Local or network printer
	sleep 2000
	winactivate
	send w
	sleep 1000
;	send {tab}
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
	winwait,Add Printer,This printer will be installed with the Brother HL-2280DW Printer driver.
	sleep 2000
	winactivate
	send !p
	sleep 1000
	send The Printer in room 3103 of HHS
	sleep 1000
	send {enter}
	winwait,Add Printer,Printer sharing
	sleep 4000
	winactivate
	send !o
	sleep 1000
	send {enter}
	winwait,Add Printer,To check if your printer is working properly
	sleep 5000
	winactivate
	send !d
	sleep 1000
	send {enter}
}




msgbox,0,0,done,1
exitapp

esc::exitapp
