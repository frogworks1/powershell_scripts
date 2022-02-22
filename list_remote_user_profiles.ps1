# List remote user profile(s) using powershell

Get-WmiObject -Class Win32_UserProfile -Computer $computer | Where-Object {$_.Special -ne 'Special'} | Select-Object LocalPath, Loaded