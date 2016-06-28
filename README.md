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
        - [Adobe Reader is found here](ftp://ftp.adobe.com/pub/adobe/reader/win/ "Adobe's public FTP server"): ftp://ftp.adobe.com/pub/adobe/reader/win/ or you can [extract an MSI from the EXE here](https://get.adobe.com/reader/enterprise/ "Acrobat Reader enterprise download").
        - [The penultimate version of Adobe Flash is found here](http://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html "Adobe's Flash Archive page") For the newest version of NPAPI Flash, try [this new URL I found](https://fpdownload.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_22_plugin.msi "New NPAPI URL I found") and here's one for [the newest ActiveX version](https://fpdownload.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_22_active_x.msi "New ActiveX Flash plugin I found"). This is for version 22. To get a newer version for you future folk, change the URL from flash_player_21_foo.msi to _23_, or _24_. As of 2016-06-20 at 10am, 22 is the latest major version of Flash (22.0.0.192 is the current full version, and what I got from this new URL). Changing this url will also give me version 21 and 20, so I suspect it only offers the current major and the previous two major versions of the plugin.
        - Firefox will run fine from its normal .exe installer with the option <code>-ms</code>. I use [Firefox ESR](https://www.mozilla.org/en-US/firefox/organizations/all.html "Firefox ESR download page"). You can [customize it](https://developer.mozilla.org/en-US/Firefox/Enterprise_deploymenthttps://developer.mozilla.org/en-US/Firefox/Enterprise_deployment "Mozilla Wiki article on customizing installations") during installation, though I've never tried it myself.
        - Java's installation recently got simultainously more simple and less useful. Now you just download the [offline installer](https://www.java.com/en/download/manual.jsp "Java download page"), and run it with the "/s" switch for a "silent" install. For the purposes of this script, that makes things easier. For everyone using GPOs to keep their software up to date, you're out of luck, as the MSI no longer works. It exists, and it even has its CAB bundled in, but I can't get it to do anything useful. 
        - The download location of Internet Explorer seems to change with every version; here's [version 11](http://windows.microsoft.com/en-us/internet-explorer/ie-11-worldwide-languages "Internet Explorer 11 offline installer")
        - I have not added a Chrome update wrapper to u or ua, but iof you want to, you'll need the [Chrome MSI here](https://www.google.com/work/chrome/browser "Google Chrome for Work"). Although they do not name the file 'Chrome_version.version.msi' you can find the version in the MSI's comments by right clicking the MSI > Properties > Details > Comments.
