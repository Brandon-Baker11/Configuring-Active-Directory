# Bulk User Creation and Group Assignment

This will be a demonstration of the Import-UsersFromCSV.ps1 script that I wrote. This script will allow you to create a user and assign them to groups based on the data that is imported from a .csv file.

Below is the script that will be used to import the list of users and their information from.
<img width="1052" height="882" alt="Screenshot from 2025-07-25 16-55-23" src="https://github.com/user-attachments/assets/b4def88a-ee59-4fd0-a7c3-60df037ad469" />

Open the ***Command Prompt*** as Admin and type ***PowerShell*** to enter a PowerShell session
<img width="1052" height="882" alt="Screenshot from 2025-07-25 16-58-48" src="https://github.com/user-attachments/assets/27dda9af-fe30-4a80-81af-37a5b1c7f391" />

Type ***CD*** and the location of where the script is.
<img width="1052" height="882" alt="Screenshot from 2025-07-25 17-39-25" src="https://github.com/user-attachments/assets/0b6f8e27-dd70-4b9d-b151-6d2d50eadb21" />

The command can now be run. Type ***.\Import-UsersFromCSV.ps1*** and the script will automate the process of creating new users in Active Directory, include them in their respective OUs and add them to necessary groups as well. As it creates the users, you will see output to the command prompt terminal.
