settitlematchmode,2

winwait,chatrealm.net
{
	sleep 15000
	winactivate,chatrealm.net
	sendraw /join #chat
	sleep 1000
	winactivate,chatrealm.net
	send {enter}
	sleep 2000
	while winnotexist ("#chat")
	{
		ifwinnotexist,#chat
		{
			winactivate,,Pidgin
			send ^w
			sleep 3000
		}
		else
		{
			break
		}
	}
	msgbox,0,Closing login script,Alright`, you're in,2
	
	if A_TickCount < 120
	{
		SendMessage 0x112, 0xF170, 2, , Program Manager
	}
	exitapp
}

esc::exitapp
