---
title:  "Overthewire-Bandit Level 19 - Setuid Binary"
date:   2026-04-23 11:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit19](https://overthewire.org/wargames/bandit/bandit18.html)

---

## Bandit Level 19
To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. 

The password for this level can be found in the usual place 
```(/etc/bandit_pass)```, 

after you have used the setuid binary.

## Helpful Reading Material

[Setuid Binary Wikipedia](https://en.wikipedia.org/wiki/Setuid)

## Note

setuid - set user identity
setgid - set group identity 

# chmod - Change Mode
[Ref: chmod](https://en.wikipedia.org/wiki/Chmod)
![image-chmod](/assets/img/otw-19-chmod.png)

# SSH
```
ssh bandit19@bandit.labs.overthewire.org -p 2220

cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8
```

# Check the permission

Command
```
ls -las
```
Output
```
bandit19@bandit:~$ ls -las
total 36
 4 drwxr-xr-x   2 root     root      4096 Apr  3 15:17 .
 4 drwxr-xr-x 150 root     root      4096 Apr  3 15:20 ..
16 -rwsr-x---   1 bandit20 bandit19 14888 Apr  3 15:17 bandit20-do
 4 -rw-r--r--   1 root     root       220 Mar 31  2024 .bash_logout
 4 -rw-r--r--   1 root     root      3851 Apr  3 15:10 .bashrc
 4 -rw-r--r--   1 root     root       807 Mar 31  2024 .profile
```

For bandit20-do file,
```
16 -rwsr-x---   1 bandit20 bandit19 14888 Apr  3 15:17 bandit20-do
```
‘- rws  r-x  ---’ 

the owner is badit20 (rws)
the group is bandit19, (r-x)
means the user bandit19 can execute the binary, 
but the binary is executed as user bandit20.


```
bandit19@bandit:~$ ls -las
total 36
 4 drwxr-xr-x   2 root     root      4096 Apr  3 15:17 .
 4 drwxr-xr-x 150 root     root      4096 Apr  3 15:20 ..
16 -rwsr-x---   1 bandit20 bandit19 14888 Apr  3 15:17 bandit20-do
 4 -rw-r--r--   1 root     root       220 Mar 31  2024 .bash_logout
 4 -rw-r--r--   1 root     root      3851 Apr  3 15:10 .bashrc
 4 -rw-r--r--   1 root     root       807 Mar 31  2024 .profile
```


Run a command as another user.
  Example: ./bandit20-do id

```
bandit19@bandit:~$ ./bandit20-do ls /etc/bandit_pass
bandit0   bandit13  bandit18  bandit22  bandit27  bandit31  bandit6
bandit1   bandit14  bandit19  bandit23  bandit28  bandit32  bandit7
bandit10  bandit15  bandit2   bandit24  bandit29  bandit33  bandit8
bandit11  bandit16  bandit20  bandit25  bandit3   bandit4   bandit9
bandit12  bandit17  bandit21  bandit26  bandit30  bandit5

bandit19@bandit:~$ ./bandit20-do cat /etc/bandit_pass/bandit20

0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
```

