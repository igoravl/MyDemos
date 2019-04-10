param($serverPrefix, $envName, $dbName, $resourceGroupName, $location = 'Brazil South' $adminUser, $adminPassword)

# Get/create Server

$creds = New-Object System.Management.Automation.PSCredential($adminUser, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))
$serverName = "$serverPrefix-$envName".ToLower()

Write-Output 'Create server $serverName if needed'

$svr = (Get-AzureRmSqlServer -ServerName $serverName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue)

if(-not $svr)
{
    Write-Output 'Server $serverName not found; creating new SQL Server'

    # Create server
    $svr = New-AzureRmSqlServer -ServerName $serverName -ResourceGroupName $resourceGroupName -SqlAdministratorCredentials $creds -Location $location

    $svr | Format-List

    # Add firewall rule to access server from Azure services
    New-AzureRmSqlServerFirewallRule -ServerName $serverName -FirewallRuleName "Azure IPs" -StartIpAddress 0.0.0.0 -EndIpAddress 0.0.0.0 -ResourceGroupName $resourceGroupName
}
else
{
    Write-Output 'Server $serverName already exists; skipping'
}

# Get/create database

$db = (Get-AzureRmSqlDatabase -DatabaseName $dbName -ServerName $serverName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue)

Write-Output 'Create database $dbName if needed'

if (-not $db)
{
    Write-Output 'Database $dbName not found; creating new database'

    # Create database
    New-AzureRmSqlDatabase -DatabaseName $dbName -ServerName $serverName -ResourceGroupName $resourceGroupName
}

# Output server FQDN

Write-Output "Outputting server name $($svr.FullyQualifiedDomainName) to the pipeline as variable 'SqlServerFQDN'"

Write-Host "##vso[task.setvariable variable=SqlServerFQDN;]$($svr.FullyQualifiedDomainName))"
