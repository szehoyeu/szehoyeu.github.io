---
title:  "Microsoft - Transfer NTP server to another Domain Controller"
date:   2024-05-08 19:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---

![img](/assets/img/ps.png)

![img](/assets/img/ms.png)


---
Ref: 

- [Link](https://learn.microsoft.com/en-us/answers/questions/533183/ntp-server-migration-to-new-dc)

- [NIST Internet Time Servers](https://tf.nist.gov/tf-cgi/servers.cgi)

---

After the PDC role moved to the new Domain Controller, then configure the time source

```
w32tm /unregister
net stop w32time
w32tm /register
net start w32time
w32tm /config /manualpeerlist:<ntp ip address> /syncfromflags:manual /reliable:yes /update
net stop w32time
net start w32time
```
Then verify the time source has been changed
```
w32tm /query /status
w32tm /query /source
w32tm /query /configuration
```
[NIST Internet Time Servers](https://tf.nist.gov/tf-cgi/servers.cgi)



