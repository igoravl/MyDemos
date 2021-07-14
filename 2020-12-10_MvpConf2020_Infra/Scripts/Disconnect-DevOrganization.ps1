Function Disconnect-DevOrganization
{
    [CmdletBinding()]
    param
    (
    )
    
    end
    {
        Remove-Variable -Name 'AzdevOrganization' -Scope Global
        Remove-Variable -Name 'AzdevToken' -Scope Global
    }
}