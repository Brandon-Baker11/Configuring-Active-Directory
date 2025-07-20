Get-Content "C:\Path\to\file.txt" | ForEach-Object { # Gets the content from desired .txt file
    $DomainName = 'DC=yourhomelabdomain,DC=com' # Enter your domain path
    $OrgUnitPath = '' # Placeholder variable
    $OrgUnits = (Split-Path $_ -Parent).Split('\') # Creates an array by splitting each line at the '\' delimiter
    [array]::Reverse($OrgUnits) 
    $OrgUnits | ForEach-Object {
        if ($_.Length -eq 0) {
            return
        }
        $OrgUnitPath = $OrgUnitPath + 'OU=' + $_ + ',' # Updates the empty string to the new $OrgUnitPath
    }
    $OrgUnitPath += $DomainName # Once nested loop is finished, concatenates $DomainName variable to the end of the path

    # Uncomment line below to double check the $OrgUnitPath is what you expect it to be
    #Write-Host "org unit path: $OrgUnitPath" -ForegroundColor Cyan -BackgroundColor Black 
    $NewOrgUnitName = Split-Path $_ -Leaf
    # Uncomment line below to confirm the $NewOrgUnitName is what you expect it to be
    #Write-Host "new org unit name: $NewOrgUnitName`n" -ForegroundColor White -BackgroundColor Black

    New-ADOrganizationalUnit -Name $NewOrgUnitName -path $OrgUnitPath -ProtectedFromAccidentalDeletion $false
    Write-Host "Successfully Created OU 'OU=$NewOrgUnitName,$OrgUnitPath'" -ForegroundColor Green -BackgroundColor Black
    Get-ADOrganizationalUnit -Identity "OU=$NewOrgUnitName,$OrgUnitPath"
}
