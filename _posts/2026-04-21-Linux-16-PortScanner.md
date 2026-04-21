---
title:  "Overthewire-Bandit Level 16 - Port Scanner"
date:   2026-04-21 11:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit16](https://overthewire.org/wargames/bandit/bandit17.html)

---

## Bandit Level 16
Level Goal

The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. 

First find out which of these ports have a server listening on them. Then find out which of those speak SSL/TLS and which don’t. 

There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

Helpful note: Getting “DONE”, “RENEGOTIATING” or “KEYUPDATE”? Read the “CONNECTED COMMANDS” section in the manpage.

Commands you may need to solve this level
ssh, telnet, nc, ncat, socat, openssl, s_client, nmap, netstat, ss


Helpful Reading Material
- [Port scanner on Wikipedia](https://en.wikipedia.org/wiki/Port_scanner)


## SSH
```
ssh bandit16@bandit.labs.overthewire.org -p 2220
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
```

# Nmap
```
nmap -p 31000-32000 -sV localhost
```
Output
```
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-04-21 20:58 UTC
Stats: 0:01:02 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 80.00% done; ETC: 20:59 (0:00:16 remaining)
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00011s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT      STATE SERVICE     VERSION
31046/tcp open  echo
31518/tcp open  ssl/echo
31691/tcp open  echo
31790/tcp open  ssl/unknown
31960/tcp open  echo
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port31790-TCP:V=7.94SVN%T=SSL%I=7%D=4/21%Time=69E7E4F9%P=x86_64-pc-linu
SF:x-gnu%r(GenericLines,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x2
SF:0current\x20password\.\n")%r(GetRequest,32,"Wrong!\x20Please\x20enter\x
SF:20the\x20correct\x20current\x20password\.\n")%r(HTTPOptions,32,"Wrong!\
SF:x20Please\x20enter\x20the\x20correct\x20current\x20password\.\n")%r(RTS
SF:PRequest,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x20current\x20
SF:password\.\n")%r(Help,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x
SF:20current\x20password\.\n")%r(FourOhFourRequest,32,"Wrong!\x20Please\x2
SF:0enter\x20the\x20correct\x20current\x20password\.\n")%r(LPDString,32,"W
SF:rong!\x20Please\x20enter\x20the\x20correct\x20current\x20password\.\n")
SF:%r(SIPOptions,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x20curren
SF:t\x20password\.\n");

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 137.62 seconds
```

# OpenSSL



nmap tells us that five ports are open. 
Only Port 31518 and 31790 using SSL. 

- Port 31518 runs only the echo service. 
- Port 31790 runs an unknown service.

```
openssl s_client -connect localhost:31790
```
Paste the password
```
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
```