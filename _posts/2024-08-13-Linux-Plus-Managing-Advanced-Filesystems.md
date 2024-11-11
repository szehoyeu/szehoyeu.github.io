---
title:  "Linux Plus-Managing Advanced Linux Filesystems"
date:   2024-08-13 18:27:42 +0000
categories: [Linux]
tags: [Linux]
---
Ref: 

- [Linux loop devices](https://blog.devops.dev/linux-loop-devices-451002bf69d9)

---
![image](/assets/img/linux.png) 
---

## Overview
Advanced disks storage and filesystems
LVM - Logical Volume Management
- Dynamic storage
RAID
- Create software RAID
Networks
- iSCSI - Network-based block storage
- NFS - Sharing out UNIX file systems
- CIFS - Sharing out Windows file systems

![image](/assets/img/linuxP-AdvFileSystem01.png) 

### Using Flags with parted
Working on the Alma Linux 8.5
Create Disks Files
- Partitioning with flags (Extra information)

![image](/assets/img/linuxP-AdvFileSystem02.png) 

### Working with LVMs
Working on the Alma Linux 8.5
- Block device files
- Createing LVMs
- Extending LVMs

![image](/assets/img/linuxP-AdvFileSystem03.png) 


### Understanding Software RAID
- ```R```edundant ```A```rray of ```I```nexpersive ```D```isks (RAID)
- Used to create fault tolerant disk arrays
- Traditional Linux Software RAID creates ```dev mapper``` virtual device file
- RAID is integrated into btrfs

### RAID Levels
- Linear: Partitionis/disk not the same size, volume is expanded across all disks in array. Spare disk is not supported

- RAID 0: Similar to above but the disks or partitions are of similar size
- RAID 1: Mirror data between devices of similar size
1GB volume, will actually taking 2GB of disk space.
- RAID 4/5/6: Three or more devices (4 with RAID 6), data is striped with parity 
How RAID is calculated using parity data that is stored on the additional disk.


Supported parted flags are:

![image](/assets/img/linuxP-AdvFileSystem04.png)

### Working with Mirror Volume
- Create RAID partitions
- Install software raid
- Create mirrored volume

![image](/assets/img/linuxP-AdvFileSystem05.png)

### Mirrored Volumes Using btrfs

RAID Mirror with btrfs
![image](/assets/img/linuxP-AdvFileSystem06.png)

Working on openSUSE
Create a raid volume with btrfs

![image](/assets/img/linuxP-AdvFileSystem07.png)

### Understanding NFS

![image](/assets/img/linuxP-AdvFileSystem08.png)


### Working with NFSv4
Working on
- Alma Linux 8.5 as NFS server
- Ubuntu 20.04 as NFS client

NFS
- Create exports (shares) on Alma
