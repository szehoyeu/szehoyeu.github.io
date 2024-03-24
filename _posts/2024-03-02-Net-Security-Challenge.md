---
title:  "THM: Net Sec Challenge"
date:   2024-03-02 22:00:00 +0000
categories: [Network Security]
tags: [Network Security]
---
---

![image](/assets/img/Net-Sec-Challenge.png)

---
Ref: 

- [THM: Net Sec Challenge](https://tryhackme.com/room/netsecchallenge)

- [Link](https://www.youtube.com/watch?v=_s2oDTnsb7M)
---

Task 1  
---

1. What is the highest port number being open less than 10,000?
![img](/assets/img/Net-Sec-Challenge01.png)
[Nmap-Port Scan-02](https://szehoyeu.github.io/posts/nmap02-Basic-Port-Scans/)
   ```
   nmap -p1-10000 10.10.150.205
   ```
   ```
   Answer : 8080
   ```
---

2. There is an open port outside the common 1000 ports; it is above 10,000. What is it?
```
nmap -p 10000-65535 10.10.43.179
```
```
Answer : 10021
```

---

3. How many ```TCP``` ports are open?
```
Nmap -sT 10.10.150.205
```
![img](/assets/img/Net-Sec-Challenge03.png)
```
Answer format: 6
```
4. What is the flag hidden in the HTTP server header?
![img](/assets/img/Net-Sec-Challenge04.png)
```
Answer : THM{web_server_25352}
```

5. What is the flag hidden in the SSH server header?
   ![img](/assets/img/Net-Sec-Challenge05.png)
   ```
   Answer : THM{946219583339}
   ```
---

6. We have an FTP server listening on a nonstandard port. What is the version of the FTP server?
![img](/assets/img/Net-Sec-Challenge06.png)
```
Answer : *vsftpd 3.0.3
```

7. We learned two usernames using social engineering: eddie and quinn. What is the flag hidden in one of these two account files and accessible via FTP?
```
hydra -l eddie -P /usr/share/wordlists/rockyou.txt ftp://10.10.43.179:10021

Eddie=> jordan
Quinn=> andrea
```
![img](/assets/img/Net-Sec-Challenge07.png)
```
Answer : THM{321452667098}
```

---

8. Browsing to https://10.10.150.205:8080 displays a small challenge that will give you a flag once you solve it. What is the flag?

Answer : THM{f7443f99}


```
nmap -sN 10.10.43.179

```

![img](/assets/img/Net-Sec-Challenge08.png)

---


