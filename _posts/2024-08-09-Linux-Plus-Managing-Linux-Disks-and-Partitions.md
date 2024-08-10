---
title:  "Linux Plus-Managing Linux Disks and Partitions"
date:   2024-08-09 18:27:42 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/linux.png) 
---


## Overview
Hardware
- List hardware devices
- Create disk files to act as storage
- List available and used storage

Partitions
- Create and read partition tables
- Encrypt partitions

### Listing Hardward and Storage
![img](/assets/img/linuxP-Disks01.png)

![img](/assets/img/linuxP-Disks02.png)
- -S - based on size
- -r - Display reverse

### Alma Linux 8.5
Discover Hardware
- Block device files
- Available disk space
- More options to the ls command

lsblk
![img](/assets/img/linuxP-Disks03.png)

- sda - first disk
- sda1 - SWAP - mounting point
- sda2 - / - root filesystem

lspci
![img](/assets/img/linuxP-Disks04.png)

lscpu
![img](/assets/img/linuxP-Disks05.png)

lsusb
![img](/assets/img/linuxP-Disks06.png)

![img](/assets/img/linuxP-Disks07.png)

To find the disk space,
use df
- -h - human readable
```
df -h /
```
![img](/assets/img/linuxP-Disks08.png)

To find the size of the directory
```
df -h /etc/services
680K    /etc/services
```

To find and display the large file size 
- S - size of the file
- r - listed in reverse order
```
ls -lhSr /etc
```
![img](/assets/img/linuxP-Disks09.png)


### Understanding Disk Files
![img](/assets/img/linuxP-Disks10.png)

### Working with ISO Files
- Download small ISO and mount it.
- List devices with lsblk and losetup
```
yum list wget
yum provides /usr/bin/wget
sudo yum install -y wget
wget https://download.virtualbox.org/virtualbox/4.0.0/VBoxGuestAdditions_4.0.0.iso
sudo mount VBoxGuestAdditions_4.0.0.iso /mnt
ls /mnt ; lsblk ; sudo losetup
sudo unmount /mnt
```

### Creating Raq Disk Files
Using either ```dd``` or ```fallocate```, we can create disk file. The latter being more efficient as it does not copy the data just allocating space.

- Create disk file with ```dd```
- Create disk file with ```fallocate```

```
dd if=/dev/zero of=disk1.img bs=1M count=1000
fallocate -l 1G disk2.img
```
![img](/assets/img/linuxP-Disks11.png)



## Linking Devices to Files
- Using losetup
![img](/assets/img/linuxP-Disks12.png)

## Understanding Disk Partitions
![img](/assets/img/linuxP-Disks13.png)

## Partitioning Disks
- Using the ```fdisk``` command
- Using the ```parted``` command
- Using ```partprobe``` to read partition tables

![img](/assets/img/linuxP-Disks14.png)


## Encrypting Disks and Partitions Using LUKS


![img](/assets/img/linuxP-Disks15.png)

- lsblk - list out the block devices
- dd, fallocate - create raw files and 
- losetup - link them to loop devices with losetup
- parted or fdisk - create partitiions
- partprobe - to reread the partition table
- cryptsetup - encrypting a partition or encrypting a disk will encrypting the underlying structure, so any filesystem that is laid upon it is going to be encrypted.