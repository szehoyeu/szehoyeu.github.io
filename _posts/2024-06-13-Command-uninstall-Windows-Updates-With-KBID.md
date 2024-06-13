---
title:  "Windows - Command Prompt-Uninstall Windows updates with specific KBID"
date:   2024-06-13 15:00:00 +0000
categories: [cmd]
tags: [cmd]
---

![img](/assets/img/cmd.png)

---


Step 1 - Open command prompt as administrator

Check the installed Windows update that causing issue (Look for the latest update KBID)

Command
```
wmic qfe list brief 
```

Step 2 - Uninstall the latest updates
Note: 
wusa.exe - path 
```
%windir%\system32
```
Command
```
wusa /uninstall /kb:12313123123
```

Step 3 - Restart the computer