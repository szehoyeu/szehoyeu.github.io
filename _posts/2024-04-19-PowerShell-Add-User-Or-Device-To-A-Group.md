---
title:  "PowerShell-Add User or Device to a Group using MS Graph commands"
date:   2024-04-19 19:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---

![img](/assets/img/ps.png)


---
Ref: 

- [MS Graph - MgDeviceManagementManagedDevice](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.devicemanagement/get-mgdevicemanagementmanageddevice?view=graph-powershell-1.0)


- [MS Graph - MgGroupMember](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/new-mggroupmember?view=graph-powershell-1.0)


---

## Step 1
To verify that the module is ready to use
```
Get-Module -Name "*graph*"
```

## Step 2
Connect to Graph

```
Connect-MgGraph -Scopes "Group.ReadWrite.All"
```
or

```
Connect-MgGraph -Scopes "GroupMember.ReadWrite.All", "User.ReadWrite.All"
```


## Step 3

Create a new Group for Device / User as member
```
$groupNameUser = "Userlist" or "Devicelist"

 $param = @{
 description=$groupName
 displayName=$groupName
 mailEnabled=$false
 securityEnabled=$true
 mailNickname=$groupName
}
New-MgGroup @param
```
Retrieve group by DisplayName
```
Get-MgGroup -Filter "DisplayName eq '$groupName'"
```



Get the group Id of the new Group
```
$groupId = (Get-MgGroup -Filter "DisplayName eq '$groupName'").Id
```


Get all the details of the managed devices from Intune
```
$allDevices = Get-MgDeviceManagementManagedDevice -All |`
              where-object OperatingSystem -eq "Windows" |`
              where-object AzureAdRegistered -eq $true |`
              Select-Object Id, AzureAdDeviceId, AzureAdRegistered, OperatingSystem, Model, DeviceName, UserDisplayName, UserID, UserPrincipalName | fl
```

## Step 4

Import a list of the devices with device name/computer name as follow.

![img](/assets/img/ps02.png)

```
$csv = Import-Csv -Path "C:\Users\userA\Devices.csv" 
```

## Step 5
Get the ObjectId of the Device using DisplayName (ComputerName) from the imported csv file

```
$objectId=@()

foreach($i in $csv){
    $objectId += Get-MgDevice -All |`
                     Where-Object AccountEnabled -eq $true|`
                     Where-Object OperatingSystem -eq "Windows" |`
                     Where-Object DisplayName -eq $i.Name |`
                     Select-Object -ExpandProperty Id  
}
```

Or

Get the UserId of the Device using DisplayName (ComputerName) from the imported csv file
```
$userId=@()

foreach($u in $csv){
    
    $userId += Get-MgDeviceManagementManagedDevice -All |`
              Where-Object DeviceName -eq $u.Name |`
              where-object OperatingSystem -eq "Windows" |`
              where-object AzureAdRegistered -eq $true |`
              Select-Object -ExpandProperty UserID
}

```



## Step 6
Add the Devices to the New Group with the objectId
```
foreach($o in $objectId){
    New-MgGroupMember -GroupId  $groupId -DirectoryObjectId $o
}
```

Or 

Add the Users to the New Group with the userId
```
foreach($u in $userId){
    New-MgGroupMember -GroupId $groupId -DirectoryObjectId $u
}
```
