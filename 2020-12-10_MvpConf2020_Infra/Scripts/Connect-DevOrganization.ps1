Function Connect-DevOrganization
{
    [CmdletBinding()]
    param
    (
        [Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [uri]
        $Organization,

        [Parameter(Position=1, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Alias("PAT")]
        [object]
        $PersonalAccessToken
    )
    
    end
    {
        $global:AzdevOrganization = $Organization

        $patBytes = [System.Text.Encoding]::Default.GetBytes(':' + $PersonalAccessToken.ToString())
        # $encodedPat = (ConvertTo-SecureString -String ('Basic ' + [System.Convert]::ToBase64String($patBytes)) -AsPlainText -Force)
        $encodedPat = 'Basic ' + [System.Convert]::ToBase64String($patBytes)
        
        $global:AzDevToken = $encodedPat
    }
}