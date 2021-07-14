foreach($script in (Get-ChildItem $PSScriptRoot -Filter '*.ps1'))
{
    . $script
    Export-ModuleMember -Function $script.BaseName
}