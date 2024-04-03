---
title:  "THM: Log Opertations"
date:   2024-04-01 19:00:00 +0000
categories: [Logs]
tags: [Logs]
---

![img](/assets/img/log-ops.png)  


---
Ref: 

- [THM: Into to Log Analysis](https://tryhackme.com/r/room/introtologs)

- [Intro to Logs](https://tryhackme.com/jr/introtologs)

- [Log Operations](https://tryhackme.com/jr/logoperations)


- [Windows Event Logs](https://tryhackme.com/room/windowseventlogs)

- Endpoint Detection and Response (EDR)

    - [Intro to Endpoint Security](https://tryhackme.com/room/introtoendpointsecurity)
    - [Aurora EDR](https://tryhackme.com/room/auroraedr)
    - [Wazuh](https://tryhackme.com/room/wazuhct)

- Intrusion Detection and Prevention Systems (IDPS)

    - [Snort](https://tryhackme.com/room/snort)
    - [Snort Challenge - The Basics](https://tryhackme.com/room/snortchallenges1)
    - [Snort Challenge - Live Attacks](https://tryhackme.com/room/snortchallenges2)


- Security Information and Event Management (SIEM)

    - [Investigating with ELK 101](https://tryhackme.com/room/investigatingwithelk101)
    - [Splunk: Basics](https://tryhackme.com/room/splunk101)
    - [Incident handling with Splunk](https://tryhackme.com/room/splunk201)




---

Task 1 - Introduction
---

Log Operations

The first thing that comes to mind regarding log analysis is to open the door to the adventure of looking for a needle in a haystack. In case of an incident investigation, are you lost in the log space and wasting your precious time? If so, it's time to do something about log configuration.

In this room, you will learn the configuration approaches required to manage and analyse logs in an operational context and the log information you learned in the previous introductory room.

Learning Objectives

Understanding the logic of log management and configuration
Familiarise with log configuration approaches
Experience the log configuration process
Room Prerequisites

Working knowledge of MS Windows and Linux
Working knowledge of network and endpoint log systems
[Intro to Logs](https://tryhackme.com/room/introtologs)


---

Task 2 - Log Configuration
---

### Log Configuration Options
---
"Do you dare to configure your logs, or are you happy to be lost in the madness of the thousands of lines?" In log operations, there are multiple concerns about configuration approaches, and identifying the suitable configuration approach could be a pain point. 

Log configuration is a multifaceted operation that addresses security, operational stability, regulatory compliance, and debugging needs. Adequately configured logs are crucial in cyber security, operational efficiency, regulatory compliance, and software development, providing organisations with comprehensive system, asset, and resource management statistics. Let's look at and understand the scopes and differences of common purposes of log configuration. 

- SECURITY
- OPERATIONAL
- LEGAL
- DEBUG


### Security Purposes
---

Logging and configuration for security purposes are typically planned to detect and respond to anomalies and security issues. For example, configuration to verify the authenticity of user activity to ensure authorisation control and timely detection of unauthorised access. The main focus areas of this approach are:

- Anomaly and threat detection
- Logging user authentication data
- Ensuring the system's integrity and data confidentiality

### Operational Purposes
---

Logging and configuring for operational purposes is usually planned to detect and respond to system errors and identify action points to enhance the system's performance, continuity, and reliability. The main focus areas of this approach are:

- Proactively creating reports and notifications for on-system and component status
- Troubleshooting
- Capacity planning
- Service billing

### Legal Purposes
---

Logging and configuring for legal purposes is similar to security purposes; it is usually planned to stay compliant and increase the alignment with regulations and obligations. Here, the laws, regulations, and compliance standards will vary depending on the work's scope, the data being processed, and the service area being provided. Therefore, each enrollment will come with a set of responsibilities and guidelines to follow. The main focus areas of this approach are:

- Alignment with standards, compliance, regulations, and laws
    - E.g. ISO 27001, COBIT, GDPR, PCI DSS, HIPAA, FISMA

```Legal Compliance Example```: A company must have an active central log management system, adequate log configuration, 12-month log retention for logs and affiliated system logs (last three months data must always be ready to search), system and component security checks, and overall yearly audit checks to meet PCI logging compliance.

### Debug Purposes
---
Logging and configuring for debug purposes is usually planned to boost the system's reliability and enhance provided features by discovering the bugs and potential fault conditions. This configuration scope is not always implemented in the production environment and is mostly used for testing and developing purposes. The main focus areas of this approach are:

- Increasing visibility for the application debugging
- Enhancing efficiency
- Speeding up the development process

---

1. Which of the given log purposes would be suitable to measure the cost of using a service?

Answer : Operational


2. Which of the given log purposes would be suitable for investigating application logs for enhancement and stability? 

Answer : Debug

---


Task 3 - Where To Start After Deciding the Logging Purpose
---

Where To Start and What To Do After Deciding the Log Purpose?

If you already have an objective and scope plan but need help knowing how and where to start, you can use the meeting and brainstorming methods with your team. The meeting might sound like a passive action, but it will start the ball rolling for brainstorming, which will help consider multiple aspects and create a draft plan.

Remember, each log configuration purpose is planned and implemented to fulfil a different goal. Questioning is one of the most common ways to identify needs and facilitate planning. Remember, each implementation is unique, but common base questions must be answered in almost any log configuration planning session. You can use the following questions as a starting point and broaden the list according to the answers. Remember, you will need additional steps like creating a detailed plan, choosing tools/technologies, establishing monitoring and review/analysis processes after answering the initial questions.

Questions To Ask In Planning Meeting/Session
---
- What will you log, and for what (asset scope and logging purpose)?
    - Is additional commitment or effort required to achieve the purpose (requirements related to the purpose)?
- How much are you going to log (detail scope)?
- How much do you need to log?
- How are you going to log (collection)?
- How are you going to store collected logs?
    - Is there a standard, process, legislation, or law that you must comply with due to the data you log?
- How are you going to protect the logs?
- How are you going to analyse collected logs?
- Do you have enough resources and workforce to do logging?
- Do you have enough budget to plan, implement and maintain logging?

---

You are a consultant working for a growing startup. As a consultant, you participated in a log configuration planning session. The company you work for is working to get compliant to process payment information. The given question set is being discussed.

1. Which question's answer can be "as much as mentioned in the PCI DSS requirements."?

    Answer: How much do you need to log

---

Task 4 - Configuration Dilemma: Planning and Implementation
---

### Configuration Dilemma: Requirements, Aspirations, Resources, and Investment
---
Configuration dilemma reflects the challenges of implementation. As highlighted in the previous task, each log configuration scope comes with responsibilities, guidelines, and challenges. This means that the log configuration and logging are more than a simple practice of enabling logging from the assets and surviving among thousands of lines.

Each log configuration plan results from a unique analysis of the scope, assets, objectives, requirements, and expectations to be applied. Expectations, requirements, and limits are determined with the involvement of system administrators, legal and financial advisors, and managers, if possible. In summary, the main source of the dilemma is finding the balance between requirements, scope, details, and price (financial and labour costs, risks, and investment). During the meeting, there might be some points where participants get off the point, but it is vital to keep in mind that the main objective of the meeting is:

- Meeting specific operational and security requirements (non-negotiable) while also considering the feasibility of improving the capability by implementing additional data and insights.

Last but not least, a comprehensive risk assessment, prioritising security, compliance, and legal needs will be helpful to navigate this dilemma. Finding the balance in "operational and management" level decisions and achieve secure, efficient, proactive, resilient, and sustainable outcomes in the ever-evolving threat/IT landscape and technical operations.

### Translating "Requirements" and "Aspirations" To Operational Level
---

Let's take a closer look at exactly how the dilemma arose.
![img](/assets/img/log-ops01.png)

While the main focus is the same, two question sets represent two distinct dimensions of logging and analysis:

- The base part heavily relies on an incident detection mindset. Still, it provides a solid framework for logging and analysis but is reactive. The requirements are a good place to start, but it is primarily helpful against known threats.

- The aspirations part is more focused on a threat-hunting mindset. Therefore, it is proactive and requires more resources due to the need to go above and beyond. Therefore, this part is more helpful against advanced and sophisticated threats. 

The baseline part is necessary for a solid incident detection and response scope foundation. However, adopting proactive aspirations by adding them to the operational vision is strongly recommended, given the ever-evolving threat landscape. 


The session continues, and your teammates need your help; they will negotiate for logging budget and operation details. As a consultant, you must remind them of a vital point:

1. Which requirements are non-negotiable?

    Answer: operational and security requirements


---

Task 5 - Principles and Difficulties
---

### Logging Principles
---
Logging is a critical aspect of the cyber-security and IT operations. It is a process that is as burdensome as functional and requires active resource utilisation. Therefore, it is crucial to implement a proper logging operation and ensure its effectiveness and efficiency. There are multiple principles which help achieve the mentioned goal. The table below highlights some of the essentials.

![img](/assets/img/log-ops02.png)

### Challenges
---
Challenges are as much a part of log management as principles. However, most of them can be addressed in the planning section. The table below highlights the main challenges of logging.

![img](/assets/img/log-ops03.png)


### Where To Go From Here?
---
The mentioned principles and challenges are common and can vary according to your case. However, the main point is adhering to logging principles and proactively addressing challenges.

---

1. Your team is working on policies to decide which logs will be stored and which portion will be available for analysis.
Which of the given logging principles would be implemented and improved?

    Answer : Archiving and Accessibility

2. Your team implemented a brand new API logging product. One of the team members has been tasked with collecting the logs generated by that new product. The team member reported continuous errors when transferring the logs to the review platform.
In this case, which of the given difficulties occurs?

    Answer : Process and Archive

---

Task 6 - Common Mistakes and Best Practices
---

### Common Mistakes and Best Practices
---
Logging is a powerful and valuable tool for cyber security and IT operations. But harnessing this power and maximising it takes solid planning and implementation. Otherwise, logging will become inefficient, making things difficult to do, tedious to manage, and draining resources.

In addition to the high and low-level details, strategies and suggestions discussed until this point, a few more things require your attention. Logging is a continuous and live operation which needs continuous maintenance and improvement. Therefore, the infamous "if it works, don't touch it!" approach is unacceptable. The threats and computing technologies evolve and change; therefore, you must update your configurations and adapt the changes accordingly. Implementing the following actions is a good place to start the self-assessment and improvement process.

- Learn from mistakes and failures.
- Track the sectoral threat dynamics for the operated sector and conduct regular scope and resilience testing.
- Follow the best practices of industry leaders and experts.

If you ever think about how important to re-configure, update, or test your existing logging configurations is, please consider the following real-life experience faced by millions of people worldwide.

![img](/assets/img/log-ops04.png)

### Common Mistakes and Best Practices
---
First, you should use consultancy services if you are short on time and need a solution that directly fits your systems. Tailored-up solutions require comprehensive risk assessment practices, as highlighted in the previous tasks. However, avoiding some known pain points and deadlock cases is possible by considering the "dos" and "don'ts" in the planning and implementation steps. Therefore, the main point of this section is understanding "what does work" and "what doesn't".

---

As a consultant, you are doing a comprehensive risk assessment and noticed that one of the development teams implemented a custom script to generate logs for an old system, which omits loggings at some phases.

1. What you would call this? (Mistake or Practice?)

    Answer: Mistake

---

Task 7 - Conclusion
---

Congratulations!

You just finished the "Log Operations" room.

In this room, we dived deep into log operations and discovered the background and management side of the technical logging and log analysis operations by covering:

- Fundamentals of log configuration.
- Logging use cases.
- Common mistakes and learn best practices in logging.

Now, you have a solid understanding of the overall log operations and are ready to fly to the log universe, where you will experience the hands-on aspect of the log operations!