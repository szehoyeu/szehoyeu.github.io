
# Software detection scripts if the software needs to update
# Author: Anthony Yeung
# Date: 2024-02-19

# Help Intuen System to find winget.exe
$WinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
$WinGetPathExe = $WinGetResolve[-1].Path

$WinGetPath = Split-Path -Path $WinGetPathExe -Parent
set-location $WinGetPath

# Variables - Input
$AppId = 'Zoom.Zoom'
$AppName = "Zoom"

## check locally installed Zoom
$localInstalled_software = .\winget.exe list -e --id $AppId --accept-source-agreements

# Logic 
# If result contain Avaliable, the application needs to upgrade the version
# If result only contain Version, the application is the latest version 
# If result don't show anything, the application is not installed

$available= (-split $localInstalled_software[-3])[-2]

Write-Host $available

## check if needs update
if ($available -eq 'Available'){
    write-host "$AppName is installed but not the latest version, needs an update"
    exit 1
}

if ($available -eq 'Version'){
    write-host "$AppName is installed but not the latest version, needs an update"
    exit 0
}
if (!$available){
    write-host "$AppName is not installed"
    exit 0
}
