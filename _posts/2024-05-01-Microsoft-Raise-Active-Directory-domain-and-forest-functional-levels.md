---
title:  "Microsoft-Raise Active Directory domain and forest functional levels"
date:   2024-05-01 19:00:00 +0000
categories: [DomainController]
tags: [DomainController]
---

![img](/assets/img/ms.png)

---
Ref: 

- [How to raise Active Directory domain and forest functional levels](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels)

- [What Are Active Directory Functional Levels?](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc787290(v=ws.10))

- [Raise the functional level using PowerShell scripts](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11)).

- [Raise the functional level using GUI Administration Tools](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc759280(v=ws.10))


- [Identifying Your Functional Level Upgrade](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/identifying-your-functional-level-upgrade?source=recommendations)
Learn more about: Identifying Your Functional Level Upgrade

- [Active Directory Domain Services Functional Levels in Windows Server](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-functional-levels?source=recommendations)
Learn more about Active Directory Domain Services Functional Levels in Windows Server.

- [Raise the bastion forest functional level for Identity Manager to use Active Directory PAM features](https://learn.microsoft.com/en-us/microsoft-identity-manager/pam/raise-bastion-functional-level?source=recommendations)
Raise a privileged access management deployment that started with Windows Server 2012 R2 functional level to the Windows Server 2016 functional level.


---

### Summary

1. Microsoft Windows Server 2003-based or newer domain controllers support raising the domain and forest functional levels.

2. Functional levels have two modes
    - Mixed mode
    - Native mode

3. To activate the newest forest-wide features, all the domain controllers must be running the Windows Serve operating system version in the domain.

4. To activate the newest domain features, all the domain controllers must be running the newest Windows Server operating system version in the domain.

5. Changing the domain and forest functional levels are irreversible except a forest recovery must be used. Ref: Specific scenarios - [Technet-Active Directory Functional levels](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc787290(v=ws.10))


#### Active Directory Functional Level Scenarios

---

 - Ideally, all servers in an organization could run the latest version of Windows and take advantage of all the advanced features that are available with the newest software. 
 
 - But organizations often have a mixture of systems, generally running different versions of operating systems, which are migrated to the latest version only as organizational requirements demand additional functionality, either for the entire organization or for a specific area of the organization.

#### Example:
---
#### Domain functional level. Six domain functional levels are available:

- Windows 2000 mixed (the default in Windows Server 2003)
- Windows 2000 native
- Windows Server 2003 interim
- Windows Server 2003
- Windows Server 2008
- Windows Server 2008 R2

Setting the functional level for a domain enables features that affect the entire domain and that domain only.

- If all domain controllers in a domain are running Windows Server 2008 R2 and the functional level is set to Windows Server 2008 R2, all domain-wide features are available.

---

#### Forest functional level. Five forest functional levels are available:

- Windows 2000 (the default in Windows Server 2003 and Windows Server 2008)
- Windows Server 2003 interim
- Windows Server 2003 (the default in Windows Server 2008 R2)
- Windows Server 2008
- Windows Server 2008 R2

Setting the functional level for a forest enables features across all the domains within a forest. 

- If all domain controllers in a forest are running Windows Server 2008 R2 and the functional level is set to Windows Server 2008 R2, all forest-wide features are available.


Note: 

When domain controllers running earlier versions of Windows Server are included in your domain or forest with domain controllers running later versions of Windows Server, advanced Active Directory features are limited.

#### Example:

- A small organization running only Windows Server 2008 R2 on domain controllers. In this scenario, a small organization might be creating an AD DS infrastructure for the first time, using only two domain controllers in a forest with a single domain. By installing Windows Server 2008 R2 on both domain controllers and selecting the Windows Server 2008 R2 forest functional level during the AD DS installation on the first domain controller, the organization can immediately take advantage of all of the advanced Active Directory features that are available.

---
#### Example:

- A mid-size organization with accelerated upgrade requirements. In this scenario, a mid-size organization might have a native mode Windows Server 2003 domain, and would now like to start upgrading domain controllers to Windows Server 2008. 

- Upgrading to Windows Server 2008 on some domain controllers, while maintaining some previously installed domain controllers running Windows Server 2003, enables the mid-size organization to take advantage of much of the latest functionality, even though all domain controllers are not running Windows Server 2008. 

- Later, after all domain controllers running Windows Server 2003 have been upgraded to Windows Server 2008, the organization can raise the forest functional level to take advantage of all advanced Active Directory features.

---
#### Example:

- A large organization with phased upgrade requirements. In this scenario, an enterprise with a mature and complex forest with multiple domains, some of which are still running Windows 2000 Server, might now be ready to install one or more new domain controllers running Windows Server 2008. 

- Members of the organization might want to raise functional levels in a phased manner (one domain at a time). They could target certain domains that are running Windows 2000 domain controllers and upgrade them first to Windows Server 2003 and then to Windows Server 2008. 

- After they upgrade all domain controllers in the domain, they could raise the functional level of only that domain to Windows Server 2008 to take advantage of additional Active Directory features.


---

### Active Directory Functional Level Dependencies and Rollback Options

Active Directory domain and forest functionality has the following dependencies:

- After all domain controllers are running an appropriate version of Windows Server, the domain or forest must be configured to support the appropriate domain or forest functional level. 

- That is, to provide support in a ```domain or forest``` for advanced Active Directory features, an administrator ```must raise the domain functional level or forest functional level```, which can only be done if the domain controllers are each running the appropriate version of Windows Server.

- After the domain functional level is raised, domain controllers running ```earlier versions of Windows Server``` ```cannot``` be introduced into the domain. 

- After the forest functional level is raised, domain controllers running ```earlier versions of Windows Server``` ```cannot``` be introduced into the forest.

- With versions of Windows Server that are earlier than Windows Server 2008 R2, you ```cannot roll back or lower a functional level``` under any circumstances. 

- ```If you have to revert to a lower functional level with a version of Windows Server that is earlier than Windows Server 2008 R2, you must rebuild the domain or forest or restore it from a backup copy.```

- After you set the ```domain functional level``` to a certain value in Windows Server 2008 R2, you ```cannot roll back or lower the domain functional level```, 

- With one exception: when you raise the ```domain functional level``` to Windows Server 2008 R2 and if the ```forest functional level``` is Windows Server 2008 or lower, you have the option of rolling the domain functional level back to Windows Server 2008. 

- You can lower the ```domain functional level``` only from Windows Server 2008 R2 to Windows Server 2008. If the domain functional level is set to Windows Server 2008 R2, it cannot be rolled back, for example, to Windows Server 2003.

- After you set the ```forest functional level``` to a certain value in Windows Server 2008 R2, you ```cannot roll back or lower the forest functional level```, 

- With one exception: when you raise the ```forest functional level``` to Windows Server 2008 R2 and if the Active Directory Recycle Bin is not enabled, you have the option of rolling the forest functional level back to Windows Server 2008. 

For more information about the Active Directory Recycle Bin, see What's New in AD DS: Active Directory Recycle Bin (https://go.microsoft.com/fwlink/?LinkId=141392). 

- You can ```lower the forest functional level``` only from Windows Server 2008 R2 to Windows Server 2008. If the forest functional level is set to Windows Server 2008 R2, it cannot be rolled back to Windows Server 2003, for example.

---


### Raising the functional level
---

The most common method to enable domain and forest functional levels is to use [GUI administrationi tools](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc759280(v=ws.10))

The functional level can be manually configured or using [PowerShell scripts](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11)).


### View and set the functional level manually
---

The Lightweight Directory Access Protocol (LDAP) tools such as Ldp.exe and Adsiedit.msc can be used to view and to modify the current domain and forest functional level settings. 

When you change the functional level attributes manually, the ```best practice``` is to make attribute ```changes on the Flexible Single Master Operations (FSMO) domain controller``` that is normally targeted by the Microsoft administrative tools.


#### Domain functional level settings

The ```msDS-Behavior-Version``` attribute is on the ```naming context (NC) head``` for the domain, that is, DC=corp, DC=contoso, DC=com.


You can set the following values for this attribute:
- Value of 0 or not set=mixed level domain
- Value of 1=Windows Server 2003 domain level
- Value of 2=Windows Server 2003 domain level
- Value of 3=Windows Server 2008 domain level
- Value of 4=Windows Server 2008 R2 domain level

#### Mixed mode and native mode settings

The ```ntMixedDomain``` attribute is on the ```naming context (NC) head``` for the domain, that is, DC=corp, DC=contoso, DC=com.

You can set the following values for this attribute:

- Value of 0=Native level domain
- Value of 1=Mixed level domain

#### Forest level setting

The ```msDS-Behavior-Version``` attribute is on the ```CN=Partitions object``` in the Configuration naming context (NC), that is, CN=Partitions, CN=Configuration, DC= ForestRootDomain.

You can set the following values for this attribute:

- Value of 0 or not set=mixed level forest
- Value of 1=Windows Server 2003 interim forest level
- Value of 2=Windows Server 2003 forest level
- Value of 3=Windows Server 2008 domain level
- Value of 4=Windows Server 2008 R2 domain level


1. After you use the Lightweight Directory Access Protocol (LDAP) tools to edit the functional level, click ```OK``` to continue. 

2. The attributes on the ```partitions container``` and on the ```domain head are correctly increased```. If an error message is report by the Ldp.exe file, you can ```safely ignore the error message```. 

3. To verify that the level increase was successful, ```refresh the attribute list```, and then check the current setting. 
This error message may also occur after you have performed the level increase on the authoritative FSMO if the change has not yet replicated to the local domain controller.

#### Quickly view the current settings by using the Ldp.exe file

1. Start the Ldp.exe file.
2. On the Connection menu, click Connect.
3. Specify the domain controller that you want to query, or leave the ```space blank``` to connect to any domain controller.

After you connect to a domain controller, the ```RootDSE``` information for the domain controller appears. This information includes information on the forest, domain, and domain controllers. 

- The following is an example of a Windows Server 2003-based domain controller. In the following example, assume that the ```domain mode``` is``` Windows Server 2003``` and that the ```forest mode``` is ```Windows 2000 Server```.

#### Example:

The domain controller functionality represents the highest possible functional level for this domain controller.
```
1> domainFunctionality: 2=(DS_BEHAVIOR_WIN2003)
1> forestFunctionality: 0=(DS_BEHAVIOR_WIN2000)
1> domainControllerFunctionality: 2=(DS_BEHAVIOR_WIN2003)
```


#### Requirements when you manually change the functional level

1. You must change the domain mode to ```native mode``` before you raise the domain level if one of the following conditions is true:

    - The domain functional level is ```programmatically raised``` to the second functional level by directly modifying the value of the msdsBehaviorVersion attribute on the domainDNS object.

    - The domain functional level is raised to the second functional level by using the ```Ldp.exe utility or the Adsiedit.msc utility```.

        If you do not change the domain mode to native mode before you raise the domain level, the operation is not completed successfully, and you receive the following error messages:

    ```
        SV_PROBLEM_WILL_NOT_PERFORM

        ERROR_DS_ILLEGAL_MOD_OPERATION
    ```

Additionally, the following message is logged in the Directory Services log:

Output

```
Active Directory could not update the functional level of the following domain because the domain is in mixed mode.
In this scenario, you can change the domain mode to native mode by using the Active Directory Users & Computers snap-in, by using the Active Directory Domains & Trusts UI MMC snap-in, or by programmatically changing the value of the ntMixedDomain attribute to 0 on the domainDNS object. When this process is used to raise the domain functional level to 2 (Windows Server 2003), the domain mode is automatically changed to native mode
```

        In this scenario, you can change the domain mode to ```native mode``` 
        - by using the Active Directory Users & Computers snap-in, 
        - by using the Active Directory Domains & Trusts UI MMC snap-in, or 
        - by programmatically changing the value of the ntMixedDomain attribute to 0 on the domainDNS object. When this process is used to raise the domain functional level to 2 (Windows Server 2003), the domain mode is automatically changed to native mode.

2. The transition from ```mixed mode to native mode``` changes the scope of the Schema Administrators security group and the Enterprise Administrators security group to ```universal groups```. 


    When these groups have been changed to universal groups, the following message is logged in the System log:

Output: 
```
Event Type: Information  
Event Source: SAM  
Event ID: 16408  
Computer:Server Name  
Description: "Domain operation mode has been changed to Native Mode. The change cannot be reversed."
```

3. When the Windows Server 2003 administrative tools are used to invoke the domain functional level, both the ntmixedmode attribute and the msdsBehaviorVersion attribute are modified in the correct order. However, this does not always occur. In the following scenario, the native mode is implicitly set to a value of 0 without changing the scope for the Schema Administrators security group and the Enterprise Administrators security group to universal:

    - The ```msdsBehaviorVersion``` attribute that controls the domain functional mode is manually or programmatically set to the value of ```2```.

    - The forest functional level is set to 2 by using any method. In this scenario, the Domain controllers block the transition to the forest functional level until all of the domains that are in the local area network are configured to native mode and the required attribute change is made in the security group scopes.


#### Example: Preparation tasks before the level increase
In this example, the environment is raised from Windows Server 2000 mixed mode to Windows Server 2003 forest mode.

Inventory the forest for earlier versions of domain controllers.

If an accurate server list is not available, follow these steps:

1. To discover mixed level domains, Windows Server 2000 domain controllers, or domain controllers with damaged or missing objects, use Active Directory domains and the ```Trusts MMC snap-in```.

2. In the snap-in, click ```Raise Forest Functionality```, and then click ```Save As to generate a detailed report```.

3. If no problems were found, the option to increase to Windows Server 2003 forest level is available from the "Available Forest Functional Levels" drop-down list. 
When you try to raise the ```forest level```, the domain controller objects in the configuration containers are searched for any domain controllers that ```do not have msds-behavior-version``` set to the desired target level. These are assumed to be either Windows Server 2000 domain controllers or newer Windows Server domain controller objects that are damaged.

4. If earlier version domain controllers or domain controllers that have damaged or missing computer objects were found, they are included in the report. The status of these domain controllers must be investigated, and the domain controller representation in Active Directory must be repaired or removed by using the ```Ntdsutil``` file.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:
[216498](https://support.microsoft.com/help/216498) How to remove data in active directory after an unsuccessful domain controller demotion


#### Verify that End to End replication is working in the forest

To verify that End to End replication is working in the forest, use the Windows Server 2003 or newer version of Repadmin against the Windows Server 2000 or the Windows Server 2003 domain controllers:

- For initial inventory.
```
Repadmin/Replsum * /Sort:Delta[/Errorsonly] 
```

- Import to Excel, and then use the Data->Autofilter to identify replication features.
```
Repadmin/Showrepl * /CSV>showrepl.csv
```

Use replication tools such as Repadmin to verify that forest-wide replication is working correctly.
