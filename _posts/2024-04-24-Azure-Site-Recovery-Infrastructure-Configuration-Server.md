---
title:  "Deploy Configuration Server in Azure for Site Recovery Infrastructure (Recovery Services Vault)"
date:   2024-04-24 18:00:00 +0000
categories: [Azure]
tags: [Azure]
---

![image](/assets/img/asr.png)
---
Ref:

- [Classic to Modernized Experience](https://learn.microsoft.com/en-us/azure/site-recovery/vmware-physical-azure-classic-deprecation)


---


---

[Download Configuration Server VM Template](https://aka.ms/asrconfigurationserver_eus)

1. [Download](https://aka.ms/asrconfigurationserver_eus) the Configuration server virtual machine template.
2. Import the Configuration server virtual machine template into your vCenter server using the Deploy OVF Template wizard.
3. Connect to the virtual machine’s console once it has successfully booted up.
4. Complete the Windows Server installation by accepting the license agreement and setting up an Administrator account
5. Launch the Azure Site Recovery Configuration Manager wizard and follow the steps to register your Configuration server with Azure Site Recovery. [Read more](https://aka.ms/prepareconfsrv)