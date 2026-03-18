---
title:  "Overthewire-Bandit Level 1 -> 2"
date:   2026-03-18 14:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit1-2](https://overthewire.org/wargames/bandit/bandit2.html)

---

## Bandit Level 1 → Level 2

Level Goal
The password for the next level is stored in a file called - located in the home directory

Commands you may need to solve this level
ls , cd , cat , file , du , find

#
Helpful Reading Material

- [Google Search for “dashed filename”](https://www.google.com/search?q=dashed+filename)

- [Advanced Bash-scripting Guide - Chapter 3 - Special Characters](https://linux.die.net/abs-guide/special-chars.html)

#
Example:
```
bandit0@bandit:/home/bandit1$ 
du -ah /home/bandit1
```
Output: 
```
4.0K    /home/bandit1/.bash_logout
4.0K    /home/bandit1/.bashrc
4.0K    /home/bandit1/.profile
4.0K    /home/bandit1/-
20K     /home/bandit1
```


```
bandit0@bandit:/home/bandit1$ 

find /home/bandit1 -name "-" -exec cat {} \;
```
Output:
```
cat: /home/bandit1/-: Permission denied
```