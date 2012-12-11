sleep 500
Run, http://starchart.epsilen.com/login.aspx
sleep 5000
send {enter}
sleep 2000
send {F6}
sleep 200
send http://starchart.epsilen.com/campusteachers.aspx
sleep 200
send {enter}
sleep 2000
loop, 11
{
Send {tab}
sleep 200
}
sleep 500
send +^{end}
sleep 5000
loop, 6
{
send +{up}
sleep 200
}
sleep 500
send ^c
sleep 200
run, C:\Program Files\Microsoft Office\Office14\EXCEL.EXE
sleep 7000
send {enter}
sleep 500
send ^v
