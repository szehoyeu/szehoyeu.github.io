---
title:  "PowerShell"
date:   2024-04-02 19:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---




---
Ref: 

---

- CSV - Import/Export

```
$csv = Get-Content -Path C:\Users\user\Desktop\ip.txt -Raw

$output | Out-File -filepath "C:\Users\user\Desktop\FileName-Out.txt"
```

- List all the DC
```
Get-ADDomainController -filter * | Select-Object name
```

- Replication of all Domain Controllers
```
 repadmin /syncall
```
- Forcing Replication for Read-Only Domain Controllers

Forcing Replication for Read-Only Domain Controllers
If the Active Directory forest includes read-only domain controllers, you should force replications when adding or modifying users and groups in a zone. Forcing replication ensures that the new information is available right away.

![img](/assets/img/ps01.png)
To force replication after updating a zone:

1. Click Start > Administrative Tools > Active Directory Sites and Services.

2. Expand Sites, then select the Active Directory site that contains the connection over which you want to replicate directory information.
For example, select Default-First-Site-Name.

3. Expand Servers, then select the read-only domain controller for which you want to force replication.

4. Click NTDS Settings.

5. In the details pane, right-click the connection over which you want to replicate directory information, then click Replicate Now.

If you choose not to force replication, the changes made to the zone will not take effect until replication is complete for the forest.

