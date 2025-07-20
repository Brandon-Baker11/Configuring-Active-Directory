# Creating Bulk Organizational Units in Active Directory

This will be a quick demonstration of the OU-BulkGenerator.ps1 script. Before running this script, ensure that there aren't any empty lines in the file that the script pulls from. The OU's will still be created, you will just get a bunch of errors because the path from that line is null (empty)

Below you can see the .txt file that the script pulls the content from.
<img width="1052" height="882" alt="Screenshot from 2025-07-20 13-26-18" src="https://github.com/user-attachments/assets/52325786-3815-4b26-bf86-030544c164ae" />


Open up the Command Prompt as Admin and type ***PowerShell*** to launch a PowerShell session in the terminal.
>You will see a ***PS*** next to the terminal prompt when you're in a PowerShell session
<img width="1052" height="882" alt="Screenshot from 2025-07-20 13-48-57" src="https://github.com/user-attachments/assets/1df6bdbc-a2a6-43aa-bd39-258d5ae71ec6" />


Type ***CD*** and the location where the script is stored
<img width="1052" height="882" alt="Screenshot from 2025-07-20 13-51-54" src="https://github.com/user-attachments/assets/b1a434b8-4a45-446b-9491-fcb04664cbe4" />


Now you can run the command ***.\OU-BulkGenarator.ps1*** and let the script create multiple, nested organizational units for your Active Directory environment
<img width="1052" height="882" alt="Screenshot from 2025-07-20 13-52-55" src="https://github.com/user-attachments/assets/1b656694-b0fb-4bf0-967e-80271f7d205b" />


Once finished you should see an output similar to this:
<img width="1052" height="882" alt="Screenshot from 2025-07-20 13-59-42" src="https://github.com/user-attachments/assets/b3595d97-65eb-4c57-9a47-69e0e5f56134" />



Now to confirm they were created we will check for them in Active Directory Users and Computers. Click the Windows Search box in the taskbar and search for ***Active Directory Users and Computers***. Once it is open you can expand your domain and verify that the OU's and nested OU's were created successfully
<img width="1052" height="882" alt="Screenshot from 2025-07-20 14-01-23" src="https://github.com/user-attachments/assets/cf3c9d05-90da-4ea1-822c-0dd6701c981a" />
