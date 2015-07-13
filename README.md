r-ahk-scripts
=============

Random AutoHotKey scripts. It's not great, but it's what I'm writing.

All commits before 2014-01-17 07:59:53 CST were written for AutoHotKey v1.0.48.05 on Windows 7, usually 32-bit.
On 2014-01-17 07:59:53 CST I updated to AutoHotKey v1.1.14.01 on my main development computer (Win 7 32-bit). On 2015-06-11 14:00:00 CST I updated to AutoHotKey v1.1.22.02 Unicode 64-bit on my main development computer (Win 7 64-bit).

Just in case that's relivant.

What's in the repo
------------------
The following directories:

- automation -- Small and simple, usually "do [thing] 200 times"  

- cs5install -- A script to copy, install and delete Adobe cs5.  

    - The deletion needs work, but nothing beats plugging in a USB HDD, clicking GO and walking away for an hour. Especially since I have literately hundreds of computers to do this to, and aren't allowed to push it out over the network.  

- maintenance -- The most interesting scripts in here are "u" and "ua" which update Firefox, Flash, Java, IE and Adobe Reader. It also runs the third most interesting script in this directory which removes a bunch of unwanted programs and files, as listed in the Batch file "mr.txt"  

    - ua.ahk is where most of my time has been spent. u, and to a lesser extent ua, are designed to be modular. Swap out the installer files with newer versions to update programs and add a few lines to mr.txt to remove other programs. As of [2013-10-24](https://github.com/Linkz57/r-ahk-scripts/blob/c4c69fbb4712c2155e520adbfaafaedf53f0e5b2/maintenance/ua.ahk "commit c4c69fbb4712c2155e520adbfaafaedf53f0e5b2") ua has a lovely little progress bar, bringing it closer to having a propper end-user experiance.
    - The u.ahk and ua.ahk scripts are really just frames around the actual installer files. I keep the installers up to date by downloading packages made available by their respective companies. 
        - [Adobe Reader is found here](ftp://ftp.adobe.com/pub/adobe/reader/win/ "Adobe's public FTP server"): ftp://ftp.adobe.com/pub/adobe/reader/win/
        - [Adobe Flash is found here](http://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html "Adobe's Flash Archive page")
        - Firefox will run fine from its normal .exe installer with the option <code>-ms</code>. I use [Firefox ESR](https://www.mozilla.org/en-US/firefox/organizations/all.html "Firefox ESR download page")
        - Java is weird. First you have to install it on a computer using the [offline installer](https://www.java.com/en/download/manual.jsp "Java download page"). Once that's done go to <code>%HOMEDRIVE%%HOMEPATH%\AppData\LocalLow\Sun\Java</code>, find the version you want, then use the .msi and .cab in there to install it on other computers.
        - The download location of Internet Explorer seems to change with every version; here's [version 11](http://windows.microsoft.com/en-us/internet-explorer/ie-11-worldwide-languages "Internet Explorer 11 offline installer")
