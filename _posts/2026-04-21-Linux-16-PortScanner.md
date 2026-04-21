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
nmap -p 31000-32000 localhost
```
Output
```
 nmap -p 31000-32000 localhost
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-04-21 20:17 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00012s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 0.05 seconds
```

# OpenSSL
```
openssl s_client -connect localhost:31790
```
Paste the password
```

```