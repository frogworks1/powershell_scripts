# Remove user profile(s) remotely using powershell.
# In order to remove, remote machine needs to allow firewall exceptions or disable.
# WS-Management service needs to be enabled (set to automatic) and running on remote host before script works.

$Computer = Read-Host "Please Enter Computer Name: "
$user = Read-Host "Enter User ID: "

Invoke-Command -ComputerName $computer -ScriptBlock {
    param($user)
    $localpath = 'c:\users\' + $user
    Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.LocalPath -eq $localpath} | 
    Remove-WmiObject
} -ArgumentList $user