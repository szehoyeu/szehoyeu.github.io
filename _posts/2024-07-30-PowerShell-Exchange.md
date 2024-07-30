---
title:  "Microsoft-Exchange-Powershell"
date:   2024-07-30 19:00:00 +0000
categories: [Powershell]
tags: [Powershell]
---

![img](/assets/img/ps.png)

![img](/assets/img/ms.png)


---
Ref: 

- [Link](https://www.geeksforgeeks.org/how-to-find-ama-agent-installed-on-azure-virtual-machines-using-kql-query/)

- [Microsoft Learn - PowerShell - FailoverClusters](https://learn.microsoft.com/en-us/powershell/module/failoverclusters/get-clusternode?view=windowsserver2022-ps)

- [Microsoft Learn - PowerShell - Get-ClusterResource](https://learn.microsoft.com/en-us/powershell/module/failoverclusters/get-clusterresource?view=windowsserver2022-ps)

- [Microsoft Learn - PowerShell - Start-ClusterNode](https://learn.microsoft.com/en-us/powershell/module/failoverclusters/start-clusternode?view=windowsserver2022-ps)

---

1. Get specific information about a node
```
Get-ClusterNode -Name "Node1"
```

2. Fileter nodes by status:
```
Get-ClusterNode | Where-Object {$_.State -eq "UP"}
```

3. Check resources owned bu a specific node
```
Get-ClusterNode -Name "Node1" | Get-ClusterResource
```

4. Starts the Cluster service on a node in a failover cluster
```
Start-ClusterNode -Name node3
```
