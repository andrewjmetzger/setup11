# Install GPMC
Get-WindowsCapability -Name RSAT*Group* -Online | Add-WindowsCapability -Online

Write-host "Trusting PS Gallery"
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Write-Host "Installing PolicyFileEditor V3"
Install-Module -Name PolicyFileEditor -RequiredVersion 3.0.0 -Scope CurrentUser

$UserDir = "$env:windir\system32\GroupPolicy\User\registry.pol"

Write-Host "Setting `Password protect the screen saver` to on"
$RegPath = 'Software\Policies\Microsoft\Windows\Control Panel\Desktop'
$RegName = 'ScreenSaverIsSecure'
$RegData = '1'
$RegType = 'String'
Set-PolicyFileEntry -Path $UserDir -Key $RegPath -ValueName $RegName -Data $RegData -Type $RegType

Write-Host "Setting `Screen saver timeout` to 5m"

$RegPath = 'Software\Policies\Microsoft\Windows\Control Panel\Desktop'
$RegName = 'ScreenSaveTimeOut'
$RegData = '300'
$RegType = 'String'

Set-PolicyFileEntry -Path $UserDir -Key $RegPath -ValueName $RegName -Data $RegData -Type $RegType

# apply the new policy immediately
gpupdate.exe /force