---
title:  "Overthewire-Bandit Level 08 - Sort-Uniq"
date:   2026-03-26 20:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit8](https://overthewire.org/wargames/bandit/bandit9.html)

---

## Bandit Level 8
Level Goal
The password for the next level is stored in the file data.txt and is the only line of text that occurs only once

Commands you may need to solve this level
grep, sort, uniq, strings, base64, tr, tar, gzip, bzip2, xxd

Helpful Reading Material
Piping and Redirection

## SSH
```
ssh bandit8@bandit.labs.overthewire.org -p 2220
dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc
```

Commands:
```
sort data.txt | uniq -u
4CKMh1JI91bUIZZPXDqGanal4xvAg0JM
```