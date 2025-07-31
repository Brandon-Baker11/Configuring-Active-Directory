# Configuring Role Based Access Control

In this lab, we'll implement Role Based Access Controll (RBAC) to demonstrate the assignment of roles to users and groups at scale. Every user in Active Directory (AD) usually has one or more roles. To efficiently assign roles to these users, we make a security group for each one of those roles. Then we add the users into the groups that contain the roles the user needs assigned.

## Current AD Organization Structure
In my AD environment I have a Virginia and Maryland site, several departments within and user accounts are stored within those departments.The IT organizational unit (OU) is based out of the Virginia site and contains all of the IT personel for the organization. We will have three tiers of access for both sites in this lab Users, Servers, and Endpoints. The users are nested within each department OU while the servers and endpoints are nested in the site.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 13-49-58" src="https://github.com/user-attachments/assets/24f1d848-34ee-4c5a-bad8-10254c5d83dd" />


## Creating Administrator Account
We will select one of the IT users and create an alternate account that will be given administrative permissions. Active Directory prevents you from storing two identical objects in the same OU, so I have a separate OU for user accounts and groups that are given admin privileges. This account will be stored in the **Special Users** OU. Right-click the OU you want to place your admin account highlight **New** and select **User**. 
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-15-48" src="https://github.com/user-attachments/assets/30692a7e-5351-45b9-8bc0-26ab09f5e321" />


Since this user will have elevated permissions we will add **adm** at the end of their user logon name
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-18-25" src="https://github.com/user-attachments/assets/57a52706-f40c-462d-af7c-d58d7621657c" />


Create a password for the user account and since this is a homelab, uncheck **User must change password at next logon** and check **Password never expires** then click **Next** then **Finish**. I don't recommend doing this in a live environment.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-21-04" src="https://github.com/user-attachments/assets/b506f199-d854-47d0-b452-2949f161eded" />


## Group Creation and Assignment
So we have made and administrator account for one of the IT users. This account doesn't have any special capabilities just yet, we will assign that user's admin account to a group that grants the elevated permissions. We can think of these groups as **Roles**. As mentioned earlier, there will be three tiers of privileges. In the same OU, right-click any empty space, hover over **New** and select **Group**
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-32-18" src="https://github.com/user-attachments/assets/98710b48-490f-488e-aa8d-23955a6224e7" />


The name for the role/group will be **Service_Desk_Admins_Tier_I**, click **Ok** to create the new group. Create groups for tiers II and III as well. 
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-37-02" src="https://github.com/user-attachments/assets/692e9fc6-2301-4bc7-8416-d2fbb6478ce6" />
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-41-08" src="https://github.com/user-attachments/assets/bccaae09-0c40-48fb-96bd-6b1d212a3d4c" />


Our user is going to be a Tier III technician so they will be added to the **Service_Desk_Admins_Tier_III** group. Right-click on the users account and select **Add to group**
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-47-19" src="https://github.com/user-attachments/assets/a7801973-9ad1-4cc5-8c76-a9725f184d60" />


You can type **Service** into the field and click **Check Names** and the service desk groups we just made will appear. Select Tier III and click **Ok**
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-49-35" src="https://github.com/user-attachments/assets/6d60e1c6-1dc4-4dc8-87f8-a4dc5fc62d07" />


We can confirm they are in the group by right-clicking on the admin accounts name and selecting **Properties** then clicking the **Member of** tab.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 17-52-38" src="https://github.com/user-attachments/assets/f67bcec7-14b6-4062-9b15-1ed0ea529dc8" />


## Assigning Access Controls
So we have defined the Service Desk Admin roles that we assign users to, now we will assign those "Roles" to groups that actually grant access to special permissions. Permissions will be inherited from the Parent Group meaning any group that is assigned to it will inherit permissions from the parent and any user inside of the group will be inheriting permissions from it. Think that permssions are passed down from Parent Group -> Service Desk Role -> Administrative user. Assigning elevated permissions in this fashion greatly reduces the administrative burden of having to assign tens or hundreds of users similar permissions.
<img width="1024" height="1024" alt="ChatGPT Image Jul 31, 2025, 06_03_39 PM" src="https://github.com/user-attachments/assets/12b7ac99-de2f-40ae-98e6-0fb252f9050c" />


We will now create the groups that will contain the elevated rights. They will be named **Local_Admins_Servers**, **Local_Admins_Endpoints**, **Local_Admins_Printers**, **Domain_Admins_Users**. Follow the same steps for creating groups as earlier.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 18-13-45" src="https://github.com/user-attachments/assets/7b44cd74-b5ce-4e8b-8e21-94c1a7968bbf" />


Next we will begin assigning access controls to groups. **Tier I** will have access to **Domain Users** and **Endpoints**. We will select the group that contains the Tier I technicians and add it to the group that will grant access to tier I capabilities. Right-click **Service_Desk_Admins_Tier_I** and select **Add to group**. Add it to **Local_Admins_Endpoints** and **Domain_Admins_Users**. Follow the same steps from earlier to add the groups.

Now if we right-click on **Service_Desk_Admins_Tier_I** and select **Member of** you will see the groups we just added it to.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 18-23-06" src="https://github.com/user-attachments/assets/5014d6ce-1515-42e5-837d-be7ed358ec10" />

































