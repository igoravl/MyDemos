Function Get-DevGitRepository
{
    [CmdletBinding()]
    Param
    (
        [Parameter()]
        [string]
        $Repository = '*',

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Project
    )

    End
    {
        Invoke-DevRestApi -Path "$Project/_apis/git/repositories" | Where-Object Name -like $Repository
    }
}