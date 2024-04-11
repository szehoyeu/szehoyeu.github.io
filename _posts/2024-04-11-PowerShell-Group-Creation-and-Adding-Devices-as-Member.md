---
title:  "PowerShell: Group Creation and adding Devices as member"
date:   2024-04-11 19:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---


![img](/assets/img/ps.png)

---
Ref: 

- [MSOnline](https://learn.microsoft.com/en-us/powershell/module/msonline/?view=azureadps-1.0)

> Azure AD Powershell is planned for deprecation on March 30, 2024. For more details on the deprecation plans, see the deprecation update. We encourage you to continue migrating to Microsoft Graph PowerShell, which is the recommended module for interacting with Azure AD. In addition, [Microsoft Graph PowerShell](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview) allows you access to all Microsoft Graph APIs and is available on PowerShell 7. For answers to frequent migration queries, see the [Migration FAQ](https://learn.microsoft.com/en-us/powershell/module/msonline/migration-faq.yml?view=azureadps-1.0).
{: .prompt-tip }

- [Microsoft Graph](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.identity.directorymanagement/get-mgdevice?view=graph-powershell-1.0)


---




### Task 1 - Create a new group via Microsoft Graph or Azure AD
---

```
######################################################################
# Step 1
# To verify that the module is ready to use
######################################################################
Get-Module -Name "*graph*"

######################################################################
# Step 2
# Connect to Graph
######################################################################
Connect-MgGraph -Scopes "Group.ReadWrite.All"

######################################################################
# Step 3
# Create new group and get the group Id
# Check if the a new group created
######################################################################
$groupName = "NEW-Group-01"

    $param = @{
    description=$groupName
    displayName=$groupName
    mailEnabled=$false
    securityEnabled=$true
    mailNickname=$groupName
    }
New-MgGroup @param

# Get the group Id
$groupId = (Get-MgGroup -Filter "DisplayName eq '$groupName'").Id

# Retrieve group by DisplayName
#Get-MgGroup -Filter "DisplayName eq '$groupName'" | ft
```

---

### Task 2 - Import Device (Only with computer name) to the new group
```
######################################################################
# Step 1
# Import Devices from csv file
# Connect to MS Graph
# Get the Device ID to be added to the new Group
# Ref: https://learn.microsoft.com/en-us/powershell/module/msonline/get-msoldevice?view=azureadps-1.0
# Check number of device added / within the group
######################################################################

# Import Devices from csv file
######################################################################
$csv = Import-Csv -Path "C:\Users\user\Downloads\List-Of-Devices-Name.csv" 

# Get the Device ID
######################################################################
$objectId=@()
foreach($i in $csv){
    $objectId += Get-MgDevice -All | Where-Object AccountEnabled -eq $true| Where-Object OperatingSystem -eq "Windows" | Where-Object DisplayName -eq $i.Name | Select-Object -ExpandProperty Id
}

# Add Devices as member to the Group
######################################################################
foreach($o in $objectId){
    New-MgGroupMember -GroupId  $groupId -DirectoryObjectId $o
}



# Check number of group member in the "Group"
# Ref: https://learn.microsoft.com/en-us/graph/aad-advanced-queries
######################################################################
Get-MgGroupMemberCount -GroupId $groupId -ConsistencyLevel eventual 
```