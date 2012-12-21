r-ahk-scripts
=============

Random AutoHotKey scripts. It's not great but it's what I'm writing.

What's in the repo
------------------
The following directories:

- automation -- Small and simple, usually "do [thing] 200 times"  

- cs5install -- A script to copy, install and delete Adobe cs5.  

    - The deletion needs work and it'd be nice to kill the process with a hotkey, but nothing beats plugging in a USB HDD, clicking GO and walking away for an hour. Especially since I have literatly hundreds of computers to do this to, and aren't allowed to push it out over the network.  

- maintenance -- This is mostly a script that updates Firefox, Flash, Java, IE and Adobe Reader. It also runs the second most interesting script in this directory which removes a bunch of unwanted programs and files, as listed in the Batch file "mr.txt"  

    - I'd like both "u" and "remove" to be more automatic, requiring no user interaction. To do that I'll probably move the removal bit of "u" to the end and popup a message box asking if the user wants to clean us, with a timeout defaulting to "yes". Moving all of the .exe installers to .msi installers would be great (except Firefox who's .exe installer works very well). I'll also have to get rid of all .exe uninstallers and use msiexec for all removals, which will be really slow if I can't find a quiet switch.
