# Subscription and Role Based Access Control (RBAC) Management

In this lab we will assign permissions to groups using **RBAC** and control the scope of their permissions by implementing a **Management Group**.

## Creating a Management Group
Management groups are used to segment and organize subscriptions. This allows for identities to operate in the correct scope Azure Policy to affect the expected resources.  
> Azure Policies and RBAC conditions are inherited by the child management groups, subscriptions, and resource groups.
<img width="1701" height="978" alt="resource-hierarchy" src="https://github.com/user-attachments/assets/8ad26120-b354-48fb-ba04-c4c29779554a" /><br><br>


First let's check that we have the ability to manage all subscriptions and management groups in the tenant. In the Azure Portal, type in the search box at the top of the page `Microsoft Entra ID` and select it
<img width="1917" height="923" alt="Screenshot from 2025-07-30 12-08-13" src="https://github.com/user-attachments/assets/907ff938-8616-46a2-a376-642f36d8c6ea" />


Under the **Management** blade select **Properties**
<img width="1917" height="923" alt="Screenshot from 2025-07-30 12-31-16" src="https://github.com/user-attachments/assets/49e19c16-a0ed-4da6-9b0a-ca50e3b097d4" />


In the **Access management for Azure resources** section, make sure you are able to manage access to subscriptions and management groups in the tenant.
<img width="1917" height="852" alt="Screenshot from 2025-07-30 12-53-08" src="https://github.com/user-attachments/assets/caa07511-8e92-494f-9feb-429c82adf765" />


Do a search for **Management Groups**
<img width="1917" height="852" alt="Screenshot from 2025-07-30 12-56-48" src="https://github.com/user-attachments/assets/9e9f8861-3075-44ba-9783-64b1560e50f3" />


On the **Management Group** page, click **+ Create**
<img width="1917" height="852" alt="Screenshot from 2025-07-30 13-03-57" src="https://github.com/user-attachments/assets/0f9e82e8-cb75-418f-9500-d742f64978fe" />


Make a management group with the info provided below. Select **Submit** when finished
**Management Group ID** `az104-mg-test`
**Management Group Display Name** `az104-mg-test`
<img width="1917" height="852" alt="Screenshot from 2025-07-30 13-10-35" src="https://github.com/user-attachments/assets/74a058a3-9de6-46d3-bc09-7ba50b2a10ba" />


Refresh the **Management Group** page and your new management group should populate
> This could take several minutes if not immediate
<img width="1917" height="852" alt="Screenshot from 2025-07-30 13-15-56" src="https://github.com/user-attachments/assets/c245eb98-da77-40d4-b2c2-fbc21aab2778" />


## Assigning a Built-In Role
We'll be assigning the **VM Contributor** role to a group called **Helpdesk**. This role is one of the many built-in roles Azure has.

Select the management group that we just created `az104-mg-test`
Select the **Access Control (IAM)** blade, then click the **Roles** tab.
<img width="1917" height="852" alt="Screenshot from 2025-07-30 13-49-51" src="https://github.com/user-attachments/assets/43fe3dbc-a75e-4706-b83c-72aa335d0df3" />


Click **+ Add** and select **Add Role Assignment**
<img width="1917" height="852" alt="Screenshot from 2025-07-30 13-52-41" src="https://github.com/user-attachments/assets/7364c268-1a91-45fe-8d48-f9f28935f8e8" />


Search for and select **Virtual Machine Contributor** role. This role will allow you to manage VMs but not access the OS in use, the network or storage account attached to it.
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-00-00" src="https://github.com/user-attachments/assets/1b543300-d146-46c4-951e-25aa26001b43" />


On the **Members** tab select **+ Select Members** and a blade will appear listing the groups and users in your tenant. We will be assigning this role to a group called **Helpdesk** and click **Select**. If you don't have that group made, you can take the time to make one.
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-24-17" src="https://github.com/user-attachments/assets/87390ee5-4d18-4229-9604-fde308aefad3" />

Click **Review and Assign** twice and this will process the role assignment to the Helpdesk group.

Click the **Role Assignments** tab and verify that the Helpdesk group was assigned the **Virtual Machine Contributor** role.
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-28-13" src="https://github.com/user-attachments/assets/3bae92b1-bd3b-4e8e-b50c-15e7a6a0c390" />


## Create a Custom RBAC Role
When making custom roles Azure has a Cloning feature that allows us to take an already existing built-in role and make changes to that instead of creating one from scratch. This helps us because if the built-in role has more permissions than necessary, we can remove what is not needed.


While on the **Access Control (IAM)** page, select **+ Add** and **Add Custom Role**
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-36-56" src="https://github.com/user-attachments/assets/1e2c2383-38b3-44c2-9a9e-99eedb31a17d" />


Fill in the info on the Basic tab with the following info
Custom Role Name: `Custom Support Request`
Description: `A custom contributor role for support requests.`
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-42-27" src="https://github.com/user-attachments/assets/46353251-1844-4e9a-be47-8016d8ff0144" />


For the **Baseline Permissions** section select **Clone a Role**. Search for **Support Request Contributor** and select it. Then click next.
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-45-33" src="https://github.com/user-attachments/assets/76fe567c-4323-4f5d-8b92-c6b468831ba6" />


Now on the **Permissions** tab, select **+ Exclude Permissions** and in the field type **.support** and select **Microsoft.Support**
<img width="1917" height="852" alt="Screenshot from 2025-07-30 14-50-35" src="https://github.com/user-attachments/assets/5618b4c4-4960-4638-8eb9-239a57ae8d77" />


Check the box next to `Other: Registers Support Resource Provider`. This role we be updated and won't allow this action. 
<img width="1917" height="852" alt="Screenshot from 2025-07-30 17-41-59" src="https://github.com/user-attachments/assets/06c58650-430b-4856-9484-132bf4c7e57c" />


On the **Assignable Scopes** tab, make sure the new management group is selected, click Next
<img width="1917" height="852" alt="Screenshot from 2025-07-30 17-50-48" src="https://github.com/user-attachments/assets/9af72bdb-be97-4550-bd7b-50d55bcab328" />


In the JSON you can check the changes that were made in the **Actions** and **NotActions** permission fields
<img width="1917" height="852" alt="Screenshot from 2025-07-30 17-56-52" src="https://github.com/user-attachments/assets/88ac3f3a-0c52-4aab-84fd-e73f333637b9" />

Select **Review and Create** then click **Create**


## Confirm Role Assignments
To confirm that a new role was created we will check the **Activity Log**

In the Azure Portal under the same management group we have been working with, click the **Activity Log** blade and you will see the **Create or Update Custom Role Definition** logged
> You may need to wait a few minutes and click **Refresh** for the new log to populate
<img width="1917" height="852" alt="Screenshot from 2025-07-30 18-15-06" src="https://github.com/user-attachments/assets/62784b5b-f3d4-4393-8109-743162018ed3" />
















