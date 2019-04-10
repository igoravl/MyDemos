param
(
    [Parameter(Mandatory=$true)]
    [string] $VmName,

    [string] $HostName = 'localhost',

    [int]    $ProcessorCount = 1,

    [long]   $MemorySize = 2GB,

    [string] $VmAdminUserName,
    
    [securestring] $VmAdminPassword
 
)

Configuration HostConfiguration {

    param
    (
        [Parameter(Mandatory=$true)]
        [string]
        $VmName,

        [string]
        $HostName = 'localhost',

        [int]
        $ProcessorCount = 1,

        [long]
        $MemorySize = 2GB,

        [string]
        $VmAdminUserName,
    
        [securestring]
        $VmAdminPassword
    )

    Import-DscResource -ModuleName PsDesiredStateConfiguration
    Import-DscResource -ModuleName xHyper-V

    Node $HostName {

        File VhdDir {
            DestinationPath = "D:VHD\$VmName"
            Type = 'Directory'
        }

        xVHD VmVhd {
            Ensure      = 'Present'
            Name        = "Drive-C.vhd"
            Path        = "D:\VHD\$VmName"
            Type        = 'Differencing'
            Generation  = 'vhd'
            ParentPath  = 'D:\VHD\Template\en-windows-server-2016-datacenter-base.vhd' 
            DependsOn   = '[File]VhdDir'
        }

        xVMHyperV CreateVm {
            Ensure = 'Present'
            DependsOn = '[xVHD]VmVhd' ## Ensures the that VHD is created first
            Name = $VmName
            VhdPath = "D:\VHD\$VmName\Drive-C.vhd" ## To use the VHD that was created above
            SwitchName = 'Internal Virtual Switch' ## Use an already built virtual switch called LabSwitch
            State = 'Running' ## When finished, start up the VM
            Path = "D:\Hyper-V" ## Place the VM on the file system at C:VMs
            Generation = 1 ## This will be an older generation VM
            StartupMemory = $MemorySize ## It will have 2GB of memory
            ProcessorCount = $ProcessorCount ## It will have a single processor
            WaitForIP = $true
            RestartIfNeeded = $true
        }
    }
}

Configuration VmConfiguration {

    param(
        [string]
        $VmName,

        [string]
        $VmIpAddress
    )

    Import-DscResource -ModuleName PsDesiredStateConfiguration
    Import-DscResource -ModuleName xComputerManagement

    Node $VmIpAddress {

        xComputer VmName {
            Name = $VmName
        }

        WindowsFeature IIS 
        { 
            Ensure = 'Present'
            Name = 'Web-Server'
        } 

        WindowsFeature IisManager 
        { 
            Ensure = 'Present'
            Name = 'Web-Mgmt-Console'
            DependsOn = '[WindowsFeature]IIS'
        } 

        WindowsFeature WebManagementService
        {
            Ensure = "Present"
            Name = "Web-Mgmt-Service"
            DependsOn = '[WindowsFeature]IIS'
        }

        WindowsFeature ASP 
        { 
            Ensure = 'Present'
            Name = 'Web-Asp-Net45'
            DependsOn = '[WindowsFeature]IIS'
        }

        LocalConfigurationManager {
            RebootNodeIfNeeded = $True
        }
    }
}

$vmcreds = New-Object System.Management.Automation.PSCredential($VmAdminUserName, $VmAdminPassword)

HostConfiguration @PSBoundParameters
Start-DscConfiguration -Path "$PSScriptRoot\HostConfiguration" -Force -Wait

$ipAddress = (Get-VMNetworkAdapter -VMName $VmName).IpAddresses[0]
Set-Item wsman:\localhost\Client\TrustedHosts -Value $ipAddress -Force

VmConfiguration -VmName $VmName -VmIpAddress $ipAddress

$cimSession = New-CimSession -ComputerName $ipAddress -Credential $vmcreds
Set-DscLocalConfigurationManager -CimSession $cimSession -Path "$PSScriptRoot\VmConfiguration"

Start-DscConfiguration -Path "$PSScriptRoot\VmConfiguration" -Force -Wait -CimSession $cimSession
