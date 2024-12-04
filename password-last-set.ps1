Import-Module ActiveDirectory

# Get current date and time
$currentDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

# Get users with passwords older than a year
$users = Get-ADUser -Filter {Enabled -eq $true} -Properties SamAccountName, pwdLastSet | Where-Object {$_.pwdLastSet -lt ([datetime]::Now.AddYears(-1)).ToFileTime()}

# Format the pwdLastSet property as a date in d/m/y format and sort by SamAccountName
$formattedUsers = $users | Select-Object SamAccountName, @{Name='PasswordLastSet'; Expression={[datetime]::FromFileTime($_.pwdLastSet).ToString('dd/MM/yyyy')}} | Sort-Object SamAccountName

# Export to Excel with timestamp
$formattedUsers | Export-Csv -Path "C:\Users\spdadmin\Desktop\Reports\password_reset_output_$currentDate.csv" -NoTypeInformation