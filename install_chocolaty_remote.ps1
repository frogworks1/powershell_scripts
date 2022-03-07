# Change computer name after the -ComputerName to remote machine name where software is being installed.

Invoke-Command -ComputerName win10lab -ScriptBlock {

    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    
        choco feature enable -n allowGlobalConfirmation
    
        }