---
title:  "THM: File Inclusion"
date:   2024-02-20 18:00:00 +0000
categories: [WebHacking]
tags: [WebHacking]
---

![image](/assets/img/fileInclusion.png)

---
Ref: 

- [THM File Inclusion:](https://tryhackme.com/room/fileinc)

- [FFUF tool and wordlist - Github](https://github.com/ffuf/ffuf)

- [Crack Station Database](https://crackstation.net/)

- [Decode from Base64 format](https://www.base64decode.org/)

- [Link](https://www.youtube.com/watch?v=Dd_IjbWT0Os)

---
Task 1  Introduction
---
### What is File inclusion?

This room aims to equip you with the essential knowledge to exploit file inclusion vulnerabilities, including ```Local File Inclusion (LFI)```, ```Remote File Inclusion (RFI)```, and ```directory traversal```. Also, we will discuss the risk of these vulnerabilities if they're found and the required remediation. We provide some practical examples of each vulnerability as well as hands-on challenges.

In some scenarios, web applications are written to request access to files on a given system, including images, static text, and so on via parameters. Parameters are ```query parameter strings attached to the URL``` that could be used to retrieve data or perform actions based on user input. The following diagram breaks down the essential parts of a URL.

![image](/assets/img/fileInclusion01.png)

For example, 

parameters are used with Google searching, where GET requests pass user input into the search engine. https://www.google.com/search?q=TryHackMe. If you are not familiar with the topic, you can view the How The Web Works module to understand the concept.  
Let's discuss a scenario where a user requests to access files from a webserver. First, the user sends an HTTP request to the webserver that includes a file to display. 

For example, 

if a user wants to access and display their CV within the web application, the request may look as follows, http://webapp.thm/get.php?file=userCV.pdf, where the file is the parameter and the userCV.pdf, is the required file to access.

![image](/assets/img/fileInclusion02.png)
