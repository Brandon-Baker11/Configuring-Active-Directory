# Bulk User Creation and Group Assignment

This will be a demonstration of the Import-UsersFromCSV.ps1 script that I wrote. This script will allow you to create a user and assign them to groups based on the data that is imported from a .csv file.

### Importing the CSV file
Below is the CSV file that will be used to import the list of users and their information from.
> Be sure not to include spaces in the values that you provide, this can cause unexpected errors to occur due to how the data is imported.
<img width="1052" height="882" alt="Screenshot from 2025-07-25 18-02-53" src="https://github.com/user-attachments/assets/63be6ccf-9c7c-4656-be55-17541c34b69a" />


Open the ***Command Prompt*** as Admin and type ***PowerShell*** to enter a PowerShell session
<img width="1052" height="882" alt="Screenshot from 2025-07-25 16-58-48" src="https://github.com/user-attachments/assets/27dda9af-fe30-4a80-81af-37a5b1c7f391" />

Type ***CD*** and the location of where the script is stored.
<img width="1052" height="882" alt="Screenshot from 2025-07-25 17-39-25" src="https://github.com/user-attachments/assets/0b6f8e27-dd70-4b9d-b151-6d2d50eadb21" />

### Run the Script
The command can now be run. Type 
```PowerShell
.\Import-UsersFromCSV.ps1
```
and the script will automate the process of creating new users in Active Directory, include them in their respective OUs and add them to necessary groups as well. As it creates the users, you will see output to the command prompt terminal.
<img width="1052" height="882" alt="Screenshot from 2025-07-25 18-04-35" src="https://github.com/user-attachments/assets/cc01f2e7-f772-4d62-865e-4e48386ee18e" />

And now we can confirm that users were created by running the ***Get-ADUser*** cmdlet and see if their info is generated. To make sure we get all of the users that were created from the data in the .csv file, we can take the imported csv file and pipe it into  a ***foreach-object*** loop and generate the instance for each user account. We'll use the parameter ***-Filter*** to filter our AD users by name.

First we'll need to make sure $csvData is still defined by running 
```PowerShell
$csvData = Import-Csv "C:\Users\bakerbadm\Documents\Scripts\employees.csv"
```
<img width="1052" height="882" alt="Screenshot from 2025-07-25 22-51-18" src="https://github.com/user-attachments/assets/6dd8c77d-1888-490f-9339-798dee92b83a" />

### Verify User Creation
The command to check all of the users is 
```PowerShell
$csvData | ForEach-Object {Get-ADUser -Filter "name -like '$($_.firstName) $($_.lastName)'"}
```
After the command is run, the information for each user will populate like so
<img width="1052" height="882" alt="Screenshot from 2025-07-25 22-56-03" src="https://github.com/user-attachments/assets/ea9a37e0-5c59-4e4a-9e7a-c0b7d88d011f" />

### Check Group Membership
And to double check the users were place in the proper groups, we can use the ***Get-ADGroup*** cmdlet and pipe that into the ***Get-ADGroupMember*** to populate all of the users in a security group. We'll use the following command 
```PowerShell
Get-ADGroup -Identity "Org_Managers" | Get-ADGroupMember
```
<img width="1052" height="882" alt="Screenshot from 2025-07-26 09-55-20" src="https://github.com/user-attachments/assets/dd556df6-847e-4620-a2d1-7868f4eaa41a" />

After running the command, you should get an output of all of the users in the ***Org_managers*** security group like the screenshot below.
<img width="1052" height="882" alt="Screenshot from 2025-07-26 09-57-39" src="https://github.com/user-attachments/assets/e0f2a124-e557-42ee-9f1d-ca7910286959" />





