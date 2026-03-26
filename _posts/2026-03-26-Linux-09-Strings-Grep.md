---
title:  "Overthewire-Bandit Level 9 - Strings-Grep"
date:   2026-03-26 21:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit9](https://overthewire.org/wargames/bandit/bandit10.html)

---

## Bandit Level 9
Level Goal
The password for the next level is stored in the file data.txt in one of the few human-readable strings, preceded by several ‘=’ characters.

Commands you may need to solve this level
grep, sort, uniq, strings, base64, tr, tar, gzip, bzip2, xxd

## SSH
```
ssh bandit9@bandit.labs.overthewire.org -p 2220
4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
```

Command
```
bandit9@bandit:~$ 
strings data.txt  | grep "==="
```
Output
```
========== the
========== password
f\Z'========== is
========== FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```

Command
```
strings data.txt | grep "==" | head -n 1
```
```
strings data.txt | grep "==" | awk '{print $NF}'
```