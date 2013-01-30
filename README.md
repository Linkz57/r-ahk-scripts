r-ahk-scripts
=============

Random AutoHotKey scripts. It's not great but it's what I'm writing.

What's in the repo
------------------
The following directories:

- automation -- Small and simple, usually "do [thing] 200 times"  

- cs5install -- A script to copy, install and delete Adobe cs5.  

    - The deletion needs work and it'd be nice to kill the process with a hotkey, but nothing beats plugging in a USB HDD, clicking GO and walking away for an hour. Especially since I have literately hundreds of computers to do this to, and aren't allowed to push it out over the network.  

- maintenance -- The most interesting scripts in here are "u" and "ua" which update Firefox, Flash, Java, IE and Adobe Reader. It also runs the third most interesting script in this directory which removes a bunch of unwanted programs and files, as listed in the Batch file "mr.txt"  

    - The "u" and "remove" script are now much more automatic with the newly finished "ua.ahk" script. It's even nicely commented! The removal script is still slowed down by msiexec announcing every time it can't find something, but a quick Google found the /qn switch that should shut the thing up. I'll have to test it a bit, but hopefully that'll make things quicker and move me one step closer to the end user not seeing a thing. 
