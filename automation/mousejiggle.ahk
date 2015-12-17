;; mousejiggle.ahk


loop
{
	sleep 10000
	
	random,ranX,-100,100
	random,ranY,-100,100
	
	mousemove,ranX,ranY,20,R
}

Esc::exitapp
