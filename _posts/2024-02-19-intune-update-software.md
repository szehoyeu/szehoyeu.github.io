---
title:  "Intune: Scripts and Remediations - Update software"
date:   2024-02-19 18:00:00 +0000
categories: [Intune]
tags: [Intune]
---

![image](/assets/img/subdomain-numeration01.png)

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

- powershell
```
## check locally installed Zoom
$localInstalled_software = winget.exe list -e --id Zoom.Zoom --accept-source-agreements

# Logic 
# If result contain Avaliable, the application needs to upgrade the version
# If result only contain Version, the application is the latest version 
# If result don't show anything, the application is not installed

# -3 : line of the header
# -2 : "Available" header
$available= (-split $localInstalled_software[-3])[-2]
# Write-Host $available

```

```
Name Id        Version     Available    Source
----------------------------------------------
Zoom Zoom.Zoom < 5.12.8964 5.17.7.31859 winget
```
