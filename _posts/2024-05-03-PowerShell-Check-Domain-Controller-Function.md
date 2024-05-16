---
title:  "PowerShell - Check Domain Controller Functions - DNS, Role, DHCP"
date:   2024-05-03 19:00:00 +0000
categories: [PowerShell]
tags: [PowerShell]
---

![img](/assets/img/ps.png)


---
Ref: 

---

To find out the details of the Domain Controllers. Here's a command that you can use:
```
Get-ADDomainController -Filter *
```


---

To find out if a Domain Controller is functioning as a DNS server. Here’s a simple script that you can use:
```
# Import the required module
Import-Module ActiveDirectory

# Get all domain controllers
$DCs = Get-ADDomainController -Filter *

foreach ($DC in $DCs) {
    # Check if DNS role is installed
    $DNSRole = Get-WmiObject -Class Win32_ServerFeature -ComputerName $DC.Hostname | Where-Object { $_.Name -eq "DNS Server" }

    if ($DNSRole) {
        Write-Output "$($DC.Hostname) is functioning as a DNS server."
    } else {
        Write-Output "$($DC.Hostname) is not functioning as a DNS server."
    }
}
```
Output
```
DC1 is functioning as a DNS server.
DC2 is not functioning as a DNS server.
```

---


To find out if a Domain Controller is functioning as a ```DHCP server```. Here’s a simple script that you can use:
```
# Import the required module
Import-Module ActiveDirectory

# Get all domain controllers
$DCs = Get-ADDomainController -Filter *

foreach ($DC in $DCs) {
    # Check if DHCP role is installed
    $DHCPRole = Get-WmiObject -Class Win32_ServerFeature -ComputerName $DC.Hostname | Where-Object { $_.Name -eq "DHCP Server" }

    if ($DHCPRole) {
        Write-Output "$($DC.Hostname) is functioning as a DHCP server."
    } else {
        Write-Output "$($DC.Hostname) is not functioning as a DHCP server."
    }
}
```
Output
```
DC1 is functioning as a DHCP server.
DC2 is not functioning as a DHCP server.
```

---



To check ```DHCP scopes``` on a Domain Controller functioning as a DHCP server. Here’s a simple script that you can use:

```
# Import the required module
Import-Module ActiveDirectory

# Get all domain controllers
$DCs = Get-ADDomainController -Filter *

foreach ($DC in $DCs) {
    # Check if DHCP role is installed
    $DHCPRole = Get-WmiObject -Class Win32_ServerFeature -ComputerName $DC.Hostname | Where-Object { $_.Name -eq "DHCP Server" }

    if ($DHCPRole) {
        Write-Output "$($DC.Hostname) is functioning as a DHCP server."

        # Get DHCP scopes
        $DHCPScopes = Invoke-Command -ComputerName $DC.Hostname -ScriptBlock { Get-DhcpServerv4Scope }

        foreach ($Scope in $DHCPScopes) {
            Write-Output "Scope ID: $($Scope.ScopeId), Name: $($Scope.Name), Start Range: $($Scope.StartRange), End Range: $($Scope.EndRange)"
        }
    } else {
        Write-Output "$($DC.Hostname) is not functioning as a DHCP server."
    }
}

```

Output
```
DC1 is not functioning as a DHCP server.

DC2 is not functioning as a DHCP server.

DC3 is functioning as a DHCP server.
Scope ID: 10.1.11.0, Name: Computers, Start Range: 10.1.11.10, End Range: 10.1.12.254
Scope ID: 10.1.13.0, Name: Voice, Start Range: 10.1.13.100, End Range: 10.1.14.254
Scope ID: 10.1.15.0, Name: WIRELESS, Start Range: 10.1.15.12, End Range: 10.1.15.254

DC4 is functioning as a DHCP server.
Scope ID: 10.30.7.0, Name: Wireless, Start Range: 10.30.7.50, End Range: 10.30.8.254
Scope ID: 10.30.13.0, Name: Voice, Start Range: 10.30.13.50, End Range: 10.30.14.200
Scope ID: 10.30.25.0, Name: Clients, Start Range: 10.30.25.60, End Range: 10.30.26.254

DC5 is functioning as a DHCP server.
```

---

Transferring a DHCP server and its scopes to another Domain Controller involves exporting the DHCP server configuration from the source server and then importing it on the destination server. Here’s how you can do it using PowerShell:

#### Step 1: Export the DHCP Server configuration on the source server

This command exports the DHCP server configuration, including the scopes and leases, to an XML file at the specified path.

```
# Run this on the source DHCP server
$exportPath = "C:\Temp\DHCPConfig.xml"
Export-DhcpServer -File $exportPath -Leases -Force
```

#### Step 2: Import the DHCP Server configuration on the destination server

This command imports the DHCP server configuration from the XML file to the destination server. The -BackupPath parameter specifies the location where a backup of the current DHCP server configuration is stored before the import operation.

```
# Run this on the destination DHCP server
$importPath = "C:\Temp\DHCPConfig.xml"
Import-DhcpServer -File $importPath -BackupPath C:\Temp\ -Leases -Force
```
#### Note:

- You need to have the necessary permissions to execute these commands.
- Replace "C:\Temp\DHCPConfig.xml" with the actual path where you want to save the exported configuration file.
- You need to copy the exported XML file from the source server to the destination server before running the import command.
- These commands should be run from a machine that has the DHCP Server role installed.
- Make sure to stop the DHCP Server service on the source server before starting the service on the destination server to avoid IP conflicts.

