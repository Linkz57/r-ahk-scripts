^!p::
loop, 33
{
    Loop, 100
	{
		Send {space}
		sleep 12000
	}
	MsgBox,0,match %A_Index%/33 round 1/3,Want a hundred more spaces?
	Loop, 100
	{
		Send {space}
		sleep 12000
	}
	MsgBox,0,match %A_Index%/33 round 2/3,Want a hundred more spaces?
	Loop, 100
	{
		Send {space}
		sleep 12000
	}
	MsgBox,0,match %A_Index%/33 round 3/3,Want a hundred more spaces?
}