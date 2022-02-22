# List local user profile(s) using powershell

Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.Special -ne 'Special'} | Select-Object LocalPath, Loaded