#Requires -Version 5.1
<#
.SYNOPSIS
    Launches setup for a Windows 11 PC.
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Requires Windows 11.
    Requires PowerShell >= 5.1.
    Requires Administrator rights.
.LINK
    https://github.com/andrewjmetzger/setup11
.EXAMPLE
    iex (irm https://github.com/andrewjmetzger/setup11/raw/main/install.ps1)
#>

if ((Get-ComputerInfo | Select-Object -expand OsName) -notmatch 11) {
    Write-Error "This script requires Windows 11!"
    Exit 1
}

# Download setup11 package
$GH_USER = 'andrewjmetzger'
$GH_REPO = 'setup11'
$GH_BRANCH = 'main'

Push-Location "$env:TEMP"

curl -JLO  "https://github.com/${GH_USER}/${GH_REPO}/archive/refs/heads/${GH_BRANCH}.zip"

Expand-Archive ./"${GH_REPO}-${GH_BRANCH}.zip" -DestinationPath "$env:TEMP" -ErrorAction Stop

Remove-Item ./"${GH_REPO}-${GH_BRANCH}.zip" -ErrorAction Stop

Pop-Location

powershell -Verb RunAs "$env:TEMP\${GH_REPO}-${GH_BRANCH}\"
