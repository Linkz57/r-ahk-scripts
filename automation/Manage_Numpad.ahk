;; Manage_Numpad.ahk
;; Version 1.0
;; Written by tyler dot francis at jelec dot com
;; first written on 2018-10-10
;; for use with Timur Abdrazyakov's Numpad 1.1
;; https://sourceforge.net/projects/numpad-emulator/
;;
;; Thanks to u/real_b for the WinMove code in the middle, there.
;; https://www.reddit.com/r/AutoHotkey/comments/28bh1m/screen_coordinates_as_a_percentage_universal/


;msgbox,0,starting,starting,1


Loop
{
	Process, Exist, Numpad_1.1.exe ; check to see if numpad is running
		{
			If ! errorLevel
			{
				IfExist,C:\Program Files (x86)\Numpad_1.1\Numpad_1.1.exe
					Run,C:\Program Files (x86)\Numpad_1.1\Numpad_1.1.exe
				}
			else
			{
;				msgbox,0,next,l00p 2,1

				Process, Exist, Numpad_1.1.exe ; check to see if numpad is running
				while (%errorlevel% != 0)
				{
					SetTitleMatchMode,3
					ifwinexist,Numpad
					{
						SysGet, MonitorCount, MonitorCount
						if MonitorCount = 2
						{
							WinRestore, Numpad
							SysGet, workArea, MonitorWorkArea, 2
							Sysget, m1, MonitorWorkArea, 1
							workAreaWidth := workAreaRight - workAreaLeft
							workAreaHeight := workAreaBottom - workAreaTop
							WinGetPos, winX, winY, winWidth, winHeight, Numpad
							WinMove, Numpad,, workAreaRight - workAreaWidth * 2/6 , 0, workAreaWidth / 6, %workAreaHeight%
							}
						else
						{
							WinRestore, Numpad
							Sysget, MonitorWorkArea, MonitorWorkArea, 1
							WinMove, Numpad,, MonitorWorkAreaRight - MonitorWorkAreaRight * 2/6, 0, MonitorWorkAreaRight / 6,MonitorWorkAreaBottom
							}
						sleep 1000
						Winset, Alwaysontop, On, Numpad
;						msgbox,0,foundit,found it,1
						exitapp,0
						}
					else
					{
						send {F9}
;						msgbox,0,gimmy a bit,Still waiting to open,2
					}
					Sleep 5000	; sleep 5 secconds
					Process, Exist, Numpad_1.1.exe ; check to see if numpad is running
					}
				}
			}
	Sleep 5000	; sleep 5 secconds
	}




;msgbox,0,done,done,1
