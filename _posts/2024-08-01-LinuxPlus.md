---
title:  "Linux Plus"
date:   2024-08-01 18:27:42 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/linux.png) 
---
### Managing Linux Files
```
tty
ls -l

ls -l $(tty)
```
## Working with Files and Directories
- FHS (File Hierarchy Standard)
- Changing Directories
- Listing Directory and File Metadata
- Deleting Directories

---

Install Tree 
```
sudo apt-get install tree
```
```
tree -L 1 /
```
Output
```
eung@PB-3157:/$ tree -L 1 /
/
├── bin -> usr/bin
├── boot
├── dev
├── etc
├── home
├── init
├── lib -> usr/lib
├── lib32 -> usr/lib32
├── lib64 -> usr/lib64
├── libx32 -> usr/libx32
├── lost+found
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin -> usr/sbin
├── snap
├── srv
├── sys
├── tmp
├── usr
└── var

23 directories, 1 file
```

```
ls - ld /dev
```
Output
```
 ls -ld /dev
drwxr-xr-x 16 root root 3560 Jul 30 13:20 /dev
```

Go back to the previous directory
```
cd -
```
or
```
echo $OLDPWD
```

Create a Directory
```
mkdir test
ls -ld test
```
Output
```
drwxr-xr-x 2 user1 user1 4096 Jul 31 21:51 test
```

List of parent directory
```
mkdir -p test/d1/d2
tree test
```
Output
```
tree test
test
└── d1
    └── d2

2 directories, 0 files
```
Create a list of directories
```
mkdir test/d{10..19}
tree test
```
Output
```
test
├── d1
│   └── d2
├── d10
├── d11
├── d12
├── d13
├── d14
├── d15
├── d16
├── d17
├── d18
└── d19

12 directories, 0 files
```
Delete all the directories within and include ```test``` directory
```
rm -rf test
```
Output
```
tree test
test  [error opening dir]

0 directories, 0 files
```

## Creating a new file
- The touch command is often used to create new empty files but there is more to it
- Changes both acess and modified times, change will always update

```
touch file1
```
- Changes access time
```
touch -a file1
```
- Changes modified time
```
-touch -m file1
```

## Looking into the file details - Timestamp

Field 
- Access - Last read of the file 
- Modify - Data last modified
- Change - Metadata last changed


```
stat file1
stat -c %x file1 #Access
stat -c %x file1 #Modify
stat -c %c file1 #Change
```
## Archive Mode (-a)

To maintain metadata when copying files, we can use the option -a or --archive, ownership, permissions and time stamps are all copied with the file.

-a is equals to -dR --preserve=all

Copy a file
```
cp file1 file2
```
To copy and maintain the metadata 
```
cp -a file1 file3
```

## Understanding File Metadata

- Sorting files my last modified time
- Using stat
- Using touch
- Preserving metadata

```
ls -ltr
```
- -r - reverse sorting

- File filename - 
```
file profile.d
```

- stat . - It will bring up the last argument.

- stat filename - Show detail of the file 

```
touch file1
stat file1
```
Output
```
  File: file1
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 820h/2080d      Inode: 5636        Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/  ayeung)   Gid: ( 1000/  ayeung)
Access: 2024-08-07 14:19:27.133723941 -0700
Modify: 2024-08-07 14:19:27.133723941 -0700
Change: 2024-08-07 14:19:27.133723941 -0700
 Birth: 2024-08-07 14:19:27.133723941 -0700
```

IF you use the ```cat file1```, the ```Access``` (Time) will be changed.
```
/etc$ stat profile.d
  File: profile.d
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 820h/2080d      Inode: 635         Links: 2
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-08-06 12:25:28.211466106 -0700
Modify: 2024-08-07 10:39:34.476028582 -0700
Change: 2024-08-07 10:39:34.476028582 -0700
 Birth: 2024-08-07 14:19:27.133723941 -0700
```

The ```Modify``` and ```Change``` time will be changed once using echo command as follow
```
echo hello >> file1
stat file1
```

Only the ```Change``` time will upated after using ```chmod 770 file1```
```
chmod 770 file1
stat file1
```
Output
```
  File: file1
  Size: 6               Blocks: 8          IO Block: 4096   regular file
Device: 820h/2080d      Inode: 5636        Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/  ayeung)   Gid: ( 1000/  ayeung)
Access: 2024-08-07 14:19:27.133723941 -0700
Modify: 2024-08-07 14:20:07.433701948 -0700
Change: 2024-08-07 14:20:35.433701948 -0700
 Birth: 2024-08-07 14:19:27.133723941 -0700
```

Using ```stat -c``` individual elements of the metadata,

%x - option - is the file was last read
%y - option - is the last modified time
%z - option - is the last change time
```
stat -c %x file1
```

Remember if we use the ```cp``` copy command, the metadata of the copied file (file2) will not be the same as the original file, file1.

```
stat file1
```



```
cp file1 file2
stat file2
```



Using ```mv``` command (rename or move), only will change the ```Change``` of the new file 

In this case, file1 renamed as file4, only the ```Change``` time is updated
```
mv file1 file4
```


## Using Editor in Linux

When working at the Linux CLI, people will soon settle on their editor. The editor nano has a short learning curve while vim is more powerful, the learning curve is longer.

Install vim
```
sudo dnf install -y vim-enhanced nano rsync git-core
```

Install nano
```
sudo nano /etc/ssh/ssjd_config
```

Install vim
```
sudo vim /etc/ssh/sshd_config
```

## Using the Stream Editor

To script or automate edits, always the goal in DevOps, we can look at sed, the Linux stream editor

The Ubuntu Vagrant system does not endable password-based SSH authentication by default

- E - enhanced regular expression that allows to use the parentheses
- i - means inplace edit
- s - within the string that we pass through to sed is then saying substitute, and the text that we want to look for to substitute is, then (PasswordAuthentication)no. 
- The parentheses allow me to use groups, so I can then reference the replacement text being the first group, ie. PasswordAuthentication, and configuring it to be yes

```
sudo sshd -T | grep passwordauthentication
sudo sed -Ei 's/(PasswordAuthentication) no/\1 yes/' /etcssh/sshd_config
```

Enable password
```
sudo systemctl restart sshd
```


For more commands using VIM editor, use VIM Tutor
```
vimtutor
```

To use Ubuntu SSH server using password based authentication, we need to enable it

```
sudo sshd -T | grep passwordauthentication
```
```
sudo grep -i PasswordAuthentication /etc/ssh/ssh_config
```
Output
```
PasswordAuthentication yes
```

If Password Authentication was set to ```No```, use the following commands to enable password authentication 
```
sudo sed -Ei 's/PasswordAuthentication no/PassowrdAuthentication yes/'
```
or using regular expression to enable password authentication.
```
sudo sed -Ei 's/(PasswordAuthentication) no/\1 yes/' /etc/ssh/sshd_config
```

Once the password authentication enabled, we need to restart the systemctl. And we can double check if password authentication has been enabled.
```
sudo systemctl restart sshd
sudo sshd -T | grep passwordauthentication
```


## Remote Copy

Whilst ```scp``` is ok to copy single file to remote systems, ```rsync``` is better equipped to copy complete directory structures and keep them up to data

```
sudo useradd -m user1
sudo passwd user1
scp file1 user1@192.168.33.13

```
Look for all HTML files and copy those int our docs directory.
```
mkdir docs
find /usr/share/doc -name '*.html'  -exec cp {} docs/ \;
rsync -ave ssh docs user1@192.168.33.13:
```


## Creating SSH Git Repositories

Working in DevOps, you will certainly come across the VCS (Version Control System) git, allow colaboration in development. Rather than using a hosting system such as GitHub or GitLabs we can creat our own SSH Host. 
Ubuntu
```
su - user1 && mkdir project1 && cd project1
git init --bare
```
Alma
```
git clone user1@193.168.33.13:/home/user1project1
cd prject1 && vim my.sh && chmod 755 my.sh
git add .
git config --global user.email "your@example.com"
git config --global user.name "Your name"
git commit -m "initial commit"
git push origin master
```

Opensuse
```
sudo zypper in -y git-core
git clone user1@192.168.33.13:/home/user1/project1
```

## remote copy
```
sudo useradd -m user1
sudo passwd user1
```
```
scp file1 users1@192.168.33.13:
```

```
sudo rsync
find /usr/share/doc -name '*.html' -exec cp {} docs/ \;
ls docs
rsync -ave ssh docs user1@192.168.33.13:
```




