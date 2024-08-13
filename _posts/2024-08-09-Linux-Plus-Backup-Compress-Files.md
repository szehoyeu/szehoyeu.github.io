---
title:  "Linux Plus-Backing Up and Compressing Files"
date:   2024-08-09 18:27:42 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/linux.png) 
---



## Objectives
- File Compression Using Compression Tools
- Archiving Using cpio

### Creating TAR Files
The command tar can be used to create file archives. Althouth, ```T```ape ```Ar```chives, they are more commonly used in standard filesystems. By default, a TAR file is not compressed but may appear to be a slightly small size than the original content. This is due to the more efficient use of blocks in the filesystem and not compression

Find the size of our etc directory
- du - disk utilization
- s - summary
- h - human readable

```
sudo du -sh /etc
22M /etc
```

Create archive with a specify the file to back up
- -c - create
```
sudo tar -cf etc.tar /etc
tar: Removing leading '/' from member names
ls -lh etc.tar
-rw-r--r--. 1 root root 21M Jan 18 10:49 etc.tar
```
Note: 
The most common block size is 4K on Intel based systems. Each new file goes to a new block potentially wasting space

Tar Operations
---
- -c - Create
```
tar -cf file.tar file1 file2
```
- -t - Table of Contents or --verify
```
tar -tf file.tar
```
- -x - Extract
```
tar -xf file.tar
```

More Examples
---
We will investigate the basic tar operations

For summary, look at the disk usage of a directory
```
du -s
```
or 
To overcome permission on files
```
sudo !!
sudo du -sh /etc 
23M /etc
```


```
sudo tar -cf etc.tar /etc
tar: Removing leading `/' from member names
```
To test (verify) the archive,
- -t or --verify
```
sudo tar -tf etc.tar /etc
```

```
ls -lh etc.tar
-rw-r--r--. 1 root root 23M Dec 20 10:08 etc.tar
```
```
ls -l --blick-size=1K etc.tar
-rw-r--r--. 1 root root 22620 Dec 20 10:08 etc.tar
```
```
sudo du -sk /etc
23428  /etc
```

### Various compression utilities exist in Linux
- gzip / gunzip
- bzip2 / bunzip2
- xz -z / xz-d

These can be used independently or with tar

Creating a zipped archive 
- tar -czf(gzip)
- tar -cjf (bdip2)
- tar -cJf (xz)


### Compression is Independent
Even when using compression options,the ```tar``` command is independent of the compression tool that is invoked.

```
tar -cJf etc.tar.xz /etc 2>/dev/null&
[1] 5091
```
- -J - implementing extreme, or xz, compression
- error output - /etc 2>/dev/mull
- & - indicates that backgrounding the task

```
ps

PDI TTY            TIME CMD
2831 pts/0      00:00:00 bash
5091 pts/0      00:00:00 tar
5092 pts/0      00:00:01 xz
5093 pts/0      00:00:00 ps
```  

### Compression operations from the CLI

Compress from 23MB down to 5.2MB
```
ls -lh etc.tar
rw-r--r--. 1 root root 23M Dec 20 10:08 etc.tar

gzip etc.tar
ls -lh etc.tar.gz
-rw-r--r--. 1 vargrant vagrant 5.2M Dec 20 10:08 etc.tar.gz

```

To unzip the compressed tar file, etc.tar.gz
```
gunzip etc.tar.gz
```
To use xz compression,
```
xz etc.tar
```
```
xz -d etc.tar.xz
```

## Timing Command Operation


Back up and compress in the same time,

To find out how long different compression take to compress a file
```
time tar -cf etc.tar /etc 2>/dev/null
real    0m0.081s
user    0m0.005s
sys     0m0.018s
```

```
time tar -czf etc.tar.gz /etc 2>/dev/null
real    0m0.745s
user    0m0.719s
sys     0m0.015s
```

```
time tar -cJf etc.tar.xz /etc 2>/dev/null
real    0m0.630s
user    0m10.390s
sys     0m0.100s
```

Compressed file size difference
```
ls -lh etc.tar*
-rw-r--r--. 1 vagrant vagrant  22M Dec 20 11:55 etc.tar
-rw-rw-r--. 1 vagrant vagrant 5.2M Dec 20 11:55 etc.tar.gz
-rw-rw-r--. 1 vagrant vagrant 3.2M Dec 20 11:55 etc.tar.xz
```

### Automatic Compression Detection and "Less is More"
---

```
tar -tf etc.tar.gz
```
```
file etc.tar.gz
etc.tar.gz: gzip compressed data, last modified: Mon Dec20 11:56:01 2021, from Unix, original size 22978560
```
Display related filename below on compressed archive in pages
```
less etc.tar.gz
```
To display more metadata of the file use -v option
```
tar -tvf etc.tar.xz
```
### Using CPIO
The command cpio, Copy IO, can be used to create archives. Taking the output from a command to send to an archive to be restored later

 Searching a file in a specified directory (shows a full file path)
```
find /usr/share.doc -name '*.html'
/user/share/doc/perl-CPAN-Meta/history/META-spec-1_0.html
/user/share/doc/perl-CPAN-Meta/history/META-spec-1_1.html
/user/share/doc/nano/faq.html
/user/share/doc/nano/nano.html
```
Searching a file in current directory(shows partial file path)
```
cd /usr/share/doc/
find -name '*.html'
./perl-CPAN-Meta/history/META-spec-1_0.html
./perl-CPAN-Meta/history/META-spec-1_1.html
./nano/faq.html
./nano/nano.html
```
Searh a file and output the file to a specific location
```
find -name '*.html' | cpio -o > /tmp/doc.cpio
246 blocks
```
- -o - output to 

To move the back up file 
- -i - import from
- -d - create directory as required
```
mkdir restore
cd restore
cpio -id < ../doc.cpio>
```
![image](/assets/img/linuxP-backupFile01.png) 


## Summary
---
The command tar is used to create a single file archive representing one or more files

The commands gip, bzip2, xz are used to compress files and include options within tar to compress whilst archiving

When compressing with tar options, the compression tool executes independently

Using cpio we take the output of commands to archive and restore using input


