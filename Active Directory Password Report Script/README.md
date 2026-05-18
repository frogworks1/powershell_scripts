# Active Directory Password Report Script

## Overview
This PowerShell script generates a report of Active Directory users located in the **SPDUsers OU**. It identifies accounts with the **"Password Never Expires"** setting enabled and captures the **pwdLastSet** attribute.

The output is exported to a CSV file for auditing and reporting purposes.

---

## Features
- Queries all users in a specific OU
- Identifies accounts with:
  - Password Never Expires enabled
- Retrieves:
  - SamAccountName
  - Display Name
  - Enabled status
  - pwdLastSet (raw and human-readable)
- Exports results to CSV

---

## Requirements
- Active Directory module for PowerShell
- Domain-joined machine OR RSAT tools installed
- Appropriate permissions to query AD

---

## Script Details

### OU Path

- OU=SPDUsers,DC=kpffspd,DC=lan

### Output Location

- C:\Software\SPDUsers_PasswordReport.csv

### How to Use

1. Open PowerShell as Administrator  
2. Ensure the Active Directory module is available:
   ```powershell
   Import-Module ActiveDirectory
3. Run the script:
   - .\Get-SPDUsersPasswordReport.ps1
  
### Example Use Cases

- Security audits
- Compliance reporting
- Identifying stale or risky accounts
- Password policy enforcement reviews
