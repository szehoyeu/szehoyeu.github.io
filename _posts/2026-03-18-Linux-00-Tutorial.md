---
title:  "Overthewire-Bandit Level 0 -> 1"
date:   2026-03-18 14:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit0-1](https://overthewire.org/bandit/bandit1.html)

---

Bandit Level 0 → Level 1

Level Goal
The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

Commands you may need to solve this level
ls , cd , cat , file , du , find


du  - disk usage
Using du to Check File Sizes
To see the size of a specific file or directory, use the following syntax:

Check a single file:
du filename.txt — Shows the disk space used by a specific file.

Human-readable format:
du -h filename.txt — Displays size in KB, MB, or GB (e.g., 4.0K instead of just a number).

Check all files in a directory:
du -ah /path/to/directory — The -a (all) flag forces du to list individual files, not just directories.

Summarize a directory:
du -sh /path/to/directory — The -s (summarize) flag shows only the total size of the directory without listing every item inside. 


Common du Flags

Flag 	Description
-a  All: Shows sizes for files as well as directories.

-h	Human-readable: Formats sizes in K, M, and G.

-s	Summarize: Displays only a total for each argument.

-c	Total: Adds a "grand total" line at the bottom.

--max-depth=N	Limits the output to 
 levels deep into subdirectories.

Example:
```
ssh -p 2220 bandit0@bandit.labs.overthewire.org
ls
cat readme
file -f readme
file --help
du 
find 
```

TIP: Create a file for notes and passwords on your local machine!

Passwords for levels are not saved automatically. If you do not save them yourself, you will need to start over from bandit0.

Passwords also occasionally change. It is recommended to take notes on how to solve each challenge. As levels get more challenging, detailed notes are useful to return to where you left off, reference for later problems, or help others after you’ve completed the challenge.