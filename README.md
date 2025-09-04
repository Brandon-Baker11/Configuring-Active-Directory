![what-is-active-directory-and-why-is-it-used](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b70fada4-5e40-4341-b2d3-36ab560c0227)
# Configuring Active Directory (OracleVM VirtualBox)
This tutorial will show the steps to create a basic Windows network environment on a VirtualBox VM that runs on Windows Server 2022 as the Domain Controller (DC) and Windows 11 (Client).

## Environments and Technologies Used
- OracleVM VirtualBox (7.0.16_Ubuntur162802)
- Active Directory Domain Services

## Operating Systems Used
- Windows Server 2022
- Windows 11 (24H2)


## Homelab Overview
<img width="1280" height="720" alt="VMWare Network V2" src="https://github.com/user-attachments/assets/72ddb297-c9ea-4e2a-ab81-4bedbf8d822d" />


This Active Directory Homelab is a virtualized Windows network environment built in OracleVM VirtualBox, designed to simulate a production-ready domain setup for hands-on learning and experimentation. The lab currently consists of:

- Windows Server 2022 Domain Controller (DC) hosting Active Directory Domain Services (AD DS), DHCP, DNS, and Routing/NAT services.
- Windows 11 Client machine joined to the domain for testing authentication, policy enforcement, and network services.
- Configured public and private network interfaces for internet access and internal domain communications.
- A fully functional DHCP scope delivering IP addresses to domain-joined clients.
- Verified DNS resolution and internet routing through the DC.

The repository contains:

- Step-by-step configuration instructions for setting up the DC, joining a client, and configuring network services.
- Screenshots documenting each stage of deployment for visual reference.
- Configuration notes explaining why certain settings are used (e.g., loopback DNS, OU creation, admin account best practices).

This lab serves as a foundation for future expansions, which may include:

- Group Policy Object (GPO) creation and deployment.
- Active Directory security hardening and auditing.
- File server configuration with NTFS permissions.
- Additional client systems and server roles (e.g., WSUS, Certificate Services).
- PowerShell automation for AD user and group management.

My Goal is to replicate enterprise network scenarios, providing more opportunities to demonstrate System Administration, Networking, and Windows Server management skills.
