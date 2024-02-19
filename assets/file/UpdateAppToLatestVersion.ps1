
# Software remediation scripts to update the software
# Author: Anthony Yeung
# Date: 2024-02-19

# Help Intuen System to find winget.exe
$WinGetResolve = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
$WinGetPathExe = $WinGetResolve[-1].Path

$WinGetPath = Split-Path -Path $WinGetPathExe -Parent
set-location $WinGetPath

# Variables - Input
$AppId = 'Zoom.Zoom'

# link: upgrade options: 
# https://learn.microsoft.com/en-us/windows/package-manager/winget/upgrade
# winget upgrade -e --id $AppId --silent --accept-package-agreements --accept-source-agreements

# Run upgrade of the software
.\winget.exe upgrade -e --id $AppId --silent --accept-package-agreements --accept-source-agreements