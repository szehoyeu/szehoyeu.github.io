---
title:  "THM: Burp Sutie-Basics"
date:   2024-02-24 21:00:00 +0000
categories: [BurpSuite]
tags: [BurpSuite]
---

![image](/assets/img/burp-basics.png)

---
Ref: 

- [THM: Burp Sutie-Basics](https://tryhackme.com/room/burpsuitebasics)

- [Repeater](https://tryhackme.com/room/burpsuiterepeater)

- [Intruder](https://tryhackme.com/room/burpsuiteintruder)

- [Decoder](https://tryhackme.com/room/burpsuiteom)

- [Comparer](https://tryhackme.com/room/burpsuiteom)

- [Sequenxer](https://tryhackme.com/room/burpsuiteom)

- [Link](https://www.youtube.com/)

---

Task 1  Introduction
---

Welcome to Burp Suite Basics!
This particular room aims to understand the basics of the Burp Suite web application security testing framework. Our focus will revolve around the following key aspects:

1. A thorough introduction to Burp Suite.
2. A comprehensive overview of the various tools available within the framework.
3. Detailed guidance on the process of installing Burp Suite on your system.
4. Navigating and configuring Burp Suite.
We will also introduce the core of the Burp Suite framework, which is the Burp Proxy. It is important to note that this room primarily serves as a foundational resource for acquiring knowledge about Burp Suite. Subsequent rooms in the Burp module will adopt a more practical approach. Thus, this room will contain a greater emphasis on theoretical content. If you have not yet utilised Burp Suite, it is recommended to carefully read the provided information and actively engage with the tool. Experimentation is essential for grasping the fundamentals of this framework. Combining the information presented here with hands-on exploration will establish a strong foundation for utilising the framework. This will significantly assist you in future rooms.

Task 2  What is Burp Suite
---


In essence, Burp Suite is a ```Java-based framework``` designed to serve as a comprehensive solution for conducting web application penetration testing. It has become the industry standard tool for hands-on security assessments of web and mobile applications, including those that rely on ```application programming interfaces (APIs)```.

Simply put, Burp Suite captures and enables manipulation of all the HTTP/HTTPS traffic between a browser and a web server. This fundamental capability forms the backbone of the framework. By intercepting requests, users have the flexibility to route them to various components within the Burp Suite framework, which we will explore in upcoming sections. The ability to intercept, view, and modify web requests before they reach the target server or even manipulate responses before they are received by our browser makes Burp Suite an invaluable tool for manual web application testing.

![img](/assets/img/burp-basics01.png)

Burp Suite is available in different editions. For our purposes, we will focus on the Burp Suite Community Edition, which is freely accessible for non-commercial use within legal boundaries. However, it's worth noting that Burp Suite also offers Professional and Enterprise editions, which come with advanced features and require licensing:

1. ```Burp Suite Professional``` is an unrestricted version of Burp Suite Community. It comes with features such as:

- An automated vulnerability scanner.
- A fuzzer/brute-forcer that isn't rate limited.
- Saving projects for future use and report generation.
- A built-in API to allow integration with other tools.
- Unrestricted access to add new extensions for greater functionality.
- Access to the Burp Suite Collaborator (effectively providing a unique request catcher self-hosted or running on a Portswigger-owned server).

In short, Burp Suite Professional is a highly potent tool, making it a preferred choice for professionals in the field.

2. ```Burp Suite Enterprise```, in contrast to the community and professional editions, is primarily utilized for continuous scanning. It features an automated scanner that periodically scans web applications for vulnerabilities, similar to how tools like Nessus perform automated infrastructure scanning. Unlike the other editions, which allow manual attacks from a local machine, Burp Suite Enterprise resides on a server and constantly scans the target web applications for potential vulnerabilities.

![img](/assets/img/burp-basics02.png)

Due to requiring a license for the Professional and Enterprise editions, we will focus on the core feature set provided by the ```Burp Suite Community Edition```.

#### Note: 
The provided demonstrations utilize Burp Suite for Windows. However, the functionality remains consistent with the version installed on the AttackBox.

---

Which edition of Burp Suite runs on a server and provides constant scanning for target web apps?
```
Burp Suite Enterprise
```
Burp Suite is frequently used when attacking web applications and ______ applications.
```
mobile
```
Task 3  Features of Burp Community
---

Although Burp Suite Community offers a more limited feature set compared to the Professional edition, it still provides an impressive array of tools that are highly valuable for web application testing. Let's explore some of the key features:

- ```Proxy```: The Burp Proxy is the most renowned aspect of Burp Suite. It enables interception and modification of requests and responses while interacting with web applications.
- ```Repeater```: Another well-known feature. Repeater allows for capturing, modifying, and resending the same request multiple times. This functionality is particularly useful when crafting payloads through trial and error (e.g., in SQLi - Structured Query Language Injection) or testing the functionality of an endpoint for vulnerabilities.
- ```Intruder```: Despite rate limitations in Burp Suite Community, Intruder allows for spraying endpoints with requests. It is commonly utilized for brute-force attacks or fuzzing endpoints.
- ```Decoder```: Decoder offers a valuable service for data transformation. It can decode captured information or encode payloads before sending them to the target. While alternative services exist for this purpose, leveraging Decoder within Burp Suite can be highly efficient.
- ```Comparer```: As the name suggests, Comparer enables the comparison of two pieces of data at either the word or byte level. While not exclusive to Burp Suite, the ability to send potentially large data segments directly to a comparison tool with a single keyboard shortcut significantly accelerates the process.
- ```Sequencer```: Sequencer is typically employed when assessing the randomness of tokens, such as session cookie values or other supposedly randomly generated data. If the algorithm used for generating these values lacks secure randomness, it can expose avenues for devastating attacks.


Beyond the built-in features, the Java codebase of Burp Suite facilitates the development of extensions to enhance the framework's functionality. These extensions can be written in Java, Python (using the Java Jython interpreter), or Ruby (using the Java JRuby interpreter). The ```Burp Suite Extender``` module allows for quick and easy loading of extensions into the framework, while the marketplace, known as the ```BApp Store```, enables downloading of third-party modules. While certain extensions may require a professional license for integration, there are still a considerable number of extensions available for Burp Community. For instance, the ```Logger++``` module can extend the built-in logging functionality of Burp Suite.

---

Which Burp Suite feature allows us to intercept requests between ourselves and the target?
```
Answer : proxy
```
Which Burp tool would we use to brute-force a login form?
```
Answer : Intruder
```

---


Task 4  Installation
---

Burp Suite is one of those tools that is very useful to have around, whether for ```web or mobile``` application assessments, pentesting, bug bounty hunting, or even debugging features in web app development. Here's a guide on installing Burp Suite on different platforms:

#### Note: 
If you use the AttackBox, Burp Suite is already installed, so you can skip this step.

#### Downloads
To download the latest version of Burp Suite for other systems, you may click this button to go to their download page.

```Kali Linux```: Burp Suite comes pre-installed with Kali Linux. In case it is missing on your Kali installation, you can easily install it from the Kali apt repositories.

```Linux, macOS, and Windows```: For other operating systems, ```PortSwigger``` provides dedicated installers for Burp Suite Community and Burp Suite Professional on the Burp Suite downloads page. Choose your operating system from the dropdown menu and select Burp Suite Community Edition. Then, click the ```Download``` button to initiate the download.

![img](/assets/img/burp-basics03.png)

#### Installation
Install Burp Suite using the appropriate method for your operating system. On Windows, run the executable file, while on Linux, execute the script from the terminal (with or without sudo). If you choose not to use ```sudo``` during installation on Linux, Burp Suite will be installed in your home directory at 
```
~/BurpSuiteCommunity/BurpSuiteCommunity
```
 and will not be added to your ```PATH```.

The installation wizard provides clear instructions, and it is generally safe to accept the default settings. However, it is always recommended to review the installer carefully.

With Burp Suite successfully installed, you can now launch the application. In the next task, we will explore the initial setup and configuration.


If you have chosen not to use the AttackBox, ensure that you have a copy of Burp Suite installed before proceeding.


---

Task 5  The Dashboard
---
You may use the pre-installed Burp Suite Community Edition in our AttackBox. To launch the AttackBox, click the Start AttackBox button at the top of this page.

Once you launch Burp Suite and accept the terms and conditions, you will be prompted to select a project type. In ```Burp Suite Community```, the options are limited, and you can simply click Next to proceed.

The next window allows you to choose the configuration for Burp Suite. It is generally recommended to keep the default settings, which are suitable for most situations. Click ```Start Burp``` to open the main Burp Suite interface.

Upon opening Burp Suite for the first time, you might encounter a screen with training options. It is highly recommended to go through these training materials when you have the time.

If you don't see the training screen (or in subsequent sessions), you will be presented with the Burp Dashboard, which may seem overwhelming at first. However, it will soon become familiar.

The Burp Dashboard is divided into four quadrants, as labelled in ```counter-clockwise order starting ```from the ```top left```:

![img](/assets/img/burp-basics04.png)

1. ```Tasks```: The Tasks menu allows you to define background tasks that Burp Suite will perform while you use the application. In Burp Suite Community, the default “Live Passive Crawl” task, which automatically logs the pages visited, is sufficient for our purposes in this module. Burp Suite Professional offers additional features like on-demand scans.

2. ```Event log```: The Event log provides information about the actions performed by Burp Suite, such as starting the proxy, as well as details about connections made through Burp.

3. ```Issue Activity```: This section is specific to Burp Suite Professional. It displays the vulnerabilities identified by the automated scanner, ranked by severity and filterable based on the certainty of the vulnerability.

4. ```Advisory```: The Advisory section provides more detailed information about the identified vulnerabilities, including references and suggested remediations. This information can be exported into a report. In Burp Suite Community, this section may not show any vulnerabilities.

Throughout the various tabs and windows of Burp Suite, you will notice ```question mark icons``` (question mark icon).

Clicking on these icons opens a new window with helpful information specific to that section. These help icons are invaluable when you need assistance or clarification on a particular feature, so make sure to utilise them effectively.

![img](/assets/img/burp-basics05.png)

By exploring the different tabs and functionalities of Burp Suite, you will gradually become familiar with its capabilities.


What menu provides information about the actions performed by Burp Suite, such as starting the proxy, and details about connections made through Burp?
```
Answer : Event Log
```

---

Task 6  Navigation
---

In Burp Suite, the default navigation is primarily done through the top menu bars, which allow you to switch between modules and access various sub-tabs within each module. The sub-tabs appear in a second menu bar directly below the main menu bar.

Here's how the navigation works:

1. Module Selection: The top row of the menu bar displays the available modules in Burp Suite. You can click on each module to switch between them. For example, the Burp Proxy module is selected in the image below.

![img](/assets/img/burp-basics06.png)

2. ```Sub-Tabs```: If a selected module has multiple sub-tabs, they can be accessed through the second menu bar that appears directly below the main menu bar. These sub-tabs often contain module-specific settings and options. For example, in the image above, the Proxy Intercept sub-tab is selected within the Burp Proxy module.

3. ```Detaching Tabs```: If you prefer to view multiple tabs separately, you can detach them into separate windows. To do this, go to the Window option in the application menu above the Module Selection bar. From there, choose the "Detach" option, and the selected tab will open in a separate window. The detached tabs can be reattached using the same method. ![img](/assets/img/burp-basics07.png)

Burp Suite also provides keyboard shortcuts for quick navigation to key tabs. By default, the following shortcuts are available:

![img](/assets/img/burp-basics08.png)

---

Which tab Ctrl + Shift + P will switch us to?
```
Proxy tab
```
---

Task 7  Options
---

Before diving into the Burp Proxy, let's explore the available options for configuring Burp Suite. There are two types of settings: ```Global settings ``(also known as User settings) and ```Project settings```.

```Global Settings```: These settings affect the entire Burp Suite installation and are applied every time you start the application. They provide a baseline configuration for your Burp Suite environment.

```Project Settings```: These settings are specific to the current project and apply only during the session. However, please note that ```Burp Suite Community Edition does not support``` saving ```projects```, so any project-specific options will be lost when you close Burp.

To access the settings, click on the ```Settings``` button in the top navigation bar. This will open a separate settings window.

![img](/assets/img/burp-basics09.png)

In the Settings window, you will find a menu on the left-hand side. This menu allows you to switch between different types of settings, including:

1. ```Search```: Enables searching for specific settings using keywords.
Type filter: Filters the settings for User and Project options.
2. ```User settings```: Shows settings that affect the entire Burp Suite installation.
Project settings: Displays settings specific to the current project.
3. ```Categories```: Allows selecting settings by category.
![img](/assets/img/burp-basics10.png)

It's worth noting that many tools within Burp Suite provide shortcuts to specific categories of settings. For example, the Proxy module includes a Proxy settings button that opens the settings window directly to the relevant proxy section.




