$csvData = Import-Csv "C:\Users\bakerbadm\Documents\Scripts\test.csv"
$userPassword = # Default password for your users
$password = ConvertTo-SecureString $userPassword -AsPlainText -Force
$managerSecGroup = "Org_Managers"

# Creates values for each user that will be created
$csvData | ForEach-Object {
    $firstName = $_.FirstName
    $lastName = $_.LastName
    $upn = "$($_.FirstName).$($_.LastName)@yourorganization.com"
    $department = $_.Department
    $state = $_.State
    $isManager = $_.Manager

    # Ensures that all SAMAccountNames are a predictable length
    if ($lastName.Length -le 6) {
        $samAccountName = ($lastName + $firstName.Substring(0,1)).ToLower()
    }
    else {
        $samAccountName = ($lastName.Substring(0,6) + $firstName.Substring(0,1)).ToLower()
    }

    # Makes sure SAMAccountNames are unique
    if (Get-ADUser -Filter "samaccountname -like '$($samAccountName)'") {
        $counter = 1
        while ($true) {
            $modifiedSAM = $samAccountName + $counter
            if (Get-ADUser -Filter "samaccountname -like '$($modifiedSAM)'") {
                $counter++
            }
            else {
                $samAccountName = $modifiedSAM
                $upn = "$($_.FirstName).$($_.LastName)$($counter)@mycooltestorg.com"
                break
            }
        }
    }

    # Creates the new user
    New-ADUser -Name "$($firstName) $($lastName)" `
        -Path "OU=USERS,OU=$($department),OU=$($state),DC=mycooltestorg,DC=com" `
        -AccountPassword $password `
        -GivenName $firstName `
        -Surname $lastName `
        -SamAccountName $samAccountName `
        -UserPrincipalName $upn `
        -Department $department `
        -State $state `
        -Enabled $true ` 
    
    # Adds to manager group if value in csv file is yes
    if ($isManager -match '^yes$') {
        Add-ADGroupMember -Identity $managerSecGroup -Members $samAccountName
    }
        
    # Adds user to their department's security group based on value in csv file
    switch ($department) {
        "Sales" {Add-ADGroupMember -Identity "Sales_Users" -Members $samAccountName}

        "Human Resources" {Add-ADGroupMember -Identity "HR_Users" -Members $samAccountName}

        "Marketing" {Add-ADGroupMember -Identity "Marketing_Users" -Members $samAccountName}

        "Engineering" {Add-ADGroupMember -Identity "Engineering_Users" -Members $samAccountName}
    }

    # If the account was successfully created, outputs to terminal
    if (Get-ADUser -Filter "samaccountname -like '$samAccountName'") {
        Write-Host "User account created for: $($firstName) $($lastName)" -ForegroundColor Cyan -BackgroundColor Black
    }
    else {
        Write-Host "Error encountered creating account for user: $($firstName) $($lastName)" -ForegroundColor Red -BackgroundColor Black
    }
}

