---
title:  "Deploy Configuration Server in Azure for Site Recovery Infrastructure (Recovery Services Vault)"
date:   2024-04-24 18:00:00 +0000
categories: [Azure]
tags: [Azure]
---

![image](/assets/img/asr.png)
---
Ref:

- [Deploy Azure Site Recovery replication applicance - Modernized](https://learn.microsoft.com/en-us/azure/site-recovery/deploy-vmware-azure-replication-appliance-modernized#set-up-the-appliance-through-powershell)

- [Classic Experience](https://learn.microsoft.com/en-us/azure/site-recovery/vmware-physical-azure-classic-deprecation)



---


---

Classic: 

[Download Configuration Server VM Template](https://aka.ms/asrconfigurationserver_eus)

1. [Download](https://aka.ms/asrconfigurationserver_eus) the Configuration server virtual machine template.
2. Import the Configuration server virtual machine template into your vCenter server using the Deploy OVF Template wizard.
3. Connect to the virtual machine’s console once it has successfully booted up.
4. Complete the Windows Server installation by accepting the license agreement and setting up an Administrator account
5. Launch the Azure Site Recovery Configuration Manager wizard and follow the steps to register your Configuration server with Azure Site Recovery. [Read more](https://aka.ms/prepareconfsrv)



-----


Modernized: 

Add new replication appliance
VMware machines to Azure
Modernized experience is selected by default to provide enhanced capabilities. Learn more
To enable Azure Site Recovery on your on-premises VMware virtual machines, you will need to deploy an ASR replication appliance. Learn more

To set up the first ASR replication appliance in this vault, follow the simple steps given below


Steps to set up a new ASR replication appliance

1. Create an appliance through either of the following methods

Using pre-configured virtual machine image (OVA):

Download the following virtual machine image and import the image to a vCenter Server to create the virtual machine.

 Download (.OVA file, 15GB)

Complete the Windows server installation steps by accepting the license agreement and setting up an administrator account.

OR

Set up the appliance on a virtual machine or physical server through PowerShell

For step-by-step guidance visit our [documentation](https://go.microsoft.com/fwlink/?linkid=2168822)

2. Complete the registration of appliance using the following key

Registration key


```Note```: 
Wait for the appliance to be connected. Proceed to 'Replicate' your machines to azure.
About 15 minutes after you configure your appliance, you can start using the appliance for replicating your on-premises machines to Azure. Go to Azure Site Recovery 'Getting started' and click on 'Enable replication' to proceed.

---

3. Deploy the VM to VCenter
