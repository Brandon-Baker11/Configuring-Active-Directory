# Configuring Microsoft Entra Connect

## Overview
In this lab I will demostrating the installation and configuration of Microsoft Entra Connect to my Windows Server 2022 virtual machine. Microsoft Entra Connect is a program that allows you to integrate a Microsoft Azure tenant to an already existing Active Directory on premises environment. With this hybrid environment you get to experience the benefit of single sign on for on-prem and cloud applications, enhanced security through authentication methods like Password Hash Synchronization and Pass-through Authentication, and leveraging a single set of sign in credentials to access on-premises and cloud applications.

## Tasks
- [Install Entra Connect](#install)
- [Initial Setup of Entra Connect](#initial)
- [Configure Entra Connect](#configure)
- [Confirm Object Synchronization](#confirm)


<a name="install"></a>
## Installing Entra Connect
We will start out in our Microsoft Entra Admin Center. You can get there by [clicking here](https://entra.microsoft.com). Once logged in, on the left hand side click the **Microsoft EntraID** icon and scroll down to **Entra Connect**
> You'll be presented with the options of **Cloud Sync** and **Connect Sync**. While these are both lightweight agens that facilitate the synchronization of cloud and on-premises environments, the differnece is that you get more advanced features with Connect Sync. Pass-Through Authentication, syncing of device objects, and Exchange Hybrid writeback are only available in Connect Sync.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 14-44-26" src="https://github.com/user-attachments/assets/e35f095e-7cd9-4865-87be-f8f6ad08ce3c" />


We will be using **Connect Sync** in this demonstration. In the **Get Started** blade, scroll down to **Managae from on-premises: Connect Sync** and click **Download Sync Agent**. Once it is downloaded, launch the MSI file.

Once it is complete, you should see a setup wizard for the application launched on your screen.
<img width="1039" height="782" alt="Screenshot from 2025-08-03 15-48-27" src="https://github.com/user-attachments/assets/c64abbc7-a4db-49a2-aa0d-1ae0d0d90deb" />




















