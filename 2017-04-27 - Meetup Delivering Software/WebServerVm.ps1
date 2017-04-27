Configuration BuildVM {

    param
    (
        [Parameter()]
        [string]
        $HostName = 'localhost',

        [Parameter(Mandatory=$true)]
        [string]
        $VmName
    )

    Import-DscResource -ModuleName PsDesiredStateConfiguration
    Import-DscResource -ModuleName xHyper-V

    Node $HostName {

        xVHD MyVHD {
            Ensure      = 'Present'
            Name        = 'Drive-C.vhd'
            Path        = 'D:VHD'
            Generation  = 'vhd'
            ParentPath  = 'D:\VHD\Template\en-windows-server-2016-datacenter.vhd' 
            MaximumSizeBytes     = 127GB
        }
    }
}
