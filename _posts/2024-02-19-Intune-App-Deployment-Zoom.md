---
title:  "Intune: App Deployment - Install software"
date:   2024-02-19 18:00:00 +0000
categories: [Intune]
tags: [Intune]
---

![image](/assets/img/intune.png)

---
Ref: 

[cloudinfra.net](https://cloudinfra.net/how-to-deploy-zoom-using-intune/)



---
Step 1  Download Zoom App
---
Download 64 bit is recommended.
[Download Link:](https://zoom.us/download)
![img](/assets/img/intune13.png)

Step 2  Create App Deployment
---

- Microsoft Intune Admin Center>Apps>All apps> 
- Add (+Add)
- Select app type "Line-of-business" app
![img](/assets/img/intune12.png)

- Click on “app package file” and browse for Zoom MSI file. Click on OK button to proceed.
![img](/assets/img/intune14.png)

#### App Information
---
Name: Enter the name of the application.
Description: Enter the description of the application.
Publisher: Enter the name of the Publisher of the app.
App install context: Select App install context as Device.
Ignore App version: Yes [If you’re using ZoomAutoUpdate=true switch, then set it to Yes, otherwise, keep it at No].
Command-line arguments: Provide command-line arguments/switches to be executed with selected MSI.
```
ZConfig=”nogoogle=1″ ZConfig=”nofacebook=1″ AudioAutoAdjust=”1″ ZoomAutoUpdate=True
```
Command-line arguments configure certain features or settings for Zoom App. I have provided information about some of the switches being used. For more details and complete list of command-line switches, you can refer to this link: Zoom Mass deployment.


- ZConfig=”nogoogle=1″ – It will disable Google login method for Zoom app.

- ZConfig=”nofacebook=1″ – It will disable Facebook login method for Zoom app.

- AudioAutoAdjust=”1″ – This will Auto-adjust audio to “auto” setting. (Automatically adjusts noise suppression).

- ZoomAutoUpdate=True – This will make sure Zoom app is updated automatically. 
Users can check for updates and Install without the requirement of administrator rights.

![img](/assets/img/intune15.png)

#### Assignments
There are two options available under Assignments tab. Required and Uninstall. Under Required assignments section, Add an Azure AD group containing devices.

![img](/assets/img/intune16.png)

Review + create
Review the app deployment and click on Create to proceed.

Step 3 – Monitoring Installation status
---
You can monitor Installation of Zoom app deployment directly from Intune admin center. 
Please follow below steps to check the status of deployment.

- Open the app deployment for Zoom on Intune admin center.
- Go to the Overview page, which will provide overall Installation status of Zoom app.
- To find out more details about the app deployment, click on Device install status or User install status under Monitor.

Step 4 – End-User Experience
---
To check if Zoom Application has been Installed Successfully. You can open Control Panel > Programs and Features to check and confirm Zoom app installation.
![img](/assets/img/intune17.png)
