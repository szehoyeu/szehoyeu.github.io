---
title:  "THM: Burp Sutie-Intruder"
date:   2024-02-26 21:00:00 +0000
categories: [BurpSuite]
tags: [BurpSuite]
---

![image](/assets/img/burp-Intruder.png)

---
Ref: 

- [THM: Burp Sutie-Intruder](https://tryhackme.com/room/burpsuiteintruder)

- [Repeater](https://tryhackme.com/room/burpsuiterepeater)

- [Intruder](https://tryhackme.com/room/burpsuiteintruder)

- [Decoder](https://tryhackme.com/room/burpsuiteom)

- [Comparer](https://tryhackme.com/room/burpsuiteom)

- [Sequenxer](https://tryhackme.com/room/burpsuiteom)

- [Link](https://www.youtube.com/watch?v=eaOk-N1UQuU)

---

Task 1  Introduction
---

Welcome to the Burp Suite Intruder room!
In this room, we will explore Burp Suite's Intruder module, which offers automated request manipulation and enables tasks such as fuzzing and brute-forcing. If you are not familiar with Burp Suite's Proxy and Repeater functionality, it is recommended to complete at least the Burp Basics room before proceeding.

Burp Suite's Intruder module is a powerful tool that allows for automated and customisable attacks. It provides the ability to modify specific parts of a request and perform repetitive tests with variations of input data. Intruder is particularly useful for tasks like fuzzing and brute-forcing, where different values need to be tested against a target.

Deploy the target VM attached to this task by pressing the green Start Machine button. Also, start the AttackBox by pressing the blue Start AttackBox button at the top of this room if you are not using your own machine. Then start Burp and follow along with the next tasks.


 Task 2  What is Intruder
 ---

Intruder is Burp Suite's built-in fuzzing tool that allows for automated request modification and repetitive testing with variations in input values. By using a captured request (often from the Proxy module), Intruder can send multiple requests with slightly altered values based on user-defined configurations. It serves various purposes, such as ```brute-forcing login forms``` by substituting username and password fields with values from a wordlist or performing fuzzing attacks using wordlists to test subdirectories, endpoints, or virtual hosts. ```Intruder's functionality``` is comparable to command-line tools like ```Wfuzz``` or ```ffuf```.

However, it's important to note that while Intruder can be used with Burp Community Edition, it is ```rate-limited, significantly reducing its speed compared to Burp Professional```. This limitation often leads security practitioners to rely on other tools for fuzzing and brute-forcing. Nonetheless, Intruder remains a valuable tool and is worth learning how to use it effectively.

Let's explore the Intruder interface:

![img](/assets/img/burp-Intruder01.png)

The initial view of Intruder presents a simple interface where we can select our target. This field will already be populated if a request has been sent from the Proxy (using Ctrl + I or right-clicking and selecting "Send to Intruder").

There are four sub-tabs within Intruder:

- ```Positions```: This tab allows us to select an attack type (which we will cover in a future task) and configure where we want to insert our payloads in the request template.

- ```Payloads```: Here we can select values to insert into the positions defined in the Positions tab. We have various payload options, such as loading items from a wordlist. The way these payloads are inserted into the template depends on the attack type chosen in the Positions tab. The Payloads tab also enables us to modify Intruder's behavior regarding payloads, such as defining pre-processing rules for each payload (e.g., adding a prefix or suffix, performing match and replace, or skipping payloads based on a defined regex).

- ```Resource Pool```: This tab is not particularly useful in the Burp Community Edition. It allows for resource allocation among various automated tasks in Burp Professional. Without access to these automated tasks, this tab is of limited importance.

- ```Settings```: This tab allows us to configure attack behavior. It primarily deals with how Burp handles results and the attack itself. For instance, we can flag requests containing specific text or define Burp's response to redirect (3xx) responses.

#### Note: 
The term ```"fuzzing"``` refers to the process of ```testing functionality``` or ```existence by applying a set of data to a parameter```. 

For example: 

Fuzzing for endpoints in a web application involves taking each word in a wordlist and appending it to a request URL (e.g., http://MACHINE_IP/WORD_GOES_HERE) to observe the server's response.

---
```

In which Intruder tab can we define the "Attack type" for our planned attack?

Answer : Positions
```

Task 3  Positions
---

When using Burp Suite Intruder to perform an attack, the first step is to examine the positions within the request where we want to insert our payloads. These positions inform Intruder about the locations where our payloads will be introduced (as we will explore in upcoming tasks).

Let's navigate to the Positions tab:
![img](/assets/img/burp-Intruder02.png)

Notice that Burp Suite automatically attempts to identify the most probable positions where payloads can be inserted. These positions are highlighted in green and enclosed by section marks (§).

On the right-hand side of the interface, we find the following buttons: ```Add §, Clear §, and Auto §```:

- The ```Add §```button allows us to define new positions manually by highlighting them within the request editor and then clicking the button.

- The ```Clear §``` button removes all defined positions, providing a blank canvas where we can define our own positions.

- The ```Auto § ```button automatically attempts to identify the most likely positions based on the request. This feature is helpful if we previously cleared the default positions and want them back.

The following GIF demonstrates the process of adding, clearing, and automatically reselecting positions:

![img](/assets/file/Burp-Intruder01.gif)


What symbol defines the start and the end of a payload position?
```
§
```

---

Task 4  Payloads
---
In the Payloads tab of Burp Suite Intruder, we can create, assign, and configure payloads for our attack. This sub-tab is divided into four sections:


![img](/assets/img/burp-Intruder03.png)


1. ```Payload Sets```:

   - This section allows us to choose the position for which we want to configure a payload set and select the type of payload we want to use.

   - When using attack types that allow only a single payload set (Sniper or Battering Ram), the "Payload Set" dropdown will have only one option, regardless of the number of defined positions.

   - If we use attack types that require multiple payload sets (Pitchfork or Cluster Bomb), there will be one item in the dropdown for each position.

   - Note: When assigning numbers in the "Payload Set" dropdown for multiple positions, follow a top-to-bottom, left-to-right order. For example, with two positions (```username=§pentester§&password=§Expl01ted§```), the first item in the payload set dropdown would refer to the username field, and the second item would refer to the password field.

2. ```Payload settings```:
   - This section provides options specific to the selected payload type for the current payload set.

   - For example, when using the "Simple list" payload type, we can manually add or remove payloads to/from the set using the Add text box, Paste lines, or Load payloads from a file. The Remove button removes the currently selected line, and the Clear button clears the entire list. Be cautious with loading huge lists, as it may cause Burp to crash.

   - Each payload type will have its own set of options and functionality. Explore the options available to understand the range of possibilities.


3. Payload Processing:
   - In this section, we can define rules to be applied to each payload in the set before it is sent to the target.

   - For example, we can capitalize every word, skip payloads that match a regex pattern, or apply other transformations or filtering.

   - While you may not use this section frequently, it can be highly valuable when specific payload processing is required for your attack.


4. Payload Encoding:
   - The section allows us to customize the encoding options for our payloads.

   - By default, Burp Suite applies URL encoding to ensure the safe transmission of payloads. However, there may be cases where we want to adjust the encoding behavior.

   - We can override the default URL encoding options by modifying the list of characters to be encoded or unchecking the "URL-encode these characters" checkbox.

By leveraging these sections, we can create and customise payload sets to suit the specific requirements of our attacks. This level of control allows us to finely tune our payloads for effective testing and exploitation.

---


Which Payload processing rule could we use to add characters at the end of each payload in the set?

Answer : Add Suffix

---




