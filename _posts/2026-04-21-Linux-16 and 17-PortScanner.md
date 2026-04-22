---
title:  "Overthewire-Bandit Level 16 - Port Scanner"
date:   2026-04-21 11:00:00 +0000
categories: [Linux]
tags: [Linux]
---

![image](/assets/img/overthewire.png)

---
Ref: 

- [Overthewire-Bandit16](https://overthewire.org/wargames/bandit/bandit17.html)

---

## Bandit Level 16
Level Goal

The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. 

First find out which of these ports have a server listening on them. Then find out which of those speak SSL/TLS and which don’t. 

There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

Helpful note: Getting “DONE”, “RENEGOTIATING” or “KEYUPDATE”? Read the “CONNECTED COMMANDS” section in the manpage.

Commands you may need to solve this level
ssh, telnet, nc, ncat, socat, openssl, s_client, nmap, netstat, ss


Helpful Reading Material
- [Port scanner on Wikipedia](https://en.wikipedia.org/wiki/Port_scanner)


## SSH
```
ssh bandit16@bandit.labs.overthewire.org -p 2220
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
```

# Nmap
```
nmap -p 31000-32000 -sV localhost
```
Output
```
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-04-21 20:58 UTC
Stats: 0:01:02 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 80.00% done; ETC: 20:59 (0:00:16 remaining)
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00011s latency).
Not shown: 996 closed tcp ports (conn-refused)
PORT      STATE SERVICE     VERSION
31046/tcp open  echo
31518/tcp open  ssl/echo
31691/tcp open  echo
31790/tcp open  ssl/unknown
31960/tcp open  echo
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port31790-TCP:V=7.94SVN%T=SSL%I=7%D=4/21%Time=69E7E4F9%P=x86_64-pc-linu
SF:x-gnu%r(GenericLines,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x2
SF:0current\x20password\.\n")%r(GetRequest,32,"Wrong!\x20Please\x20enter\x
SF:20the\x20correct\x20current\x20password\.\n")%r(HTTPOptions,32,"Wrong!\
SF:x20Please\x20enter\x20the\x20correct\x20current\x20password\.\n")%r(RTS
SF:PRequest,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x20current\x20
SF:password\.\n")%r(Help,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x
SF:20current\x20password\.\n")%r(FourOhFourRequest,32,"Wrong!\x20Please\x2
SF:0enter\x20the\x20correct\x20current\x20password\.\n")%r(LPDString,32,"W
SF:rong!\x20Please\x20enter\x20the\x20correct\x20current\x20password\.\n")
SF:%r(SIPOptions,32,"Wrong!\x20Please\x20enter\x20the\x20correct\x20curren
SF:t\x20password\.\n");

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 137.62 seconds
```

# OpenSSL



nmap tells us that five ports are open. 
Only Port 31518 and 31790 using SSL. 

- Port 31518 runs only the echo service. 
- Port 31790 runs an unknown service.

Ref:[openssl-s_client](https://docs.openssl.org/master/man1/openssl-s_client/) is a command to Send a key update message to the server (TLSv1.3 only).


```
openssl s_client -ign_eof -connect localhost:31790
```
Paste the password
```
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
```

Output
```
CONNECTED(00000003)
Can't use SSL_get_servername
depth=0 CN = SnakeOil
verify error:num=18:self-signed certificate
verify return:1
depth=0 CN = SnakeOil
verify return:1
---
Certificate chain
 0 s:CN = SnakeOil
   i:CN = SnakeOil
   a:PKEY: rsaEncryption, 4096 (bit); sigalg: RSA-SHA256
   v:NotBefore: Jun 10 03:59:50 2024 GMT; NotAfter: Jun  8 03:59:50 2034 GMT
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIFBzCCAu+gAwIBAgIUBLz7DBxA0IfojaL/WaJzE6Sbz7cwDQYJKoZIhvcNAQEL
BQAwEzERMA8GA1UEAwwIU25ha2VPaWwwHhcNMjQwNjEwMDM1OTUwWhcNMzQwNjA4
MDM1OTUwWjATMREwDwYDVQQDDAhTbmFrZU9pbDCCAiIwDQYJKoZIhvcNAQEBBQAD
ggIPADCCAgoCggIBANI+P5QXm9Bj21FIPsQqbqZRb5XmSZZJYaam7EIJ16Fxedf+
jXAv4d/FVqiEM4BuSNsNMeBMx2Gq0lAfN33h+RMTjRoMb8yBsZsC063MLfXCk4p+
09gtGP7BS6Iy5XdmfY/fPHvA3JDEScdlDDmd6Lsbdwhv93Q8M6POVO9sv4HuS4t/
jEjr+NhE+Bjr/wDbyg7GL71BP1WPZpQnRE4OzoSrt5+bZVLvODWUFwinB0fLaGRk
GmI0r5EUOUd7HpYyoIQbiNlePGfPpHRKnmdXTTEZEoxeWWAaM1VhPGqfrB/Pnca+
vAJX7iBOb3kHinmfVOScsG/YAUR94wSELeY+UlEWJaELVUntrJ5HeRDiTChiVQ++
wnnjNbepaW6shopybUF3XXfhIb4NvwLWpvoKFXVtcVjlOujF0snVvpE+MRT0wacy
tHtjZs7Ao7GYxDz6H8AdBLKJW67uQon37a4MI260ADFMS+2vEAbNSFP+f6ii5mrB
18cY64ZaF6oU8bjGK7BArDx56bRc3WFyuBIGWAFHEuB948BcshXY7baf5jjzPmgz
mq1zdRthQB31MOM2ii6vuTkheAvKfFf+llH4M9SnES4NSF2hj9NnHga9V08wfhYc
x0W6qu+S8HUdVF+V23yTvUNgz4Q+UoGs4sHSDEsIBFqNvInnpUmtNgcR2L5PAgMB
AAGjUzBRMB0GA1UdDgQWBBTPo8kfze4P9EgxNuyk7+xDGFtAYzAfBgNVHSMEGDAW
gBTPo8kfze4P9EgxNuyk7+xDGFtAYzAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
DQEBCwUAA4ICAQAKHomtmcGqyiLnhziLe97Mq2+Sul5QgYVwfx/KYOXxv2T8ZmcR
Ae9XFhZT4jsAOUDK1OXx9aZgDGJHJLNEVTe9zWv1ONFfNxEBxQgP7hhmDBWdtj6d
taqEW/Jp06X+08BtnYK9NZsvDg2YRcvOHConeMjwvEL7tQK0m+GVyQfLYg6jnrhx
egH+abucTKxabFcWSE+Vk0uJYMqcbXvB4WNKz9vj4V5Hn7/DN4xIjFko+nREw6Oa
/AUFjNnO/FPjap+d68H1LdzMH3PSs+yjGid+6Zx9FCnt9qZydW13Miqg3nDnODXw
+Z682mQFjVlGPCA5ZOQbyMKY4tNazG2n8qy2famQT3+jF8Lb6a4NGbnpeWnLMkIu
jWLWIkA9MlbdNXuajiPNVyYIK9gdoBzbfaKwoOfSsLxEqlf8rio1GGcEV5Hlz5S2
txwI0xdW9MWeGWoiLbZSbRJH4TIBFFtoBG0LoEJi0C+UPwS8CDngJB4TyrZqEld3
rH87W+Et1t/Nepoc/Eoaux9PFp5VPXP+qwQGmhir/hv7OsgBhrkYuhkjxZ8+1uk7
tUWC/XM0mpLoxsq6vVl3AJaJe1ivdA9xLytsuG4iv02Juc593HXYR8yOpow0Eq2T
U5EyeuFg5RXYwAPi7ykw1PW7zAPL4MlonEVz+QXOSx6eyhimp1VZC11SCg==
-----END CERTIFICATE-----
subject=CN = SnakeOil
issuer=CN = SnakeOil
---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 2103 bytes and written 373 bytes
Verification error: self-signed certificate
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Server public key is 4096 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return code: 18 (self-signed certificate)
---
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: BDA9F1FCF6FBC972B7D2A783B1DC41F230BF7F5836917AE2BEDEF4F368652068
    Session-ID-ctx:
    Resumption PSK: 4D36E39DC9E2B684F845B474749D71867E24CAD4644825D6C73EB97C7945348AB96038FE758EDC8508CD28B097A78AFA
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 300 (seconds)
    TLS session ticket:
    0000 - 21 ce 74 33 d0 14 1d 7b-55 e5 12 bc 30 7b e9 c9   !.t3...{U...0{..
    0010 - 76 ce ed b9 e3 21 2a 69-37 60 ee 76 68 53 43 28   v....!*i7`.vhSC(
    0020 - 5d 94 11 ef a8 e2 e2 d9-9a ea 81 fe f9 58 07 2d   ]............X.-
    0030 - 07 2d c1 d9 47 a6 52 bb-d9 4f 3c 14 75 84 fd 1c   .-..G.R..O<.u...
    0040 - e5 28 88 37 78 05 85 9d-97 c5 ef 4f f4 55 5c fe   .(.7x......O.U\.
    0050 - b6 0c b5 ec 72 19 c3 90-76 65 3a cf 66 47 9e ee   ....r...ve:.fG..
    0060 - fb ce 0d 4c a7 b2 62 0a-7c 36 b8 d0 4d bf 3a 77   ...L..b.|6..M.:w
    0070 - 69 24 b2 2f 78 72 64 fc-69 78 60 9c 66 f6 dc 00   i$./xrd.ix`.f...
    0080 - f5 19 50 04 ba df a3 fb-ca c7 6f 2e c5 c5 75 90   ..P.......o...u.
    0090 - b2 e3 f9 6d 19 57 19 27-91 29 fb c5 f4 83 12 2c   ...m.W.'.).....,
    00a0 - 9c a3 dc 8c 4b e2 09 f6-2c 86 87 b9 1f 86 50 61   ....K...,.....Pa
    00b0 - a6 45 c2 14 6d 8d 1d de-a8 f7 9c 9b c8 4b df 97   .E..m........K..
    00c0 - 9e 64 bd bc 0a 75 14 2c-d9 79 ab 0e a7 bf 25 cb   .d...u.,.y....%.
    00d0 - 2c a5 23 a1 ef 65 a9 3d-0e da a9 a6 72 98 ef 65   ,.#..e.=....r..e

    Start Time: 1776806639
    Timeout   : 7200 (sec)
    Verify return code: 18 (self-signed certificate)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
---
Post-Handshake New Session Ticket arrived:
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
    Session-ID: 28F250543CC428733A224BAFE2098178957FB31012E74DC259EAAB77B6F581EA
    Session-ID-ctx:
    Resumption PSK: E5EF82E51C9273F833FEF08F6E18266A3C6B2641FEBB67123D3D7E090F981F939F4A66364EACE109B428146BF09188E0
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 300 (seconds)
    TLS session ticket:
    0000 - 21 ce 74 33 d0 14 1d 7b-55 e5 12 bc 30 7b e9 c9   !.t3...{U...0{..
    0010 - 1c ed d8 53 d4 19 25 a0-06 fb 9c 66 e6 2f dd 17   ...S..%....f./..
    0020 - 78 6d 5d 6a f8 ce 32 aa-60 3e 60 b4 67 43 9f e8   xm]j..2.`>`.gC..
    0030 - 11 34 55 8c 83 5d 0b c1-a8 45 54 ff 21 b3 f7 95   .4U..]...ET.!...
    0040 - 78 5b 89 d4 e5 85 59 2e-20 64 35 71 5c dc 08 52   x[....Y. d5q\..R
    0050 - fd 41 50 86 e2 17 82 63-fe fc a4 66 3f b5 35 7a   .AP....c...f?.5z
    0060 - e2 5e 35 27 f7 74 56 e3-d7 30 e5 69 65 2d 99 70   .^5'.tV..0.ie-.p
    0070 - 7d 1f 55 2f 67 04 4d 87-bb f3 6a d1 6d 15 86 24   }.U/g.M...j.m..$
    0080 - ea 23 92 43 40 82 cd c0-82 56 2e 6b fb a4 21 0f   .#.C@....V.k..!.
    0090 - 4b 50 fb 01 4a 22 c9 13-35 90 41 7d 76 6b 18 4a   KP..J"..5.A}vk.J
    00a0 - 42 ff 9e fd fb c2 0c 86-df 0d 69 31 ce 0c db 51   B.........i1...Q
    00b0 - 5c 32 c3 57 45 3a 89 70-b0 87 06 cf f7 61 64 14   \2.WE:.p.....ad.
    00c0 - 24 c9 50 f3 75 8a 40 26-b3 c8 ff dd a4 32 e6 32   $.P.u.@&.....2.2
    00d0 - 48 3e 87 1f e0 1b b9 92-83 fa c2 81 5d bc 2e 0e   H>..........]...

    Start Time: 1776806639
    Timeout   : 7200 (sec)
    Verify return code: 18 (self-signed certificate)
    Extended master secret: no
    Max Early Data: 0
---
read R BLOCK
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

closed
```

We created a private SSH key file,‘sshkey17.private’, to put the key into and like in Level 14, we need to make sure that the file only has permissions for the user.


# Copy and paste the Key 
Create a file called key17
```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----
```

```
nano key17
```






# Note

UserNameA

All the prep work is done.  
Now comes the **one command** that matters.

***

## ✅ Final step: SSH into bandit17

From the **same PowerShell window** (`C:\Users\ayeung\Documents`), run:

```powershell
ssh bandit17@bandit.labs.overthewire.org -p 2220 -i bandit17_key
```

***

## ✅ What should happen

You should **NOT** see:

*   `Load key ... invalid format`
*   a password prompt

You **SHOULD** see your prompt change to:

```text
bandit17@bandit:~$
```

🎉 **Bandit Level 16 complete**

***

## ✅ Verify success

Once logged in:

```bash
whoami
```

Output:

```text
bandit17
```

Get the next password:

```bash
cat passwords.txt
```

That password is for **Bandit 18**.

***

## 🧠 Why this finally works

At this point, everything is correct:

| Item        | Status               |
| ----------- | -------------------- |
| Key content | ✅ correct            |
| Encoding    | ✅ ASCII (SSH‑safe)   |
| Permissions | ✅ Windows‑restricted |
| File name   | ✅ no `.txt`          |
| SSH command | ✅ correct            |

The earlier failures were **100% Windows encoding and file‑locking issues**, not Bandit logic.

***

## ✅ One‑line recap (for the future)

> **On Windows: SSH keys must be plain ASCII/UTF‑8‑no‑BOM and have restricted ACLs, or OpenSSH will reject them silently.**

***

When you’re ready, I can:

*   Walk you through **Bandit 17 → 18** (very quick)
*   Summarize **Bandit SSH rules** in one page
*   Show how to avoid this forever using **WSL**

Run the SSH command above and tell me what you see 👊





# Note
```
bandit17@bandit:~$ whoami
bandit17
bandit17@bandit:~$ ls -las
total 36
4 drwxr-xr-x   3 root     root     4096 Apr  3 15:17 .
4 drwxr-xr-x 150 root     root     4096 Apr  3 15:20 ..
4 -rw-r-----   1 bandit17 bandit17   33 Apr  3 15:17 .bandit16.password
4 -rw-r--r--   1 root     root      220 Mar 31  2024 .bash_logout
4 -rw-r--r--   1 root     root     3851 Apr  3 15:10 .bashrc
4 -rw-r-----   1 bandit18 bandit17 3300 Apr  3 15:17 passwords.new
4 -rw-r-----   1 bandit18 bandit17 3300 Apr  3 15:17 passwords.old
4 -rw-r--r--   1 root     root      807 Mar 31  2024 .profile
4 drwxr-xr-x   2 root     root     4096 Apr  3 15:17 .ssh
bandit17@bandit:~$ cat .bandit16.password
kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx
bandit17@bandit:~$ diff passwords.old passwords.new
42c42
< KxOU4IzbXM8j8HeAWPAXTd1eC77mp1qV
---
> x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
```




# Bandit 17

Level Goal
There are 2 files in the homedirectory: passwords.old and passwords.new. The password for the next level is in passwords.new and is the only line that has been changed between passwords.old and passwords.new

NOTE: if you have solved this level and see ‘Byebye!’ when trying to log into bandit18, this is related to the next level, bandit19

Commands you may need to solve this level
cat, grep, ls, diff



```
bandit17@bandit:~$ grep -Fxv -f passwords.old passwords.new
```
```
x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
```


Output
```
ssh bandit18@bandit.labs.overthewire.org -p 2220
                         _                     _ _ _
                        | |__   __ _ _ __   __| (_) |_
                        | '_ \ / _` | '_ \ / _` | | __|
                        | |_) | (_| | | | | (_| | | |_
                        |_.__/ \__,_|_| |_|\__,_|_|\__|


                      This is an OverTheWire game server.
            More information on http://www.overthewire.org/wargames

backend: gibson-1
bandit18@bandit.labs.overthewire.org's password:
Permission denied, please try again.
bandit18@bandit.labs.overthewire.org's password:

      ,----..            ,----,          .---.
     /   /   \         ,/   .`|         /. ./|
    /   .     :      ,`   .'  :     .--'.  ' ;
   .   /   ;.  \   ;    ;     /    /__./ \ : |
  .   ;   /  ` ; .'___,/    ,' .--'.  '   \' .
  ;   |  ; \ ; | |    :     | /___/ \ |    ' '
  |   :  | ; | ' ;    |.';  ; ;   \  \;      :
  .   |  ' ' ' : `----'  |  |  \   ;  `      |
  '   ;  \; /  |     '   :  ;   .   \    .\  ;
   \   \  ',  /      |   |  '    \   \   ' \ |
    ;   :    /       '   :  |     :   '  |--"
     \   \ .'        ;   |.'       \   \ ;
  www. `---` ver     '---' he       '---" ire.org


Welcome to OverTheWire!

If you find any problems, please report them to the #wargames channel on
discord or IRC.

--[ Playing the games ]--

  This machine might hold several wargames.
  If you are playing "somegame", then:

    * USERNAMES are somegame0, somegame1, ...
    * Most LEVELS are stored in /somegame/.
    * PASSWORDS for each level are stored in /etc/somegame_pass/.

  Write-access to homedirectories is disabled. It is advised to create a
  working directory with a hard-to-guess name in /tmp/.  You can use the
  command "mktemp -d" in order to generate a random and hard to guess
  directory in /tmp/.  Read-access to both /tmp/ is disabled and to /proc
  restricted so that users cannot snoop on eachother. Files and directories
  with easily guessable or short names will be periodically deleted! The /tmp
  directory is regularly wiped.
  Please play nice:

    * don't leave orphan processes running
    * don't leave exploit-files laying around
    * don't annoy other players
    * don't post passwords or spoilers
    * again, DONT POST SPOILERS!
      This includes writeups of your solution on your blog or website!

--[ Tips ]--

  This machine has a 64bit processor and many security-features enabled
  by default, although ASLR has been switched off.  The following
  compiler flags might be interesting:

    -m32                    compile for 32bit
    -fno-stack-protector    disable ProPolice
    -Wl,-z,norelro          disable relro

  In addition, the execstack tool can be used to flag the stack as
  executable on ELF binaries.

  Finally, network-access is limited for most levels by a local
  firewall.

--[ Tools ]--

 For your convenience we have installed a few useful tools which you can find
 in the following locations:

    * gef (https://github.com/hugsy/gef) in /opt/gef/
    * pwndbg (https://github.com/pwndbg/pwndbg) in /opt/pwndbg/
    * gdbinit (https://github.com/gdbinit/Gdbinit) in /opt/gdbinit/
    * pwntools (https://github.com/Gallopsled/pwntools)
    * radare2 (http://www.radare.org/)

--[ More information ]--

  For more information regarding individual wargames, visit
  http://www.overthewire.org/wargames/

  For support, questions or comments, contact us on discord or IRC.

  Enjoy your stay!

Byebye !
Connection to bandit.labs.overthewire.org closed.
```