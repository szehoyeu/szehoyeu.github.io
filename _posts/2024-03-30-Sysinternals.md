---
title:  "THM: Sysinternals"
date:   2024-03-29 19:00:00 +0000
categories: [Windows]
tags: [Windows]
---

![img](/assets/img/si.png)  


---
Ref: 

- [THM: Sysinternals](https://tryhackme.com/r/room/btsysinternalssg)

- [Sysinternals Utilities Index page](https://docs.microsoft.com/en-us/sysinternals/downloads/) 

- [Sysinternals Suite - Download](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)

---

Task 1 - Introduction
---
What are the tools known as Sysinternals?

The Sysinternals tools is a compilation of over 70+ Windows-based tools. Each of the tools falls into one of the following categories:

File and Disk Utilities
Networking Utilities
Process Utilities
Security Utilities
System Information
Miscellaneous
The Sysinternals tools and its website (sysinternals.com) were created by Mark Russinovich in the late '90s, along Bryce Cogswell under the company Wininternals Software.
In 2006, Microsoft acquired Wininternals Software, and Mark Russinovich joined Microsoft. Today he is the CTO of Microsoft Azure. 

Mark Russinovich made headlines when he reported that Sony embedded rootkits into their music CDs back in 2005. This discovery was made known thanks to one of the Sysinternals tools he was testing. You can read more about that here.  

He also discovered in 2006 that Symantec was using rootkit-like technology. You can read more about that here. 

The Sysinternals tools are extremely popular among IT professionals who manage Windows systems. These tools are so popular that even red teamers and adversaries alike use them. Throughout this room, I'll note which tools MITRE has identified to have been used by adversaries. 

The goal of this room is to introduce you to a handful of Sysinternals tools with the hopes that you will expand on this knowledge with your own research and curiosity.

Hopefully, you can add Sysinternals to your toolkit, as many already have. 

If you want to access the virtual machine via Remote Desktop, use the credentials below. 

Machine IP: MACHINE_IP

User: administrator

Password: letmein123!

![img](/assets/img/si01.png)


---

Accept the Certificate when prompted, and you should be logged into the remote system now.

Note: The virtual machine may take up to 3 minutes to load.

---
1. When did Microsoft acquire the Sysinternals tools?

Answer: 2006
---

Task 2 - Install the Sysinternals Suite
---

Time to get our hands dirty with Sysinternals.

The Sysinternals tool(s) can be downloaded and run from the local system, or the tool(s) can be run from the web. 

Regarding local install/run, you can download the entire suite or just the tool(s) you need.

If you wish to download a tool or two but not the entire suite, you can navigate to the Sysinternals Utilities Index page, https://docs.microsoft.com/en-us/sysinternals/downloads/, and download the tool(s). If you know which tool you want to download, then this is fine. The tools are listed in alphabetical order are not separated by categories.

![img](/assets/img/si02.png)

Alternatively, you can use the category links to find and download the tool(s). This route is better since there are so many tools you can focus on all the tools of interest instead of the entire index.

For example, let's say you need tools to inspect Windows processes; then, you can navigate to the Process Utilities page, https://docs.microsoft.com/en-us/sysinternals/downloads/process-utilities/, for all the tools that fall under this category.

![img](/assets/img/si03.png)

Notice that you are conveniently supplied with a brief explanation for each tool. 

Lastly, you can do the same from the Sysinternals Live URL, https://live.sysinternals.com/. This is the same URL to use if you wish to run the tool from the web. We will look at how to accomplish this in the next section.

If you chose to download from this page, it is similar to the Sysinternals Utilities Index page. The tools are listed in alphabetical order and are not separated by categories.

![img](/assets/img/si04.png)

If you wish to download the Sysinternals Suite, you can download the zip file from [here](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite).

The suite has a select number of Sysinternal tools. See below for a rundown of the tools included in the suite.

![img](/assets/img/si05.png)

After you download the zip file, you need to extract the files. After the files are extracted, the extra step, which is by choice, is to add the folder path to the environment variables. By doing so, you can launch the tools via the command line without navigating to the directory the tools reside in. 

Environment Variables can be edited from System Properties.

The System Properties can be launched via the command line by running sysdm.cpl. Click on the Advanced tab. 

![img](/assets/img/si06.png)

Select Path under System Variables and select Edit... then OK.

![img](/assets/img/si07.png)

In the next screen select New and enter the folder path where the Sysinternals Suite was extracted to. Press OK to confirm the changes.

![img](/assets/img/si08.png)

Open a new command prompt (elevated) to confirm that the Sysinternals Suite can be executed from any location.

![img](/assets/img/si09.png)


A local copy of the Sysinternals Suite is located in C:\Tools\Sysint. 

Alternatively, a PowerShell module can download and install all of the Sysinternals tools. 

PowerShell command: Download-SysInternalsTools C:\Tools\Sysint
Now let's look at how to run the Sysinternals tools from the web. 

---

1. What is the last tool listed within the Sysinternals Suite?

Answer: zoomit

---
Task 3 - Using Sysinternals Live
---

Per the Sysinternals website, "Sysinternals Live is a service that enables you to execute Sysinternals tools directly from the Web without hunting for and manually downloading them. Simply enter a tool's Sysinternals Live path into Windows Explorer or a command prompt as 
```
live.sysinternals.com/<toolname> 
```
or
```
\\live.sysinternals.com\tools\<toolname>
```
Let's take a look at how we can do this.

Based on the instructions, to launch Process Monitor from the web the syntax is 
```
\\live.sysinternals.com\tools\procmon.exe.
```

And it fails.

![img](/assets/img/si10.png)

To resolve this issue the WebDAV client must be installed and running on the machine. The WebDAV protocol is what allows a local machine to access a remote machine running a WebDAV share and perform actions in it.

On a Windows 10 client, the WebDAV client is installed but the client is most likely not running. If you try to run a Sysinternals tool it will fail with a message "The network path was not found."


![img](/assets/img/si11.png)

The service needs to be started before attempting to call any Sysinternals tool in this fashion.

![img](/assets/img/si12.png)

Verify it's running before proceeding.

![img](/assets/img/si13.png)

Also, Network Discovery needs to be enabled as well. This setting can be enabled in the Network and Sharing Center.

There are a few ways to open the Network and Sharing Center. Here is a neat command line to launch it.


![img](/assets/img/si14.png)

Click on Change advanced sharing settings and select Turn on network discovery for your current network profile.

The attached VM is a Windows Server 2019 edition. The WebDAV client is not installed by default.
The feature to install on Windows Server is WebDAV Redirector. This feature can be installed via Server Manager or using PowerShell.

To install with PowerShell, Install-WindowsFeature WebDAV-Redirector –Restart. The server needs to reboot for the installation to complete.

After reboot, the installation can be verified with the following PowerShell command, Get-WindowsFeature WebDAV-Redirector | Format-Table –Autosize.

![img](/assets/img/si15.png)

The same process as with a Windows 10 client applies from this point:

Make sure the WebClient service is running
Make sure Network Discovery is enabled
Now with all the necessary components installed and enabled the local machine is ready to run Sysinternals tools from the web. 

There are 2 ways the tools can be run:

Run the tool from the command line (as shown above from the Windows 10 machine)
Create a network drive and run the tool from the mapped drive
Method 1 - Run tool from command line

![img](/assets/img/si16.png)

Method 2 - Run tool from a mapped drive

![img](/assets/img/si17.png)

Note: The asterisk will auto-assign a drive letter. The asterick can be replaced with an actual drive letter instead.

![img](/assets/img/si19.png)

The website is now browsable within the local machine.

![img](/assets/img/si18.png)


Now that we got that out of the way time to start exploring some of these tools.

![img](/assets/img/si20.png)
![img](/assets/img/si21.png)

Now that we got that out of the way time to start exploring some of these tools.

---

1. What service needs to be enabled on the local host to interact with live.sysinternals.com?

Answer: webclient

---
