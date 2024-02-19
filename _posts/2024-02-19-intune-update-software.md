---
title:  "Intune: Scripts and Remediations - Update software"
date:   2024-02-19 18:00:00 +0000
categories: [Intune]
tags: [Intune]
---

![image](/assets/img/intune.png)

---
Ref: 
[Link](https://www.youtube.com/watch?v=ea0g1Y1zaek)

---
Task 1  Find the list id of the application
---

- cmd: winget list
[List Command:](https://learn.microsoft.com/en-us/windows/package-manager/winget/list)
```
winget list -?
```

- use the https://winget.run
- enter the application name
```
winget install -e --id Zoom.Zoom

winget list -e --id Zoom.Zoom --accept-source-agreements
```
![img](/assets/img/intune02.png)


Task2 Powershell - Detection and Remediation Script
---

- [Detection Script](/assets/file/InstalledAppDetection.ps1)
- [Remediation Script](/assets/file/UpdateAppToLatestVersion.ps1)


Test
```
## check locally installed Zoom
$localInstalled_software = winget.exe list -e --id Zoom.Zoom --accept-source-agreements

Logic 
---
- If result contain Avaliable, the application needs to upgrade the version
- If result only contain Version, the application is the latest version 
- If result don't show anything, the application is not installed

```
-3 : line of the header

-2 : "Available" header
```

$available= (-split $localInstalled_software[-3])[-2]
Write-Host $available
```
Result
```
Name Id        Version     Available    Source
----------------------------------------------
Zoom Zoom.Zoom < 5.12.8964 5.17.7.31859 winget
```

- remediation scripts will run with exit 1 from detection script

![img](/assets/img/intune03.png)

![img](/assets/img/intune04.png)

- As Intune is run the script as System.
- use PsExec64.exe -i -s cmd.exe

![img](/assets/img/intune05.png)

![img](/assets/img/intune06.png)

![img](/assets/img/intune07.png)

- Intune>Devices>Windows>Scripts and remediations location

![img](/assets/img/intune08.png)

- The script needs to save as UTF-8 format 

![img](/assets/img/intune09.png)

- Create the script below.

![img](/assets/img/intune10.png)
