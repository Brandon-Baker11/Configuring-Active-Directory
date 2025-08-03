# Configuring Role Based Access Control

Role-Based Access Control (RBAC) is a method for assigning permissions to users based on their role in an organization. Instead of assigning permissions directly to users, permissions are granted to roles (security groups), and users are added to these roles. This allows centralized management, easier audits, and reduced administrative overhead. In this lab, we'll implement RBAC in Active Directory by creating role groups for different Service Desk tiers, nesting them into permission groups, and delegating access at both the domain and local machine levels.


## Current AD Organization Structure
In my AD environment I have a Virginia and Maryland site, several departments within and user accounts are stored within those departments.The IT organizational unit (OU) is based out of the Virginia site and contains all of the IT personnel for the organization. We will have three tiers of access for both sites in this lab Users, Servers, and Endpoints. The users are nested within each department OU while the servers and endpoints are nested in the site. <br>
<img width="640" height="480" alt="Screenshot from 2025-07-31 13-49-58" src="https://github.com/user-attachments/assets/24f1d848-34ee-4c5a-bad8-10254c5d83dd" />


## RBAC Structure
The approach that will be taken will be nesting **Role Groups** within **Access Control Groups**, then assigning individual users to the role groups, allowing them to inherit the access control groups' permissions through the role group it is assigned. We will use the following access control and role groups.

### Access Control Groups:
- Domain_Admins_Users
- Local_Admins_Servers
- Local_Admins_Endpoints
- Local_Admins_Printers

### Role Groups:
- Service_Desk_Admins_Tier_I → member of Domain_Admins_Users, Local_Admins_Endpoints
- Service_Desk_Admins_Tier_II → Domain_Admins_Users, Local_Admins_Endpoints Local_Admins_Printers
- Service_Desk_Admins_Tier_III → member of all permission groups

See the visual representation below:<br/>
<img width="640" height="480" alt="Access (3)" src="https://github.com/user-attachments/assets/52c931ab-1e55-49fb-8b52-2d8940a8410d" />


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


## Building Role Structure
So we have defined the Service Desk Admin roles that we assign users to, now we will assign those "Roles" to groups that actually grant access to special permissions. Permissions will be inherited from the Parent Group meaning any group that is assigned to it will inherit permissions from the parent and any user inside of the group will be inheriting permissions from it. Think that permissions are passed down from Parent Group -> Service Desk Role -> Administrative user. Assigning elevated permissions in this fashion greatly reduces the administrative burden of having to assign tens or hundreds of users similar permissions.
<img width="1024" height="1024" alt="ChatGPT Image Jul 31, 2025, 06_03_39 PM" src="https://github.com/user-attachments/assets/12b7ac99-de2f-40ae-98e6-0fb252f9050c" />


We will now create the groups that will contain the elevated rights. They will be named **Local_Admins_Servers**, **Local_Admins_Endpoints**, **Local_Admins_Printers**, **Domain_Admins_Users**. Follow the same steps for creating groups as earlier.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 18-13-45" src="https://github.com/user-attachments/assets/7b44cd74-b5ce-4e8b-8e21-94c1a7968bbf" />


Next we will begin assigning access controls to groups. **Tier I** will have access to **Domain Users** and **Endpoints**. We will select the group that contains the Tier I technicians and add it to the group that will grant access to tier I capabilities. Right-click **Service_Desk_Admins_Tier_I** and select **Add to group**. Add it to **Local_Admins_Endpoints** and **Domain_Admins_Users**. Follow the same steps from earlier to add the groups.

Now if we right-click on **Service_Desk_Admins_Tier_I** and select **Member of** you will see the groups we just added it to.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 18-23-06" src="https://github.com/user-attachments/assets/5014d6ce-1515-42e5-837d-be7ed358ec10" />


Next will be the Tier II group. This group will have the same permissions as Tier I, but we will be adding the **Local_Admins_Printers** group. 
<img width="1039" height="782" alt="Screenshot from 2025-08-01 11-52-25" src="https://github.com/user-attachments/assets/573a6dfe-144e-4fb8-a605-00eec0ada698" />


Finally, for the **Service_Desk_Admins_Tier_III**, we will be adding all four of the groups, **Domain_Admins_Users**, **Local_Admins_Endpoints**, **Local_Admins_Printers**, and **Local_Admins_Servers**. Repeat the same process for adding **Service_Desk_Admins_Tier_III** to these groups

Now to verify that all of the tiers have been assigned to the correct groups, right-click the tiered group and select **Properties** then click **Member of** to view the groups they are members of.
<img width="1039" height="782" alt="Screenshot from 2025-08-01 12-00-05" src="https://github.com/user-attachments/assets/2dbb3944-fafa-40e3-9613-14de60e23f6b" />


## Assigning Access Controls
These groups that we have created for access don't have access just yet. Starting with the **Domain_Admins_Users** group, we will give everyone who inherits rights from it will be able to manage domain users under each site. We will need to what is called **Delegate Control** for every user OU in our Virginia and Maryland sites.

Right-click a users folder in one of the departments, I'm starting with the Maryland Engineering department and select **Delegate Control**. This will launch a setup wizard. CLick **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-01 12-12-43" src="https://github.com/user-attachments/assets/fad7b99e-5f6c-4ec8-ac70-c177a23fe11b" />


We will be adding who will have the rights to manage users at the domain level. Click **Add** and type **Domain_Admins_Users**. Click **Ok**, then click **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-01 12-19-50" src="https://github.com/user-attachments/assets/4c2700dc-8636-44cb-ad2e-f814b1686a78" />


One this page we will specify what control we will allow for the **Domain_Admins_Users** group to have. We will be choosing **Create, delete, and manage user accounts** and **Create, delete, and manage groups**. Click **Next** and click **Finish**
<img width="1039" height="782" alt="Screenshot from 2025-08-01 12-24-18" src="https://github.com/user-attachments/assets/2f41e6f3-f4f1-4190-8d5a-7e3ba65b7bb2" />


Now the **Domain_Admins_Users** group has the rights to manage domain users and groups in the Maryland engineering department. To verify, right click the **USERS** OU under **Engineering**. Click the **Security** tab and you should see the **Domain_Admins_Users** group added to the list.
>We'll have to repeat this process for each user OU in each department.
<img width="1039" height="782" alt="Screenshot from 2025-08-01 12-36-35" src="https://github.com/user-attachments/assets/549fae7e-1e71-4082-a569-da236c9f5179" />


Next we'll grant local admin rights over the server **SVR-1** using the **Local_Admins_Servers** group. This means who ever logs into **SVR-1** and is a member of the **Service_Desk_Admins_Tier_III** will be able to make changes to **SVR-1**. Type in the Windows search bar **Computer Management**.
<img width="1039" height="782" alt="Screenshot from 2025-08-01 12-50-55" src="https://github.com/user-attachments/assets/c1cb9194-b033-4593-b2c5-03c25f3e8f9f" />


Expand **Local Users and Groups** and you will see **Users** and **Groups** click on **Groups**. A list of groups will populate, double click **Administrators**. Here there are only two members the **Administrator** user account and the **Domain Users** group that is part of my domain. What we want to do is add the group **Local_Admins_Servers** so all of its members will be granted admin privileges over this server.
<img width="1052" height="882" alt="Screenshot from 2025-08-01 13-31-32" src="https://github.com/user-attachments/assets/1c29b6a4-506a-4ffa-bbc3-09071df93d2b" />


Click **Add** and search for **Local_Admins_Servers** and add it. Click **Ok**
<img width="1052" height="882" alt="Screenshot from 2025-08-01 13-36-18" src="https://github.com/user-attachments/assets/3ebd04b3-40f3-488a-9c81-b870171fcfb3" />


Now for the Tier II technicians we want them to make changes to the printer operations on this server. Thankfully there is a built-in group just for that. We will add the **Local_Admins_Printers** to it, granting the Tier II technicians print operation rights on this server. Double-click the **Print Operators** group and click **Add** and add the **Local_Admins_Printers**
<img width="1052" height="882" alt="Screenshot from 2025-08-01 13-42-55" src="https://github.com/user-attachments/assets/8a676091-378b-4285-be33-8b0565bdc71f" />


Switching back to the domain controller, we will also grant the **Local_Admins_Servers** group server operator permissions so they are able to modify the server configs and nothing else. In the **Active Directory Users and Computers** utility, click **Built-in** and double click the **Server Operator** group
<img width="1039" height="782" alt="Screenshot from 2025-08-01 13-50-57" src="https://github.com/user-attachments/assets/0d6bdc68-a9ef-483b-a580-bea651931037" />


Click the **Members** tab and click **Add** then add the **Local_Admins_Servers** group
<img width="1039" height="782" alt="Screenshot from 2025-08-01 13-52-20" src="https://github.com/user-attachments/assets/77ec0deb-5431-435f-8569-26edfddbfe91" />


## Confirm Admin Permissions are Configured Correctly
Now that we have assigned the proper roles and groups to our admin user that we created earlier, now we test it. We will sign into our **SVR-1** vm under the admin user we just created.
<img width="1052" height="882" alt="Screenshot from 2025-08-01 13-59-28" src="https://github.com/user-attachments/assets/e472f189-7dcc-4809-9557-589d1d24f229" />


Create a local user, search **Computer Management** in the Windows search bar and expand **Local Users and Groups** select **Users** and make a test user. Check **Password never expires** and click **Create**
<img width="1052" height="882" alt="Screenshot from 2025-08-01 14-04-06" src="https://github.com/user-attachments/assets/31f689db-55f7-4bdb-80fd-2dccb87bc008" />


## Conclusion
By using nested security groups for role assignments, we reduced the need to grant permissions to individual users. Changes to access can now be made by adding/removing users from a single group, improving scalability and reducing administrative errors. This same structure can be extended to manage permissions for file shares, GPO scopes, and Azure AD role assignments.


