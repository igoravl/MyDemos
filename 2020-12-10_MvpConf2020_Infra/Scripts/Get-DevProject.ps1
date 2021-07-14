Function Get-DevProject
{
    [CmdletBinding()]
    Param
    (
        [Parameter()]
        $Project = '*'
    )

    End
    {
        Invoke-DevRestApi -Path '_apis/projects' | Where-Object Name -like $Project
    }
}