---
title:  "Microsoft Entra version 2 cmdlets for group management"
date:   2024-04-02 19:00:00 +0000
categories: [Microsoft]
tags: [Graph]
---

![img](/assets/img/ms-learn.png)  


---
Ref: 

- [Microsoft Entra version 2 cmdlets for group management](https://learn.microsoft.com/en-us/entra/identity/users/groups-settings-v2-cmdlets)

- [Microsoft Graph - Get-MgGroupMember](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/get-mggroupmember?view=graph-powershell-1.0)

- [Microsoft Graph - Get-MgDevice](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.identity.directorymanagement/get-mgdevice?view=graph-powershell-1.0)

- [Microsoft Graph - Get-MgUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/get-mguser?view=graph-powershell-1.0)

---

Requirement:

Install the Microsoft Graph PowerShell module
To install the MgGroup PowerShell module, use the following commands:

PowerShell
```
PS C:\Windows\system32> Install-module Microsoft.Graph
```
To verify that the module is ready to use
```
PS C:\Windows\system32> Get-Module -Name "*graph*"

ModuleType Version    PreRelease Name                                ExportedCommands
---------- -------    ---------- ----                                ----------------
Script     1.27.0                Microsoft.Graph.Authentication      {Add-MgEnvironment, Connect-MgGraph, Disconnect-MgGraph, Get-MgContext…}
Script     1.27.0                Microsoft.Graph.Groups              {Add-MgGroupDriveListContentTypeCopy, Add-MgGroupDriveListContentTypeCopyF…

```

Connect to Graph
```
Connect-MgGraph -Scopes "Group.ReadWrite.All"
```
```
Welcome To Microsoft Graph!
```

Retrieve Groups
```
# Retrieve Groups
Get-MgGraph -All

# Retrieve group by Group ID
Get-MgGroup -GroupId 5e3eba05-6c2b-4555-9909-c08e997aab18 | fl
    
# Retrieve group by DisplayName
Get-MgGroup -Filter "DisplayName eq 'Intune Administrators'"
```

Create Groups
```
 $param = @{
 description="My Demo Group"
 displayName="DemoGroup"
 mailEnabled=$false
 securityEnabled=$true
 mailNickname="Demo"
}

New-MgGroup @param
```

Update Groups
```
# Update Groups
# Step 1 - Get the group informationi - GroupId or etc
Get-MgGroup -Filter "DisplayName eq 'Intune Administrators'"
# Step 2 - Update the group properties
Update-MgGroup -GroupId 958d212c-14b0-43d0-a052-d0c2bb555b8b -Description "Demo Group Updated"
# Step 3 - Check the update - take effect?
Get-MgGroup -GroupId 958d212c-14b0-43d0-a052-d0c2bb555b8b | select displayname, description

```

Delete Groups
```
# Delete Group
# Step 1 - Get the GroupId or etc..information 
Get-MgGroup -Filter "DisplayName eq 'Intune Administrators'"
# Step 2 - Remove the group
Remove-MgGroup -GroupId 958d212c-14b0-43d0-a052-d0c2bb555b8b
```

[Microsoft Graph - PowerShell v1.0](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.groups/get-mggroupmember?view=graph-powershell-1.0)


Get-MgGroupMemeber - Syntax
```
Get-MgGroupMember
   -GroupId <String>
   [-ExpandProperty <String[]>]
   [-Filter <String>]
   [-Property <String[]>]
   [-Search <String>]
   [-Skip <Int32>]
   [-Sort <String[]>]
   [-Top <Int32>]
   [-ConsistencyLevel <String>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-PageSize <Int32>]
   [-All]
   [-CountVariable <String>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```
Get-MgUser - Syntax
```
Get-MgUser
   [-ExpandProperty <String[]>]
   [-Property <String[]>]
   [-Filter <String>]
   [-Search <String>]
   [-Sort <String[]>]
   [-Top <Int32>]
   [-ConsistencyLevel <String>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-PageSize <Int32>]
   [-All]
   [-CountVariable <String>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```
```
Get-MgUser
   -UserId <String>
   [-ExpandProperty <String[]>]
   [-Property <String[]>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```
```
Get-MgUser
   -InputObject <IUsersIdentity>
   [-ExpandProperty <String[]>]
   [-Property <String[]>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```

Get-MgDevice - Syntax
```
Get-MgDevice
   [-ExpandProperty <String[]>]
   [-Property <String[]>]
   [-Filter <String>]
   [-Search <String>]
   [-Skip <Int32>]
   [-Sort <String[]>]
   [-Top <Int32>]
   [-ConsistencyLevel <String>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-PageSize <Int32>]
   [-All]
   [-CountVariable <String>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```
```
Get-MgDevice
   -DeviceId <String>
   [-ExpandProperty <String[]>]
   [-Property <String[]>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```
```
Get-MgDevice
   -InputObject <IIdentityDirectoryManagementIdentity>
   [-ExpandProperty <String[]>]
   [-Property <String[]>]
   [-ResponseHeadersVariable <String>]
   [-Headers <IDictionary>]
   [-ProgressAction <ActionPreference>]
   [<CommonParameters>]
```

```
Get-MgDevice | Get-Member | FT
```
```
Name                          MemberType            Definition                                                                                                                                                                                                   
----                          ----------            ----------                                                                                                                                                                                                   
Add                           Method                void Add(string key, System.Object value), void IAssociativeArray[Object].Add(string key, System.Object value)                                                                                               
Clear                         Method                void Clear(), void IAssociativeArray[Object].Clear()                                                                                                                                                         
ContainsKey                   Method                bool ContainsKey(string key), bool IAssociativeArray[Object].ContainsKey(string key)                                                                                                                         
CopyFrom                      Method                void CopyFrom(System.Collections.IDictionary source), void CopyFrom(psobject source)                                                                                                                         
Equals                        Method                bool Equals(System.Object obj)                                                                                                                                                                               
GetHashCode                   Method                int GetHashCode()                                                                                                                                                                                            
GetType                       Method                type GetType()                                                                                                                                                                                               
Remove                        Method                bool Remove(string key), bool IAssociativeArray[Object].Remove(string key)                                                                                                                                   
ToJson                        Method                Microsoft.Graph.PowerShell.Runtime.Json.JsonNode, Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 ToJson(Microsoft.Graph.PowerShe...
ToJsonString                  Method                string ToJsonString()                                                                                                                                                                                        
ToString                      Method                string ToString()                                                                                                                                                                                            
TryGetValue                   Method                bool TryGetValue(string key, [ref] System.Object value), bool IAssociativeArray[Object].TryGetValue(string key, [ref] System.Object value)                                                                   
Validate                      Method                System.Threading.Tasks.Task Validate(Microsoft.Graph.PowerShell.Runtime.IEventListener, Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad...
EntityItem                    ParameterizedProperty System.Object EntityItem(string index) {get;set;}                                                                                                                                                            
Item                          ParameterizedProperty System.Object IAssociativeArray[Object].Item(string index) {get;set;}                                                                                                                                        
AccountEnabled                Property              System.Nullable[bool] AccountEnabled {get;set;}                                                                                                                                                              
AdditionalProperties          Property              System.Collections.Generic.IDictionary[string,System.Object] AdditionalProperties {get;}                                                                                                                     
AlternativeSecurityIds        Property              Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAlternativeSecurityId[], Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 Alterna...
ApproximateLastSignInDateTime Property              System.Nullable[datetime] ApproximateLastSignInDateTime {get;set;}                                                                                                                                           
ComplianceExpirationDateTime  Property              System.Nullable[datetime] ComplianceExpirationDateTime {get;set;}                                                                                                                                            
DeletedDateTime               Property              System.Nullable[datetime] DeletedDateTime {get;set;}                                                                                                                                                         
DeviceCategory                Property              string DeviceCategory {get;set;}                                                                                                                                                                             
DeviceId                      Property              string DeviceId {get;set;}                                                                                                                                                                                   
DeviceMetadata                Property              string DeviceMetadata {get;set;}                                                                                                                                                                             
DeviceOwnership               Property              string DeviceOwnership {get;set;}                                                                                                                                                                            
DeviceVersion                 Property              System.Nullable[int] DeviceVersion {get;set;}                                                                                                                                                                
DisplayName                   Property              string DisplayName {get;set;}                                                                                                                                                                                
EnrollmentProfileName         Property              string EnrollmentProfileName {get;set;}                                                                                                                                                                      
EnrollmentType                Property              string EnrollmentType {get;set;}                                                                                                                                                                             
Extensions                    Property              Microsoft.Graph.PowerShell.Models.IMicrosoftGraphExtension[], Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 Extensions {get;set;} 
Id                            Property              string Id {get;set;}                                                                                                                                                                                         
IsCompliant                   Property              System.Nullable[bool] IsCompliant {get;set;}                                                                                                                                                                 
IsManaged                     Property              System.Nullable[bool] IsManaged {get;set;}                                                                                                                                                                   
IsRooted                      Property              System.Nullable[bool] IsRooted {get;set;}                                                                                                                                                                    
ManagementType                Property              string ManagementType {get;set;}                                                                                                                                                                             
Manufacturer                  Property              string Manufacturer {get;set;}                                                                                                                                                                               
MdmAppId                      Property              string MdmAppId {get;set;}                                                                                                                                                                                   
MemberOf                      Property              Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[], Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 MemberOf {get...
Model                         Property              string Model {get;set;}                                                                                                                                                                                      
OnPremisesLastSyncDateTime    Property              System.Nullable[datetime] OnPremisesLastSyncDateTime {get;set;}                                                                                                                                              
OnPremisesSecurityIdentifier  Property              string OnPremisesSecurityIdentifier {get;set;}                                                                                                                                                               
OnPremisesSyncEnabled         Property              System.Nullable[bool] OnPremisesSyncEnabled {get;set;}                                                                                                                                                       
OperatingSystem               Property              string OperatingSystem {get;set;}                                                                                                                                                                            
OperatingSystemVersion        Property              string OperatingSystemVersion {get;set;}                                                                                                                                                                     
PhysicalIds                   Property              string[] PhysicalIds {get;set;}                                                                                                                                                                              
ProfileType                   Property              string ProfileType {get;set;}                                                                                                                                                                                
RegisteredOwners              Property              Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[], Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 RegisteredOwn...
RegisteredUsers               Property              Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[], Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 RegisteredUse...
RegistrationDateTime          Property              System.Nullable[datetime] RegistrationDateTime {get;set;}                                                                                                                                                    
SystemLabels                  Property              string[] SystemLabels {get;set;}                                                                                                                                                                             
TransitiveMemberOf            Property              Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[], Microsoft.Graph.Identity.DirectoryManagement.private, Version=2.16.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35 TransitiveMem...
TrustType                     Property              string TrustType {get;set;} 
```




Get the Device from intune (Filter Enabled Accounts)
```
$devices = Get-MgDevice | where-object AccountEnabled -eq $true  | Format-List Id, AccountEnabled, DeviceID, DisplayName | ft
```
---