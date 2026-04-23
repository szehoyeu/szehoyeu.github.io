---
title:  "Overthewire-Bandit Level 18 - SSH + ls and + cat"
date:   2026-04-22 11:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit18](https://overthewire.org/wargames/bandit/bandit17.html)

---

## Bandit Level 18
Level Goal

The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified ```.bashrc``` to log you out when you log in with SSH.

Commands you may need to solve this level
ssh, ls, cat


# Note
Common SSH expression allows remote execution of commands by adding the commands afterward 


# SSH + ls

```
ssh bandit18@bandit.labs.overthewire.org -p 2220 ls

x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
```

Output 
```
readme
```

# SSH + cat
```
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
```
x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO

Output 
```
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
                         _                     _ _ _
                        | |__   __ _ _ __   __| (_) |_
                        | '_ \ / _` | '_ \ / _` | | __|
                        | |_) | (_| | | | | (_| | | |_
                        |_.__/ \__,_|_| |_|\__,_|_|\__|


                      This is an OverTheWire game server.
            More information on http://www.overthewire.org/wargames

backend: gibson-1
bandit18@bandit.labs.overthewire.org's password:
cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
```

