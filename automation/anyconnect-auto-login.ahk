;; anyconnect-auto-login.ahk
;; v1
;; Automatically log into Cisco AnyConnect
;; Written by Tyler Francis for JelecUSA on 2015-10-19

winwait,Cisco AnyConnect Secure Mobility Client,Security Warning: Untrusted VPN Server Certificate!
sleep 500
winactivate
send {tab}
sleep 500
send {enter}

winwait,Cisco AnyConnect |
sleep 500
send password
send {enter}

winwait,AnyConnect Downloader,10
{
	winactivate
	send {tab}
	sleep 500
	send {enter}
}
exitapp
