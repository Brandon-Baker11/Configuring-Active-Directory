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

DFS solves many of the issues that shared folders have by allowing 
DFS is a centralized way of sharing multiple folders and storing much more conveniently. Here are its components that make it possible:
- **Namespace Server** - This is the server that will host the namespace. This can be either a domain controller or a server that is the member of the domain which in it is configured.
- **Namespace Root** - This is the starting point of the namespace. It is a domain based namespace so it is written like</br> **\\\domain_name\root_name**. This namespace root can be hosted on multiple different servers, making it available one server goes offline.
- **Folder** - Folders are used to make a hierarchical structure within the namespace.
- **Target Folder** - Target folders are the UNC path to a shared folder or namespace. The folder target is where the data is stored.

As you can see, DFS solves a lot of the issues that shared folders had by improving availability, scalability, and by providing only a single point of management for shared folders.

## Tasks
- [Creating the Initial Folder](#initial)
- Assigning Share Permissions
- Assigning NTFS Permissions
- Confirming Share Configuration
- Install DFS Namespace Server Utility
- Create DFS Namespace


<a name="initial"></a>
## Creating the Initial Folder
On your host device, in my case DC-01, open the Windows File Explorer and make sure you're in the **C:\\** location. Create a new folder by right-clicking an empty space and selecting **New**. Name the folder **Public Share**.
<img width="1042" height="792" alt="Screenshot from 2025-08-07 18-19-26" src="https://github.com/user-attachments/assets/46271812-ee57-483a-8db2-0e496ba88f86" />


Go inside of that folder and create another folder following the same instructions above. Name this folder **IT**
<img width="1042" height="792" alt="Screenshot from 2025-08-07 18-26-23" src="https://github.com/user-attachments/assets/24d1be6b-d700-4dfc-8bc9-35659bb5e2da" />


Go up one layer back to the C:\\ drive. Right click on the **Public Share** folder and select **Properties**.
<img width="1042" height="792" alt="Screenshot from 2025-08-07 18-35-10" src="https://github.com/user-attachments/assets/41cfc552-d3a2-495a-99de-5ddbac864185" />












