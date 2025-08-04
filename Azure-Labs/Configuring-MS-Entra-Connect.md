<img width="618" height="200" alt="microsoft-entra-id-logo-small" src="https://github.com/user-attachments/assets/4488df12-9bc1-4024-8b48-cf6d1d4766c0" />

# Configuring Microsoft Entra Connect


## What is Microsoft Entra Connect?
Microsoft Entra Connect is a utility that integrates your on-premises Active Directory Domain Services with Microsoft Entra ID (formerly Azure AD), allowing for a hybrid identity environment. This allows you to:
- Single Sign-On (SSO) for on-prem and cloud applications
- Secure authentication options such as Password Hash Synchronization and Pass-through Authentication
- Centralized identity management using one set of credentials across environments


## Lab Overview
In this lab I will demonstrating the installation and configuration of Microsoft Entra Connect to my Windows Server 2022 virtual machine. Microsoft Entra Connect is a program that allows you to integrate a Microsoft Azure tenant to an already existing Active Directory on-premises environment. With this hybrid environment you get to experience the benefit of single sign on for on-prem and cloud applications, enhanced security through authentication methods like Password Hash Synchronization and Pass-through Authentication, and leveraging a single set of sign in credentials to access on-premises and cloud applications.

## Tasks
- [Install Entra Connect](#install)
- [Initial Setup of Entra Connect](#initial)
- [Configure Entra Connect](#configure)
- [Confirm Object Synchronization](#confirm)


<a name="install"></a>
## Installing Entra Connect
We will start out in our [Microsoft Entra Admin Center](https://entra.microsoft.com). Once logged in, on the left hand side click the **Microsoft EntraID** icon and scroll down to **Entra Connect**. You'll be presented with the options of **Cloud Sync** and **Connect Sync**. Below is a table that shows some of the differences between the two.

| Features                    | Cloud Sync | Connect Sync |
|-----------------------------|------------|--------------|
| Lightweight agent           | ✅         | ❌           |
| Pass-through Authentication | ❌         | ✅           |
| Device object sync          | ❌         | ✅           |
| Exchange hybrid writeback   | ❌         | ✅           |

While these are both lightweight agents that facilitate the synchronization of cloud and on-premises environments, Connect Sync comes with more features and is built to support a more complex hybrid identity structure.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 14-44-26" src="https://github.com/user-attachments/assets/e35f095e-7cd9-4865-87be-f8f6ad08ce3c" />


We will be using **Connect Sync** in this demonstration. In the **Get Started** blade, scroll down to **Manage from on-premises: Connect Sync** and click **Download Sync Agent**. Once it is downloaded, launch the MSI file.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 15-12-56" src="https://github.com/user-attachments/assets/770fa2c4-5336-41c8-9e98-6e2b1e5c774a" />


<a name="initial"></a>
## Initial Setup of Entra Connect
Once it is complete, you should see a setup wizard for the application launched on your screen. Click **Agree** for the license terms and privacy notice and **Continue**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 15-48-27" src="https://github.com/user-attachments/assets/c64abbc7-a4db-49a2-aa0d-1ae0d0d90deb" />


On the **Express Settings** page we will not be utilizing the express setup. This feature will synchronize the entire on-premises Active Directory, we will specify the scope of synchronization for Entra Connect. Click **Customize** and leave the selections on the following page empty. Then click **Install**
> When installing Entra Connect like we have here, you will be prompted to select which organizational units (OUs) from the environment should be synchronized.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 20-46-06" src="https://github.com/user-attachments/assets/125ba86c-38a6-479f-975a-410ff6770ee9" />
<img width="1039" height="782" alt="Screenshot from 2025-08-03 20-52-05" src="https://github.com/user-attachments/assets/c94b2c4c-fbc5-4542-9ded-44fb6f8b1d61" />


<a name="configure"></a>
## Configure Entra Connect
Once the installation is complete you will be on the **User Sign-in** page. Ensure the bubble next to **Password Hash Synchronization** is filled as this will be the method of authentication used for this hybrid environment. This option will allow users to use their on-premises credentials to access cloud resources. Click **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-03-17" src="https://github.com/user-attachments/assets/d26f5e07-bb5a-4632-b2a7-f5acf082f28d" />


Next we have to provide the credentials of a EntraID Global Administrator or Hybrid identity administrator. Enter the credentials and click **Next**. You should then be prompted to sign in to the Microsoft account. Provide the password and click **Sign in**.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-06-03" src="https://github.com/user-attachments/assets/62c03e41-c9f0-4b92-9027-8618b124e140" />


You now have the option to connect your on-premises directory. Select **Add Directory**. Make sure that the bubble next to **Create new AD account** is filled in. Enter the credentials of an account with admin privileges in your AD environment and click **Ok**. 
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-13-28" src="https://github.com/user-attachments/assets/7b793542-2ec2-4945-8165-f936634aa01f" />


Under **Configured Directories** you should see your domain with a green check next to it, click **Next**.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-15-49" src="https://github.com/user-attachments/assets/181bea4c-d490-4eb7-a9e8-946654836def" />


On the **Microsoft Entra sign-in configuration** page, you will see a notice mentioning that users being unable to sign in if the on-premises UPN doesn't match the EntraID verified domain. Since this is only for demonstration purposes, that will be fine. Click the box next to **Continue without matching all UPN suffixes to verified domains**. Click **Next**.
> In a live environment we would make sure we verify a custom domain in Azure to match the on-premises domain.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-31-44" src="https://github.com/user-attachments/assets/e5094bf2-1b21-4022-ac90-abfb3f891a17" />


Now we have the opportunity to select which OUs to sync to Entra Connect. Fill in the bubble **Sync Selected domains and OUs** then expand your domain tree and specify the OUs to sync. I will be choosing to sync OUs that have user and group objects inside them. Click **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-40-46" src="https://github.com/user-attachments/assets/6746532c-e8c9-46d8-bae5-10d09f4869c3" />


Since we are only syncing one directory, we can leave the default selection on how users are identified on-premises. We will also allow Azure to manage how users are identified in EntraID. Continue with the defaults on the **Uniquely identifying your users** page. Click **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-47-36" src="https://github.com/user-attachments/assets/a3c3eaf1-a0ad-45ed-8ab8-a1714555533c" />


Ensure **Synchronize all users and devices** is selected, click **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-48-45" src="https://github.com/user-attachments/assets/91fd6c8e-4923-42fe-8ded-d1b5b4812bf1" />


Depending on the license your Azure tenant has it may be a good decision to enable Password Writeback. This is useful in the event where a user that has Self-Service Password Reset (SSPR) permissions makes a change to their password. That change will be written to the on-premises Active Directory environment. That will be the only feature I'll be adding in this lab, click **Next**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 21-58-07" src="https://github.com/user-attachments/assets/3630068c-0150-4229-b0c7-4c83daabe455" />


Leave **Start the synchronization process when configuration completes** checked. Entra Connect will automatically begin syncing upon the configuration's completion. Click **Install**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 22-02-17" src="https://github.com/user-attachments/assets/f86e2b1d-41a1-431b-9e52-9d16fd807753" />


<a name="confirm"></a>
## Confirm Object Synchronization
To confirm that the synchronization was successful, all we need to do is verify that user objects are being populated in our EntraID tenant. In the EntraID admin center, open the **EntraID** blade and select **Users**
<img width="1039" height="782" alt="Screenshot from 2025-08-03 22-09-44" src="https://github.com/user-attachments/assets/adc3ec44-c8fa-451c-9f76-ca1b81564d02" />


You should now see all of the users  from the selected OUs populating in EntraID. For all of the on-premises accounts, you should see **Yes** under the **On-premises sync enabled** column. Any existing users in EntraID will say no since they have not been synced to the on-premises environment.
> It may take several minutes for user objects to populate.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 22-11-52" src="https://github.com/user-attachments/assets/9ebc185e-0a20-40d9-8a2f-625bd91a506b" />


By connecting our Active Directory Domain Services to Microsoft Entra ID, we have established a hybrid identity model that makes user management easier, enhances security, and supports modern authentication for cloud applications. This setup can also be extended to enable SSO, conditional access policies, and integration with Microsoft 365 services.
