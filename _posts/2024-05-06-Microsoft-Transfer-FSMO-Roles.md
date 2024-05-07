---
title:  "Microsoft - Transfer FSMO roles to another Domain Controller"
date:   2024-05-06 19:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---

![img](/assets/img/ps.png)

![img](/assets/img/ms.png)


---
Ref: 

- [How to view and transfter FSMO roles](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/view-transfer-fsmo-roles)

- [Link](https://www.youtube.com/watch?v=4p1ezkRfFzM)




---
> 
#### NOTE: 
Login to the TARGET Machine that you want to transfer the FSMO roles to.
{: .prompt-tip }


Step 1: Check the FSMO roles on the Domain Controller
```
netdom query fsmo
```
Output
```
Schema master               DC1.fqdn.com
Domain naming master        DC1.fqdn.com
PDC                         DC1.fqdn.com
RID pool manager            DC1.fqdn.com
Infrastructure master       DC1.fqdn.com
The command completed successfully.
```

Step 2: Check the replication between Domain Controllers
```
repadmin /showrepl
```

Step 3: 
```
repadmin /replsummary
```

Step 4: login to the TARGET DC that you want the FSMO roles to transfer

- Frist transfer RID, PDC and Infrastructure Roles
     - Open Active Directory Users and Computers
     - Right click on the domain and 
     - select "OperationMaster"

        ![img](/assets/img/fsmo01.png)

     - Repeat Step 1 and check the roles have been transferred successfully.

- Second transfer Domain Naming Roles
    - Open Active Directory Domains and Trusts
    - Right click on Active Directory Domains and Trusts
    - Select OperationMaster...

        ![img](/assets/img/fsmo02.png)
        
    - Change the Domain Naming operation master to the new DC

        ![img](/assets/img/fsmo03.png)

    - Repeat Step 1 and check the roles have been transferred successfully.

 - Third transfer SchemaMaster role
    - Register new schema master via PowerShell
    ```
    regsvr32 schmmgmt.dll
    ```
    - Open Microsoft Management Console (MMC)
    ```
    mmc.exe
    ```
    - Click File, then select "Add/Remove Snap-in..."" 
    - Select Active Directory / Schema

        ![img](/assets/img/fsmo04.png)


    - Right click on the Active Directory Schema
    - Select "Change Active Directory Domain Controller" and click OK

        ![img](/assets/img/fsmo05.png)

        ![img](/assets/img/fsmo06.png)

    - Right click on the Active Directory Schema
    - Select OperationMaster...

        ![img](/assets/img/fsmo07.png)

        ![img](/assets/img/fsmo08.png)

    - Repeat Step 1, 2 and 3 to check the roles have been transferred successfully.
    


Step A: Move the FSMO roles via powershell

The names of the FSMO roles may be typed out as well.

```
Move-ADDirectoryServerOperationMasterRole –Identity "Target_DC_Name" –OperationMasterRole 0,1,2,3,4
```
- 0 = PDC Emulator
- 1 = RID Master
- 2 = Infrastructure Master
- 3 = Schema Master
- 4 = Domain Naming Master

Press Y for each or A for all.

Step B: Verify if the FSMO roles via powershell
```
Get-ADDomainController -Filter * | Select Name, OperationMasterRoles
```


