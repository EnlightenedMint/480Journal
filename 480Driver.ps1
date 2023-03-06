Import-Module '480-Utils' -Force
#Call the Banner function
480Banner
$conf = Get-480Config -config_path = "/home/admin/Documents/480.json"
480Connect -server $conf.vcenter_server
Write-Host "Selecting your VM"
Select-VM -folder "BASEVM"
Cloner