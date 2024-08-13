---
title:  "Linux Plus-Managing Linux Filesystem"
date:   2024-08-11 18:27:42 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/linux.png) 
---

## Overview
Filesystems
- Create and manage filesystems
    - ext4
    - xfs
    - btrfs
- Mount filesystems

### 

1. Gain root privileges
2. Using luksOpen to decrypt the device
3. Searching "mount count"

![image](/assets/img/linuxP-FileSystem01.png) 


1. Format loop1p2 partition with xfs
2. Defrag a filesystem while the system is online
...


### Managing EXT4 Filesystemms
- The filesystem already exists
- We can read the filesystem settings
- Configure the volume label

![image](/assets/img/linuxP-FileSystem02.png) 

### Managing XFS Filesystems
- Add a filesystem to the second partition
- Using the xfs toolset to read the filesystems settings
- Demonstrating the dynamic nature of XFS to defrag the existing root filesystem

![image](/assets/img/linuxP-FileSystem03.png)

### Managing btrfs on openSUSE
- Install btrfs
- Add new disk files
- Add btrfs filesystem to one disk and mount it
- Checking the filesystem, and view its size
- Add another disk and check the filesystem grew while still online

![image](/assets/img/linuxP-FileSystem04.png)

### Working with Mount and Unmount
- Using the mount command 
- Using the umount command
- Checking the UUID using blkid
- Persisting mounts in the /etc/fstab

![image](/assets/img/linuxP-FileSystem05.png)

### Summary 
1. Check the size of the file (df) or directory (du)

```
df, du
```
2. mkfs - create a filesytem, such as xfs, ext4 and btrfs (option -t - to specify the type of filesystem)
```
mkfs -t xfs, ext4, btrfs
```
3. 
- mount / umount
4. To persist any of the filesystem into the mount point edit /etc/fstab and use the UUID of the filesystem
```
vi /etc/fstab
```
5. Gain information of the filesystem
```
tune2fs, dumpe2fs
```
6. To defragment the filesystem
```
xfs_admin, xfs_fsr, xfs_info
```
7. For Advanced filesystems settings

```
 btrfs #subcommand#
```






