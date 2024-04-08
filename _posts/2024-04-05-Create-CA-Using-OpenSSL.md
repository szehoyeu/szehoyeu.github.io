---
title:  "Create Certificate using OpenSSL for Tomcat"
date:   2024-04-05 19:00:00 +0000
categories: [SSL]
tags: [SSL]
---


---
Ref: 

- [Link](https://arminreiter.com/2022/01/create-your-own-certificate-authority-ca-using-openssl/)

- [Microsoft-Learn](https://learn.microsoft.com/en-us/system-center/scom/obtain-certificate-windows-server-and-operations-manager?view=sc-om-2022&tabs=Standal%2CEnter)

- [Apache Tomcat 10](https://tomcat.apache.org/tomcat-10.1-doc/ssl-howto.html)

- [Tomcat TLS Key and Cert Generation - 14:30](https://www.youtube.com/watch?v=I6TbMqH9WFg)

- [Link - 4:09](https://www.youtube.com/watch?v=I6TbMqH9WFg&t=252s)


---

### Step 1 - Download and install OpenSSL
---
[Download](https://slproweb.com/products/Win32OpenSSL.html)

![img](/assets/img/Openssl01.png)

### Step 2 - Add System environment variable 

![img](/assets/img/Openssl02.png)

### Step 3 - Internal CA

- Create dir for Certs

```
mkdir Server-CA
```
- Create dir for Certs
- Create dir for private key
- Create dir for CSR - Cert Signing Request
- Create dir for Keystores
```
mkdir Server-CA\newcerts 
mkdir Server-CA\private
mkdir Server-CA\csr
mkdir Server-CA\keystores
```

- Create a file to keep track of serial number
```
echo 1000 > Server-CA\serial
```
- Create index.txt as Certificate database
```
echo 2>Server-CA\index.txt
```
- Create Certificate Authority
```
openssl req -config openssl.cnf -new -x509 -days 3650 -extensions v3_ca -keyout Server-CA\private\cakey.pem -out Server-CA\cacert.pem
```
ref: 
![img](/assets/img/Openssl03.png)



- Create a Private Key and csr
```
openssl req -config openssl.cf -new -nodes -out Server-CA\csr\localhost-req.pem -keyout Server-CA\private\localhost-key.pem
```

- Sign as CA
```
openssl ca -config openssl.cnf -days 730 -out Server-CA\newcerts\localhost-cert.pem -infiles Server-CA\csr\localhost-req.pem
```
 
- Install the Cert and Edit Server.xml

Copy and paste the Certs to C:\Program Files\Apache Software Foundation\Tomcat 10.1\conf

![img](/assets/img/Openssl04.png)

- cacert.pem
- localhost-cert.pem
- localhost-key.pem


- Edit server.xml file
![img](/assets/img/Openssl05.png)

- Test 
![img](/assets/img/Openssl06.png)



---

15:36
![img](/assets/img/Openssl08.png)


```
openssl ca -policy policy_anything -config openssl.cnf -days 730 -out Server-CA\newcerts\localhost2-cert.pem -infiles Server-CA\csr\locatlhost2-req.pem
```
![img](/assets/img/Openssl07.png)

18:31
```
keytool -import -alias ca -keystore Server-CA\keystores\locatlhost2.jks -trustcacerts -file Server-CA\cacert.pem