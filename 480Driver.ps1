Import-Module '480-Utils' -Force
#Call the Banner function
480Banner
#$conf = Get-480Config -config_path = "/home/admin/Documents/480.json"
#480Connect -server vcenter.bryan.local
#Write-Host "Selecting your VM"
#Select-VM -folder "BASEVM"
#Cloner
#SwitchCreation -SwitchName "Blue17" -PortName "BluePort17"
#Get-VMInfo -VMName "BlueDC1"
#StartVM -VMNamae "BlueDC1"
#SetNetAdapter -vmname 'blue1-fw' -newnetwork '480-WAN'
#for ($i = 1; $i -le 3; $i++) {
#    ClonerV2 -sourcevm "ubuntu-SERVER" -destvm "UbuntuAns-$i" -destnetwork "BluePort17"
#}
#ClonerV2 -sourcevm "Win10" -destvm "BlueWKS1" -destnetwork "BluePort17"
#EditVM -vmname "UbuntuAns-1"
#$GuestPassword = Read-Host "Enter the password" -AsSecureString
#$clearpass = [System.Net.NetworkCredential]::new('',$GuestPassword).Password
#SetWinIP -VMName "BlueDC1" -GuestUser "deployer" -Guestpass $clearpass -IP "10.0.5.5" -Subnet "255.255.255.0" -Gateway "10.0.5.2" -Nameserver "10.0.5.2"
