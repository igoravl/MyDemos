param
(
    $Organizacao, 
    $Projeto, 
    $PAT
)

$patBytes = [System.Text.Encoding]::Default.GetBytes(':' + $PAT)
$encodedPat = 'Basic ' + [System.Convert]::ToBase64String($patBytes)

Invoke-RestMethod `
    -Uri "https://dev.azure.com/$Organizacao/$Projeto/_apis/git/repositories/?api-version=6.0" `
    -Method GET `
    -Headers @{Authorization = $encodedPat}
