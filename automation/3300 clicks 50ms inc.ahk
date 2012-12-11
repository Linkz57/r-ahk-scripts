^!p::
loop, 33
{
    Loop, 100
	{
		click
		sleep 50
	}
	MsgBox,0,match %A_Index%/33 round 1/3,Want three hundred more clicks?
	Loop, 100
	{
		click
		sleep 50
	}
;	MsgBox,0,match %A_Index%/33 round 2/3,Want a hundred more clicks?
	Loop, 100
	{
		click
		sleep 50
	}
;	MsgBox,0,match %A_Index%/33 round 3/3,Want a hundred more clicks?
}