function 480Banner {
    Write-Host "!!!480-Utils!!!"
}

function 480Connect([string] $server){

    $conn = $global:DefaultVIServer
    #Are we already connected?
    if ($conn){
        $msg = "Already connected to: {0}" -f $conn

        Write-Host -ForegroundColor Green $msg
    }
    else {
        $conn = Connect-VIServer -Server $server
        #If this fails, let Connect-VIServer handle the exception
    }
    
}

function Get-480Config([string] $config_path) {
    Write-Host "Reading " $config_path
    $conf = $null
    if (Test-Path $config_path){
        $conf = (Get-Content -Raw -Path $config_path | ConvertFrom-Json)
        $msg = "Using Configuration at {0}" -f $config_path
        Write-Host -ForegroundColor "Green" $msg

    }
    else {
        Write-Host -ForegroundColor "Yellow" "No Configuration"
    }
    return $conf
    
}

function Select-VM([string] $folder){
    $selected_vm = $null
    try 
    {
        $vms = index number [X] do you wish to pick?"
    #480-TODO need to deal with an invalid index (consider making this a check function)
    $selected_vm = $vms[$pick_index -1]
    Write-Host "You Picked " $selected_vm.name
    #Note this is a full on vm object we can int Get-VM -Location $folder
        $index = 1
        foreach($vm in $vms){
            Write-Host [$index] $vm.name
            $index+=1
    }
    $pick_index = Read-Host "Whicheract with
    return $selected_vm
}
    catch {
        Write-Host "Invalid Folder: $folder" -ForegroundColor "Red"
    }
}


<#function Cloner(){
    $vm = Read-Host -Prompt "Enter name of VM you want to clone: "
    $snapshot = Get-Snapshot  -VM $vm -Name "Base"
    $vmhost = Read-Host -Prompt "Enter the ESXI IP"
    $vmhostselected = Get-VMHost -Name $vmhost
    $datastoresl = Read-Host -Prompt "Enter the name of the datastore"
    $ds = Get-Datastore -Name $datastoresl
    $linkedclone = "{0}.linked" -f $vm.name
    $linkedvm = New-VM -LinkedClone -Name $linkedclone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhostselected -DataStore $ds
    $newvmmei = Read-Host "Name the new VM: "
    $newvm = New-VM -Name $newvmmei -VM $linkedvm -VMHost $vmhostselected -DataStore $ds
    $linkedvm | Remove-VM

}
#>

function SwitchCreation([string] $SwitchName, [string] $PortName){
    try{

    New-VirtualSwitch -VMHost '192.168.7.27' -Name $SwitchName
    Get-VMHost '192.168.7.27' | Get-VirtualSwitch -Name $SwitchName | New-VirtualPortGroup -Name $PortName

    }
    catch{

        Write-Host "Error with creating Switch/Port"

    }


}

function Get-VMInfo([string] $VMName){
    
    $vm = Get-VM -Name $VMName
    $netAdapter = Get-NetworkAdapter -VM $vm | Select-Object -First 1
    $mac = $netAdapter.MacAddress
    $ip = (Get-VM | Where-Object {$_.name -eq $VMName}).Guest.IPAddress[0]
    $vmname = $vm.Name
    $result = @{

        VMName = $VMName
        IPAddr = $ip
        MacAddr = $mac

    }

    return New-Object PSObject -Property $result

}

function StartVM([string] $VMNamae){

    try{
    $vm = Get-VM -Name $VMNamae
    Start-VM $vm
    Write-Host "VM '$VMNamae' started"
    }
    catch{

        Write-Host "Error starting VM check spelling."
    }

}

function SetNetAdapter([string] $vmname, [string] $newnetwork){
    try{
    $nic = Get-VirtualNetwork -Name $newnetwork
    Get-VM -Name $vmname | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $nic
    Write-Output "Network Adapter for '$vmname' set to '$newnetwork'"
    }
    catch {
        Write-Error $_.Exception.Message
    }
    


}

function ClonerV2([string] $sourcevm, [string] $destvm, [string] $destnetwork){
    $vm = Get-VM $sourcevm
    $snapshot = Get-Snapshot -VM $vm -Name "Base"
    $vmhost = Get-VMHost -Name "192.168.7.27"
    $ds = Get-Datastore -Name "datastore2-super17"
    $linkedclone = $destvm
    $linkedvm = New-VM -LinkedClone -Name $linkedclone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -DataStore $ds
    # $newvm = New-VM -Name $destvm -VM $linkedvm -VMHost $vmhost -DataStore $ds
    $newvmnet = Get-NetworkAdapter -VM $linkedvm | Set-NetworkAdapter -NetworkName $destnetwork -Confirm:$false
}

function EditVM([string] $vmname){
    Write-Host "Current VM memory in GB is:" $(Get-VM -Name $vmname).MemoryGB
    Write-Host "Current VM CPU core count is:" $(Get-VM -Name $vmname).CoresPerSocket
    $vm = Get-VM -Name "$vmname"
    $memUpgrade = Read-Host "Do you want to change the memory of the VM (y/n)?"
        if ($memUpgrade -eq "y"){
            $memGB = Read-Host "Enter new memory size in GB"
            Set-VM -VM $vm -MemoryGB $memGB
        }
    $cpuUpgrade = Read-Host "Do you want to change the cpu core count of the VM (y/n)?"
        if ($cpuUpgrade -eq "y"){
            $cpucore = Read-Host "Enter the new core count"
            Set-VM -VM $vm -CoresPerSocket $cpucore
        }
    Write-Host "Pronto." -ForegroundColor "yellow"
}
