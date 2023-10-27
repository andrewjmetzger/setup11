Set-ExecutionPolicy Bypass -Scope CurrentUser

Install-Module -Name PSWindowsUpdate
Import-Module -Name PSWindowsUpdate

Reset-WUComponents

Add-WUServiceManager -ServiceID "7971f918-a847-4430-9279-4a52d1efe18d" -AddServiceFlag 7
Get-WUList -MicrosoftUpdate

Install-WindowsUpdate -AcceptAll -IgnoreReboot

Restart-Computer