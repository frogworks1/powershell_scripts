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
