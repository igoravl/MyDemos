Function Invoke-DevRestApi
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Position=0, Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter(Position=1)]
        [object]
        $Body,

        [Parameter()]
        [ValidateSet('GET', 'POST', 'PUT', 'DELETE', 'PATCH')]
        [string]
        $Method = 'GET',

        [Parameter()]
        [string]
        $ApiVersion = '6.0',

        [Parameter()]
        [hashtable]
        $AdditionalHeaders,

        [Parameter()]
        [switch]
        $Raw
    )

    Begin
    {
        if((-not $global:AzdevOrganization) -or (-not $global:AzdevToken))
        {
            throw 'Missing connection information. Call Connect-DevOrganization prior to using this command'
        }
    }

    End
    {
        $uriBuilder = [UriBuilder]::new($global:AzdevOrganization.AbsoluteUri.TrimEnd('/') + '/' + $Path.Trim('/'))

        if($AdditionalHeaders -isnot [hashtable])
        {
            $AdditionalHeaders = @{}
        }

        if(-not $AdditionalHeaders.ContainsKey('Authorization'))
        {
            $AdditionalHeaders.Add('Authorization', $global:AzdevToken.ToString())
        }

        if(-not $uriBuilder.Query)
        {
            $uriBuilder.Query = "?api-version=$ApiVersion"
        }
        elseif(-not $url.Query.Contains('api-version'))
        {
            $uriBuilder.Query += "&api-version=$ApiVersion"
        }

        if(($Body) -and ($Body -isnot [string]))
        {
            $Body = (ConvertTo-Json -InputObject $Body)
        }

        Write-Verbose "[Invoke-DevRestApi] Invoking $($uriBuilder.ToString())"

        $Result = Invoke-RestMethod -Uri $uriBuilder.ToString() -Method $Method -Body $Body -Headers $AdditionalHeaders

        if($Raw)
        {
            return ConvertTo-Json $Result
        }

        return $Result.Value
    }
}