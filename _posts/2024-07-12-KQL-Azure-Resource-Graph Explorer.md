---
title:  "Microsoft - KQL- Azure Resource Graph Explorer - Azure Monitoring Agent installed"
date:   2024-05-08 19:00:00 +0000
categories: [KQL]
tags: [KQL]
---

![img](/assets/img/ps.png)

![img](/assets/img/ms.png)


---
Ref: 

- [Link](https://www.geeksforgeeks.org/how-to-find-ama-agent-installed-on-azure-virtual-machines-using-kql-query/)

- [Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-collection-rule-create-edit?tabs=CLI#permissions)


---

To check if the Azure Monitor Agent (AMA) is installed on you Azure Virtual Machines (VMs) using Kusto Query Language (KQL), you can use the following queries in ```Azure Resource Graph Explorer```:

For Both Windows and Linux Azure Virtual Machines

```
resources
//| where type == "microsoft.compute/virtualmachines/extensions"
| extend VMName = split(id, "/")
| where name has "AzureMonitorWindowsAgent" // or name has "AzureMonitorLinuxAgent"
| extend SubscriptionName = case(subscriptionId =~ 'add subscription id', 'add subscription name', subscriptionId)
| project VMName = VMName[-3], AgentName = name, SubscriptionName
```