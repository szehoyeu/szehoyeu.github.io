---
title:  "Overthewire-Bandit Level 5"
date:   2026-03-20 19:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit5](https://overthewire.org/wargames/bandit/bandit5.html)

---

## Bandit Level 5

Level Goal
The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

Commands you may need to solve this level
ls , cd , cat , file , du , find

#

## SSH
```
ssh bandit5@bandit.labs.overthewire.org -p 2220
4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
```

Level Goal
The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable
1033 bytes in size
not executable
Commands you may need to solve this level
ls , cd , cat , file , du , find

#


Find a file that is:
- Exactly 1033 bytes (≈ 1.0K in human‑readable output)
- Not executable
- A regular file

Commands:
```
find /path/to/folder -type f -size 1033c ! -perm /111
```
```
bandit5@bandit:~/inhere$ find -type f -size 1033c ! -perm /111
./maybehere07/.file2
```
Output:
```
bandit5@bandit:~/inhere$ cat ./maybehere07/.file2
HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
```

#

Find the file size within the folder that is less than 2k
Commands
```
cd inhere
file ./*
find -type f -size -2k
```
Output:
```
bandit5@bandit:~/inhere$ find -type f -size 2

./maybehere07/spaces file3
./maybehere15/.file3
./maybehere12/.file3
./maybehere13/spaces file2
./maybehere08/.file2
./maybehere17/.file1
./maybehere14/spaces file2
./maybehere09/-file2
./maybehere00/.file1
./maybehere05/spaces file1
```



List out all the files within the "inhere" folder and file sizes
```
du --all
```

Find the smallest files recursively 
```
find /path/to/folder -type f -printf "%s %p\n" | sort -n | head -1
```
Output:
```
bandit5@bandit:~/inhere$ find -type f -printf "%s %p\n" | sort -n | head -1
51 ./maybehere15/spaces file2
```

Find the smallest human-readable sizes file 
```
find /path/to/folder -type f -exec ls -lh {} + | sort -k5 -h | head -1
```
Output:
```
bandit5@bandit:~/inhere$ find -type f -exec ls -lh {} + | sort -k5 -h | head -1
```
```
-rw-r----- 1 root bandit5   51 Oct 14 09:26 ./maybehere15/spaces file2
```




```
bandit5@bandit:~/inhere$ cat ./maybehere15/"spaces file2"
Q2z7VXYuHnMJ11Ks9drvakV3s0pADkcPDQl1TlRMMdSzzHJQzX
```


