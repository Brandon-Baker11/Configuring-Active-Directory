![what-is-active-directory-and-why-is-it-used](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b70fada4-5e40-4341-b2d3-36ab560c0227)
# Configuring Active Directory (OracleVM VirtualBox)
This tutorial will show the steps to create a basic Windows network environment on a VirtualBox VM that runs on Windows Server 2022 as the Domain Controller (DC) and Windows 11 (Client).

## Environments and Technologies Used
- OracleVM VirtualBox
- Active Directory Domain Services

## Operating Systems Used
- Windows Server 2022
- Windows 11 (24H2)

## Deployment and Configuration Steps
In this lab, we will go through the steps of connecting a client machine to your Domain Controller (DC). These steps include:

- Configure the network adapters for the VMs in Virtual Box
- Configuring the IP Address for the DC's internal network
- Installing Active Directory Domain Services
- Creating the domain
- Creating an admin account for the domain
- Configuring a DHCP server to the DC
- Configuring the DHCP scope
- Testing domain connectivity with a created user

<img width="1280" height="720" alt="VMWare Network-2" src="https://github.com/user-attachments/assets/9e5d6cf8-f67f-4609-8038-56cf438fe5ab" />


Before we fire up the virtual machines, the network adapters for the VMs need to be configured. For the domain controller we need to have two network adapters, a public one to access the internet and a private one for clients to connect to for services like DHCP, DNS, and routing. In virtual box, select the DC vm and select network and follow the configs in the screenshot.
<img width="961" height="633" alt="DC01-Adapter1" src="https://github.com/user-attachments/assets/3132b151-f663-4d48-b8e2-2587cc60e85c" />
<img width="961" height="633" alt="DC01-Adapter2" src="https://github.com/user-attachments/assets/4cc1d149-d744-44f4-b5c9-bbd22495240e" />

Now do the same for the client virtual machine
<img width="961" height="633" alt="CLIENT1-Adapter" src="https://github.com/user-attachments/assets/12badcaa-b6eb-4c83-bbce-590d8ae32782" />


Let's configure the IP address for the DC's internal network. Click the ***Network*** icon in the system tray located at the bottom right corner of your screen, click your network, and then select ***Change Adapter Settings***
<img width="1027" height="857" alt="Screenshot from 2025-07-16 17-56-46" src="https://github.com/user-attachments/assets/4f202d35-7c32-45ef-a422-ec91bb7bcdb6" />
<img width="1052" height="882" alt="Screenshot from 2025-07-16 18-03-19" src="https://github.com/user-attachments/assets/7c68f971-83fb-4dbe-8a6c-937808700aa5" />


We will next identify the network being used as our domain's internal network. You identify it by double-clicking your network, and in the ***Status*** window that pops up click the ***Details*** button. You will then look for the ***IPv4*** address. If it has an Automatic Private IP Addressing (APIPA), we will be changing that IP address. You can tell it's an APIPA address if the address begins with 169.254 in the first two octets.
<img width="1052" height="882" alt="Screenshot from 2025-07-16 18-15-46" src="https://github.com/user-attachments/assets/8b4e4441-2c04-4857-a4de-c19c8fd7d3c3" />
<img width="1052" height="882" alt="Screenshot from 2025-07-16 18-17-24" src="https://github.com/user-attachments/assets/d3a3c02c-8a08-4701-9b56-89510b2a15c9" />


Close the ***Details*** window, select ***Properties*** in the ***Status*** window, and double-click ***Internet Protocol Version 4 (TCP/IPv4)***. In the ***Internet Protocol Version 4 (TCP/IPv4)*** window, we will be assinging the IP address for the internal network.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 21-59-18" src="https://github.com/user-attachments/assets/825eba6e-fb44-4e17-ab40-6d76ff089c7e" />
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-00-52" src="https://github.com/user-attachments/assets/c5cb6a27-6053-4cd8-8500-c48d2fbe552c" />



Make sure ***Use the following IP address:*** is selected in the ***Internet Protocol Version 4 (TCP/IPv4) Properties*** window. Then type the following address information and click ***OK***.
> We are using ***127.0.0.1*** as the preferred DNS server because that address is known as the "loopback" address meaning that when this address is pinged, the machine that pings it will ping itself and the DC will use itself as the DNS server.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-04-16" src="https://github.com/user-attachments/assets/3047cca8-f7b7-48e2-ab24-a098e49f39c5" />


To make things more distinguishable, we will rename these to network adapters as well. One for connections internal to the network and one for external connections.
> The adapter with the IP configurations we made will be the internal NIC and the one that is given IP configurations from the ISP will be the external. Bringing up the details window will show these details.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-11-15" src="https://github.com/user-attachments/assets/061d8368-b125-44a7-a690-cc7e665cbb2e" />


Next, we will rename the PC to make it easier to identify as the DC. Right-click the ***Start*** charm at the bottom left of the screen, select ***System***, and click ***Rename this PC***. We will name it ***DC-01*** and follow the prompts shown. You will be required to restart the machine for the new name to take affect.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-19-31" src="https://github.com/user-attachments/assets/1340c1f0-062f-487b-bae7-2bf6aa5938ce" />
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-22-32" src="https://github.com/user-attachments/assets/72f7d5ea-7afb-43f4-a6ea-e6b9d02692b7" />


Now we will be installing Active Directory in the server manager. In the ***Server Manager Dashboard*** click ***Add roles and features***.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-27-32" src="https://github.com/user-attachments/assets/9e7b6696-27a9-48ec-a7f4-8647cb08af91" />


Click ***Next*** twice in the ***Add Roles and Features Wizard*** and you will arrive at the ***Server Selection*** window, you should only have the server that we just renamed ***DC***. Make sure it's selected and click ***Next***
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-32-19" src="https://github.com/user-attachments/assets/9b587ca8-8e08-42f5-8296-993dbd58e839" />


In the ***Select server roles*** window select ***Active Directory Domain Services*** and click ***Add Features*** in the pop-up window. Multiple roles begin with ***Active Directory***, so make sure you don't click the wrong one by accident.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-38-02" src="https://github.com/user-attachments/assets/ad8e5e81-4b39-408d-98e8-79efea4fdb10" />


Click ***Next*** three times and you will arrive on the ***Confirmation*** section. Click ***Install*** and once it's done installing click ***Close***
> Installing roles in the server manager can take some time. 
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-41-14" src="https://github.com/user-attachments/assets/a67c26d4-abda-4cf9-b0c9-576a396fea69" />


You should now see the role ***AD DS*** added under ***Roles and Server Groups*** in the ***Server Manager Dashboard***
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-48-02" src="https://github.com/user-attachments/assets/85ad656d-65fd-4619-85a9-f1b3f7a47340" />


We will now promote the server to a domain controller. Click the Flag at the top of the ***Server Manager Dashboard*** and click ***Promote the server to a domain controller***
> What we are doing here will be creating the actual domain.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-52-45" src="https://github.com/user-attachments/assets/d7de9242-a38f-406f-b383-56bba469c716" />


Now in the ***Deployment Configuration*** section, click ***Add a new forest*** and in the ***Root domain name*** field type the name of your domain. In my example, I'll be using ***mycooltestorg.com*** as the name of my domain. 

Click ***Next***
<img width="1074" height="897" alt="Screenshot from 2025-07-17 22-25-05" src="https://github.com/user-attachments/assets/268eb34f-91cb-481a-818d-cfd8dd4898c2" />


Here you will be prompted to create a password for the ***Directory Services Restore Mode***. Create a password and click ***Next***
<img width="1074" height="897" alt="Screenshot from 2025-07-17 22-27-28" src="https://github.com/user-attachments/assets/f3b48bdb-d7ce-48fb-a371-4241e61e2f9a" />


We will keep the default settings for the rest of the configuration, so click next until you arrive at the ***Prerequisites Check*** section. Click ***Install*** when the opotion becomes available.
Once finished installing, your system will sign you out. When the DC restarts, you will see the name of your domain when logging in.
> This may take several minutes.
<img width="1074" height="897" alt="Screenshot from 2025-07-17 22-32-23" src="https://github.com/user-attachments/assets/b33f371a-a1e9-4d48-a57c-b93ca4e37f45" />


We will now create a dedicated admin account for this domain instead of using the built-in admin account. From the ***Server Manager Dashboard*** click ***Tools*** at the top right of the screen and select ***Active Directory Users and Computers***
<img width="1052" height="882" alt="Screenshot from 2025-07-17 22-43-32" src="https://github.com/user-attachments/assets/543a66ce-0c65-4b4f-b395-c9faaca4a288" />


Right-click your domain select ***New > Organizational Unit*** and this OU will hold the new admin account we will create. In the ***New Object - Organizational Unit*** pop window type ***_ADMINS*** as the name and uncheck the option below the name field.

Click ***OK***
<img width="1052" height="882" alt="Screenshot from 2025-07-17 22-48-19" src="https://github.com/user-attachments/assets/fc298bee-2afb-4295-946b-5b577db2b82d" />



Now that the Organizational Unit has been created, we can create a new admin account as well as give it the proper permissions and priviledges. Right-click the ***_ADMINS*** OU we just created, select ***New*** and click ***User***.
<img width="1052" height="882" alt="Screenshot from 2025-07-17 22-49-25" src="https://github.com/user-attachments/assets/bfb6816b-a807-4855-8839-e1d7aecd88cc" />


To make it easy, you can use your name as the name of the new admin account. Enter your name in the ***First name*** and ***Last name*** fields. And in the ***User logon name*** field, the naming convention that I use is the last name followed by the first initial, we will be doing the same but we will add ***adm*** suffix to show that it's an admin account.

Click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-17 22-52-48" src="https://github.com/user-attachments/assets/cbe02419-a5e5-48c4-8854-938ad9b90941" />


And then on the next page type in a password for the account and uncheck the ***User must change password at next logon*** box and check the ***Password never expires*** box if this is just a practice lab.

Click ***Next*** and then click ***Finish***
<img width="1052" height="882" alt="Screenshot from 2025-07-17 22-53-34" src="https://github.com/user-attachments/assets/46ebc7d8-702f-4faf-88e5-af42b97cee97" />


Now we will add the user to the domain admin group. Right-click the user and select ***Properties***. 
<img width="1052" height="882" alt="Screenshot from 2025-07-17 23-00-59" src="https://github.com/user-attachments/assets/61d90120-0570-42c8-8f5d-85bc998b6a3f" />


Go to the ***Member of*** tab and click the ***Add*** button. Here we will be adding the user to the earlier mentioned group. In the ***Enter the object names to select*** field type ***Domain adminis*** and click ***Check Names*** and click ***OK*** then ***Apply** and ***OK***
<img width="1052" height="882" alt="Screenshot from 2025-07-17 23-02-16" src="https://github.com/user-attachments/assets/cad79e2b-abad-4e08-b1c5-5f357971491f" />


Now log out of your account and sign in as the domain admin that we just created.
We will now add the DHCP server to our domain so the Windows 10 client we add can receive an IP address. Back on the ***Server Manager Dashboard*** select ***Add roles and features***
![Screenshot35](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/7851824a-de95-41fe-becd-c13ee2d47efe)


Click ***Next***
![Screenshot36](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/7a68386f-7ad3-4963-a454-2c6fc10a6a02)


Click ***Next***
![Screenshot37](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/f2d56aff-a4b9-4254-af2a-3f705036f4dc)


Notice how the server's name changed from ***DC*** to ***DC.mydomain.com*** after we created the domain.

Click ***Next***
![Screenshot38](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/9b1179ec-9b35-48bf-8aff-e23ab97bcee1)


Select ***DHCP Server***, click ***Add feature*** and click ***Next***
![Screenshot39](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/71a3853d-df3f-46af-a5d9-f1dba8c0e1f7)


Click ***Next***
![Screenshot40](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/c7727a87-dc0c-4bee-a481-62f110658559)


Click ***Next***
![Screenshot41](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b0103cca-b978-46d3-a12d-350df19d707d)


Click ***Install*** and once it is done installing click ***Close***
![Screenshot42](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/6902d8c5-00d5-4ef6-a881-4a7ce590fc0b)


Now that we have DHCP on our domain, we will configure the scope. Click ***Tools*** and select ***DHCP***
![Screenshot43](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/d7861787-0058-4876-8f51-dc999db4c527)


Expand your domain in the left pane, and right-click ***IPv4*** and select ***New Scope***
click ***Next in the setup wizard
![Screenshot44](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/576c70ad-5dc9-4f9a-a7a1-ea0eea31a8e1)

For the name you can name it after the IP address range that will be used.
Click ***Next***
![Screenshot45](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b73458b4-b974-4fd2-88a4-680d97d5d7a0)


And for the start and end IP addresses we will use the address range that we used in the name of the scope with a subnet of ***24***.
Click ***Next***
![Screenshot46](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/12b4174e-a567-4f2b-a2c5-3a80eb50b84a)


We will not be including any address exclusions, so click ***Next***
![Screenshot47](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/47a30621-498b-4178-83cb-16c271b5ffec)


Lease duration is how long a device will hold on to an IP address before it is put back into the pool of available IP addresses. Click ***Next***
![Screenshot48](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/48c98d13-3e3b-4dce-8ce1-5b51cb6d1c8f)


Select ***Yes*** and click ***Next***
![Screenshot49](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/4703c98e-7f1a-489e-96be-cb4161674a65)


Type the DC's IP address in the ***IP address*** field, click ***Add***, then click ***Next***
![Screenshot50](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/f3b3a877-78ca-4108-a73b-fe1a048a1832)


Make sure that your domain name is listed in the ***Parent domain*** field and that the IP address for your DC is in the IP address box below and click ***Next***
![Screenshot51](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b6152c87-389d-42e6-9d3f-5833db1545c1)


Click ***Next***
![Screenshot52](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/11989669-671b-4fdf-8ae6-1c9bd8810bd3)


Select ***Yes*** and click ***Next*** and then click ***Finish***
![Screenshot53](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/78fdb156-44b1-474a-89b5-5399e92943e5)


Now right-click your domain server name and select ***Authorize***
![Screenshot54](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b9718a44-c5b1-4853-a981-b240e5b3c419)


Right-click it again and select ***Refresh*** and your ***IPv4*** and ***IPv6*** nodes should be green and your scope should be seen when you expand your ***IPv4*** node.
![Screenshot55](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/84c616ce-5603-4f52-aef7-02981372fc06)


Now we will open our client machine and change the name to ***Client1*** by right-clicking the Windows charm in the bottom left and selecting ***System*** and click ***Rename this PC***. Your system will automatically restart after completing this.
![Screenshot56](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/971eca19-74ec-4045-b255-fc5e0713b349)
![Screenshot57](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/ef9e1d1b-08d3-40d2-9bbe-efd836f49b03)


We will now check our IP configuration and do a ping test in the command prompt. We will run the commands ***ipconfig*** to check the configurations and ***ping mydomain.com*** to check if the two systems can communicate. After following these steps the results from your command inputs should look like this:
![Screenshot58](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a58db081-a0d7-4590-9b27-b4ebb5eddaa3)


And if you go back to the DC, you should notice that the ***Client1*** machine is now listed under the ***Address Leases*** node.
![Screenshot59](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a4ea13e9-3a19-496e-8c83-daebe1931f50)

























