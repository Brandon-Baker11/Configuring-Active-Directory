# Configuring Role Based Access Control

In this lab, we'll implement Role Based Access Controll (RBAC) to demonstrate the assignment of roles to users and groups at scale. Every user in Active Directory (AD) usually has one or more roles. To efficiently assign roles to these users, we make a security group for each one of those roles. Then we add the users into the groups that contain the roles the user needs assigned.

## Current AD organization setup
In my AD environment I have a Virginia and Maryland site, several departments within and user accounts are stored within those departments.The IT organizational unit (OU) is based out of the Virginia site and contains all of the IT personel for the organization. We will have three tiers of access for both sites in this lab Users, Servers, and Endpoints. The users are nested within each department OU while the servers and endpoints are nested in the site.
<img width="1039" height="782" alt="Screenshot from 2025-07-31 13-49-58" src="https://github.com/user-attachments/assets/24f1d848-34ee-4c5a-bad8-10254c5d83dd" />



























