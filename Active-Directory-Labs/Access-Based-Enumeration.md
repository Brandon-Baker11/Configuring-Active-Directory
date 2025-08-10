# Enabling Access-Based Enumeration


## Lab Overview
This lab will cover implementing a security feature offered in Windows that is called Access-Based Enumeration (ABE). I'll enable it for both network shared folders and Distributed File System (DFS) folders.


## What is Access-Based Enumeration?
It simplifies the user's experience by hiding shared network folders they don't have permissions to view. This makes it so only the folders and files they are authorized to interact with appear when browsing a shared network folder. ABE filters folders and files based on NTFS permissions that users/groups have. If they don't at least have **Read** permissions, the folder will not be displayed to them. Here are some benefits of implementing ABE in a production environment:
- ABE keeps sensitive data from being accessed from unauthorized users by limiting visibility.
- Users have a simpler interface when interacting with shared network folders.
- ABE can reduce the "noise" in complex folder structures by hiding irrelevant folders.


## Tasks
- [Enable ABE for Network Shared Folders](#shared-folder)
- [Confirm ABE Configuration on Shared Folder](#confirm-shared)
- [Enable ABE for DFS Folders](#dfs)
- [Set DFS Access Permissions](#permissions)
- [Confirm ABE DFS Configuration on DFS Folder](#confirm-dfs)


<a name="shared-folder"></a>
## Enable ABE for Network Shared Folders
I am currently logged in as a user on my client machine. This user only has access to the **IT** folder in my **Public Share** shared folder. You can see the message that I get when I try to access a different folder.
<img width="1072" height="898" alt="Screenshot from 2025-08-10 12-50-47" src="https://github.com/user-attachments/assets/c1799cff-e60e-4ad8-b306-7f1dc7b74019" />

<a name="enable-abe-server-man"></a>
To make things a bit cleaner we will enable Access-Based Enumeration on the shared folder. Open the **Server Manager** and select **File and Storage Services**
<img width="1042" height="792" alt="Screenshot from 2025-08-10 12-55-08" src="https://github.com/user-attachments/assets/0cb8a1e8-eed0-4dc2-b2e5-56fe7f21fa47" />


Click **Shares**, right-click on the share you want to enable ABE on and select **Properties**
<img width="1042" height="792" alt="Screenshot from 2025-08-10 13-06-40" src="https://github.com/user-attachments/assets/3271fea7-ba89-4aea-a0e7-36606025176d" />


Click **Settings** and check the box **Enable access-based enumeration**. Click **Apply**
<img width="1042" height="792" alt="Screenshot from 2025-08-10 13-10-06" src="https://github.com/user-attachments/assets/3da8a560-60cf-4815-b418-f2233aafeaf8" />


<a name="confirm-shared"></a>
## Confirm ABE Configuration on Shared Folder
Going back to the client machine. To verify that the ABE was setup properly, you need to sign out and sign back in for the changes to take place. Once logged back in, open **File Explorer** and go to the share that ABE was enabled on. You should now only see the folders which the user has access to, in this case, this user only has access to the **IT** folder.
<img width="1072" height="898" alt="Screenshot from 2025-08-10 13-16-18" src="https://github.com/user-attachments/assets/a1b7692f-4541-49ef-9aba-55dd150d26da" />


<a name="dfs"></a>
## Enable ABE for DFS Folders
To enable ABE for a DFS folder requires a few more steps. Follow the steps listed in [Enable ABE for Network Shared Folders](#enable-abe-server-man) to enable ABE in the **Server Manager**. This time select the DFS folder. Click **Apply** and **Ok**.
<img width="1059" height="898" alt="Screenshot from 2025-08-10 13-29-17" src="https://github.com/user-attachments/assets/dd056876-8a2c-4b08-a80a-c701072d621a" />


Next, go click **Tools** at the top right of the **Server Manager** dashboard and select **DFS Management**
<img width="1059" height="898" alt="Screenshot from 2025-08-10 13-32-02" src="https://github.com/user-attachments/assets/ac833820-2bae-468e-b8ce-6341a87ab1c3" />


In the **DFS Management** console, right-click on the DFS share and select **Properties**
<img width="1059" height="898" alt="Screenshot from 2025-08-10 13-35-19" src="https://github.com/user-attachments/assets/0852649b-cad8-4d3d-b71e-3f3d5648a5c9" />


Click the **Advanced** tab in the **Properties** window and check the box next to **Enable access-based enumeration for this namespace**. Click **Apply** and click **Ok**
<img width="1059" height="898" alt="Screenshot from 2025-08-10 13-38-53" src="https://github.com/user-attachments/assets/43882988-b52e-4f89-aee8-16b83db0e12c" />


<a name="permissions"></a>
## Set DFS Access Permissions
Now we will set explicit access permissions for each of the target folders within the DFS namespace. These permissions that we set here will have no impact on NTFS permissions for the actual share that the DFS target folders point to, only the target folder links themselves.

Right-click a target folder in your DFS namespace and select **Properties**
<img width="1059" height="898" alt="Screenshot from 2025-08-10 14-12-38" src="https://github.com/user-attachments/assets/8af7a55e-4c77-4b79-8a47-b553e26290c7" />


Click the **Advanced** tab and fill in the bubble next to **Set explicit view permissions on the DFS folder** and click **Configure view permissions**
<img width="1059" height="898" alt="Screenshot from 2025-08-10 14-18-09" src="https://github.com/user-attachments/assets/efe8167c-e345-49c9-a387-e61d6aa4878a" />


Add the security group that will grant access the target folder. Click **Apply**. Follow the same steps for any other folders within the DFS namespace.
<img width="1059" height="898" alt="Screenshot from 2025-08-10 14-23-56" src="https://github.com/user-attachments/assets/42c97a76-fe76-42a5-ae19-718f4afaff4b" />


Now I'll sign back into my client as a user that only has access to the **IT** folder. That should be the only folder that is visible after enabling ABE.
<img width="1072" height="898" alt="Screenshot from 2025-08-10 14-36-05" src="https://github.com/user-attachments/assets/94b80078-3d63-4837-a081-b83835429ee5" />





















