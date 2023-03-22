Import-Module '480-Utils' -Force
#Call the Banner function
480Banner
#$conf = Get-480Config -config_path = "/home/admin/Documents/480.json"
#480Connect -server $conf.vcenter_server
#Write-Host "Selecting your VM"
#Select-VM -folder "BASEVM"
#Cloner
#SwitchCreation -SwitchName "Blue17" -PortName "BluePort17"
Get-VMInfo -VMName "Rocky-3"
#StartVM -VMNamae "Rocky-*"
#SetNetAdapter -vmname 'blue1-fw' -newnetwork '480-WAN'
#for ($i = 1; $i -le 3; $i++) {
#    ClonerV2 -sourcevm "Rocky" -destvm "Rocky-$i" -destnetwork "BluePort17"
#}
