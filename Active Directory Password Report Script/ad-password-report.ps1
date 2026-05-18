# -----------------------------------------------
# Active Directory Password Report Script
# -----------------------------------------------
# Description:
# This script retrieves all users from the SPDUsers OU,
# checks whether "Password Never Expires" is enabled,
# and pulls the pwdLastSet attribute. The results are
# exported to a CSV file.
# -----------------------------------------------

# Define the OU path to search under
# (Based on your existing scripts using SPDUsers OU)
$OUPath = "OU=SPDUsers,DC=kpffspd,DC=lan"

# Define the output file location
# Make sure this folder exists before running the script
$csvFilePath = "C:\Software\SPDUsers_PasswordReport.csv"

# Retrieve all users from the specified OU
# We explicitly request additional properties:
# - PasswordNeverExpires → corresponds to the checkbox in AD
# - pwdLastSet → raw timestamp of last password set
# - Enabled → account status
# - DisplayName and SamAccountName for reporting
$users = Get-ADUser -Filter * `
    -SearchBase $OUPath `
    -Properties PasswordNeverExpires, pwdLastSet, Enabled, DisplayName, SamAccountName

# Initialize and build the report data
# Using a foreach loop to transform each user object
$userData = foreach ($user in $users) {

    # Convert pwdLastSet from AD FileTime format to human-readable DateTime
    # If value is 0, it means password has never been set
    $pwdLastSetReadable = if ($user.pwdLastSet -ne 0) {
        [datetime]::FromFileTime($user.pwdLastSet)
    } else {
        $null
    }

    # Create a structured object for export
    # This ensures clean column names in the CSV output
    [PSCustomObject]@{
        "SamAccountName"            = $user.SamAccountName
        "Display Name"              = $user.DisplayName
        "Enabled"                   = $user.Enabled
        "Password Never Expires"    = $user.PasswordNeverExpires
        "pwdLastSet (Raw)"          = $user.pwdLastSet
        "pwdLastSet (Readable)"     = $pwdLastSetReadable
    }
}

# Export the results to a CSV file
# -NoTypeInformation removes extra header metadata
$userData | Export-Csv -Path $csvFilePath -NoTypeInformation

# Output confirmation message to console
Write-Output "Report successfully exported to $csvFilePath"
