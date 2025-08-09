# Network Shared Folder and Distributed File System (DFS) Setup


## Lab Overview
In this lab we will cover the use cases and differences between the two methods Microsoft Windows offers when it comes to sharing data; **Shared Folders** and **DFS**. I'll demonstrate this by creating a simple file share for my homelab environment's IT department and then I will expand its capabilities by creating a DFS namespace that points to that share. This share folder will be hosted on my domain controller **DC-01** and the namespace will be created later and be hosted on my file server **SVR-1**.


## How do Shared Folders and DFS Folders Differ?
Both of these methods allow you to interact with folders from a remote file server, but they have different approaches to how it is done. 


### Network Shared Folders

Network shared folders are very straight forward  you share a folder that is hosted on a file server to other devices on it's network.
- It Provides users with access to files and folders over the network.
- Easy to set up and manage, ideal for small to medium-sized networks.
- Users connect directly to the server hosting the shared folder.

Although shared folders offer a simple and straight forward solution for sharing files, it has its drawbacks:
- It has poor reliability. If one server goes offline, all of the data on it is essentially lost until it is brought back online.
- It doesn't offer the most efficient way to access data. A user will need to know the specific server path to access a shared folder. This can be a problem as the number of file servers increase.
- Managing permissions for each folder can also pose a significant challenge especially while trying to keep your data's attack surface low

### Distributed File System (DFS)

<img width="1920" height="1080" alt="Namespace Diag" src="https://github.com/user-attachments/assets/f8404cd5-d002-4285-8479-e12561383a37" /></br>
DFS centralizes sharing multiple folders and storing much more conveniently. Here are the components that make it possible:
- **Namespace Server** This is the server that will host the namespace. This can be either a domain controller or a server that is the member of the domain which in it is configured.
- **Namespace Root** - This is the starting point of the namespace. It is a domain based namespace so it is written like</br> **\\\domain_name\root_name**. This namespace root can be hosted on multiple different servers, making it available one server goes offline.
- **Folder** - Folders are used to make a hierarchical structure within the namespace.
- **Target Folder** - Target folders are the UNC path to a shared folder or namespace. The folder target is where the data is stored.

As you can see, DFS solves a lot of the issues that shared folders had by improving availability, scalability, and by providing only a single point of management for shared folders.

## Tasks
- [Creating the Initial Folder](#initial)
- [Assigning Share and NTFS Permissions](#permissions)
- [Confirming Share Configuration](#confirm)
- Install DFS Namespace Server Utility
- Create DFS Namespace


<a name="initial"></a>
## Creating the Initial Folder
On your host device, in my case DC-01, open the Windows File Explorer and make sure you're in the **C:\\** location. Create a new folder by right-clicking an empty space and selecting **New**. Name the folder **Public Share**.
<img width="1042" height="792" alt="Screenshot from 2025-08-07 18-19-26" src="https://github.com/user-attachments/assets/46271812-ee57-483a-8db2-0e496ba88f86" />


Go inside of that folder and create another folder following the same instructions above. Name this folder **IT**
<img width="1042" height="792" alt="Screenshot from 2025-08-07 18-26-23" src="https://github.com/user-attachments/assets/24d1be6b-d700-4dfc-8bc9-35659bb5e2da" />


<a name="permissions"></a>
## Assigning Share and NTFS Permissions
Go up one layer back to the C:\\ drive. Right click on the **Public Share** folder and select **Properties**.
<img width="1042" height="792" alt="Screenshot from 2025-08-07 18-35-10" src="https://github.com/user-attachments/assets/41cfc552-d3a2-495a-99de-5ddbac864185" />


Select the **Sharing** tab and select **Advanced Sharing...**
<img width="1042" height="792" alt="Screenshot from 2025-08-08 15-12-38" src="https://github.com/user-attachments/assets/f63b8564-caed-4357-9d71-630fa8ba034f" />


Check the box next to **Share this folder** and click on the box that says **Permissions**.
<img width="1042" height="792" alt="Screenshot from 2025-08-08 17-41-45" src="https://github.com/user-attachments/assets/6dcc0b1f-9ee1-41fa-9a8f-97d27495cfe6" />


In this window we will assign the **Share** permissions for this folder. For the **Share** we will allow **Everyone** full control, click **Apply**, and click **Apply** on the **Advanced sharing**. Later on when we assign NTFS permissions we will be stricter on access. Assigning permissions in this fashion makes access management more effective since NTFS can be more granular when assigning permissions and offers permissions inheritability. This means that a user will have access to a sub-folder based on the parent folders access.
<img width="1042" height="792" alt="Screenshot from 2025-08-08 17-51-20" src="https://github.com/user-attachments/assets/6941721c-5dcf-457a-a75c-92bcf9539f26" />


Now click the **Security** tab while in the share's properties window. Here is where we will be assigning the **NTFS** permissions by security group. Click **Edit** then **Add**. I will be allowing the each department in my AD environment access (Read & Execute) to this folder and have the **Service_Desk_Tier_III** members access to manage it (Full Access). 
<img width="1042" height="792" alt="Screenshot from 2025-08-08 18-33-04" src="https://github.com/user-attachments/assets/f8f84978-481a-46bc-9825-942da77514fb" />


We will follow the same steps to assign the share and NTFS permissions as above. 
<img width="1042" height="792" alt="Screenshot from 2025-08-08 18-38-49" src="https://github.com/user-attachments/assets/9a7b7de9-4b72-463c-9957-3799c2d53790" />


Next we will disable inheritability in the **IT** folder and remove unnecessary users/groups. The tier III security group will still be given full access. While in the **Security** tab, select **Advanced**
<img width="1042" height="792" alt="Screenshot from 2025-08-08 23-07-17" src="https://github.com/user-attachments/assets/90093b1a-452d-4f66-9adc-73c69c9dd8c2" />


Click **Disable Inheritance** and select the option **Convert inherited permissions into explicit permissions on this object**. After that selection, you should see **None** under the **Inherited from** column. Remove all unnecessary users/groups.
<img width="1042" height="792" alt="Screenshot from 2025-08-08 23-27-33" src="https://github.com/user-attachments/assets/4435e119-1c4e-4a28-b9ad-1fb128ae2601" />


<a name="confirm"></a>
## Confirm Share Folder Configuration
To confirm that the permissions are working correctly, I'll sign into a user outside of the IT_Users group and attempt to access the **IT** folder.
<img width="1071" height="902" alt="Screenshot from 2025-08-09 00-04-41" src="https://github.com/user-attachments/assets/867afe21-bd36-408a-aea0-d2af1774cea7" />


First I'll map the network share as a drive on my client virtual machine **CLIENT_1**.
<img width="1071" height="902" alt="Screenshot from 2025-08-08 23-37-34" src="https://github.com/user-attachments/assets/4ae0e697-23b3-46c7-8c1a-3910f25e9a08" />


As you can see, the user I'm logged in as isn't able to access the folder **IT** since they don't have the permission to.
> If you can still access the folder from outside, be sure to check for groups like *users* *authenticated users* or *everyone* to still be listed in the permissions tab.
<img width="1071" height="902" alt="Screenshot from 2025-08-09 00-18-47" src="https://github.com/user-attachments/assets/898e8f56-79cc-487b-a158-b21aa6e11ac2" />


Now we will test with a user that is a member of the **IT_Users** group.







