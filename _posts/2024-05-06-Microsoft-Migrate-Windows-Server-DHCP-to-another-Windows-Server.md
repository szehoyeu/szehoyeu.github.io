---
title:  "Microsoft - Migrate DHCP server to another Windows Server"
date:   2024-05-06 14:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---

![img](/assets/img/ps.png)

![img](/assets/img/ms.png)


---
Ref: 



- [Link](https://www.youtube.com/watch?v=d7Ocqlav5jo)

---

Before migration to the new server:

1. Install features to DHCP feature to the new server via Server Manager.

2. Export the DHCP scope from the existing DHCP server. 
   - copy the exported xml file the new server  

```
Export-DhcpServer -ComputerName "Server1.fqdn.com" -File "C:\temp\dhcp.xml" -Leases -Force
```

3. Stop the current DHCP server

    ![img](/assets/img/dhcp01.png)

4. Disable the "DCHP Server" services

5. On the new server, 
    - Import the DHCP scope 
```
Import-DhcpServer -ComputerName "Server2.fqdn.com" -File "C:\temp\dhcp.xml" -Leases -Force
```
    - Enter the backup path: C:\temp\DHCP-backup.xml
    - Click yes

6. Test on client PC via ipconfig /all, and ipconfig /release
    - Check the DHCP Server ip address is the same as the new server

7. On the old DHCP, decommision 
    - Right click on the DHCP
    - Select Manage authorized server ...

        ![img](/assets/img/dhcp02.png)

    - Unauthorize the old server

        ![img](/assets/img/dhcp03.png)



