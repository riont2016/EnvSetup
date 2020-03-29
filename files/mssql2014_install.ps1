Write-Host "Installing SQL Server"
E:\setup.exe /ASSYSADMINACCOUNTS="$env:computername\Administrator" /SQLSYSADMINACCOUNTS="$env:computername\Administrator" /ConfigurationFile=d:\erp\config.ini
