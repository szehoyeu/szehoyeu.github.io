---
title:  "Overthewire-Bandit Level 4"
date:   2026-03-19 19:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit4](https://overthewire.org/wargames/bandit/bandit5.html)

---

## Bandit Level 4

Level Goal
The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

Commands you may need to solve this level
ls , cd , cat , file , du , find

#

## SSH
```
ssh bandit4@bandit.labs.overthewire.org -p 2220

2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
```

Using a wildcard instead of the filename using "file" command in order to get the type for all the files within the folder

Command:
```
bandit4@bandit:~/inhere$ 

file ./*
```
Output
```
./-file00: data
./-file01: OpenPGP Public Key
./-file02: OpenPGP Public Key
./-file03: data
./-file04: data
./-file05: data
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: data
```

‘-file07’ is of type ‘ASCII text’, which is a human readable can. 

Command:
```
bandit4@bandit:~/inhere$ 

cat ./-file07
```
Output:
```
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
```
