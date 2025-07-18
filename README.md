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
> The adapter with the IP configurations we made will be the internal NIC and the one that is given IP configurations from the ISP will be the external. ***Right-Click*** an adapter, select ***Status*** and select ***Details*** will show these details.
<img width="1051" height="881" alt="Screenshot from 2025-07-16 22-11-15" src="https://github.com/user-attachments/assets/061d8368-b125-44a7-a690-cc7e665cbb2e" />


I will be naming my naming my adapters ***PUBLIC NIC*** and ***PRIVATE NIC***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-59-39" src="https://github.com/user-attachments/assets/c9a0b14e-2e89-4af6-ade7-b1d147aa88c6" />


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


Now we will add the user to the ***Domain Admins*** group. Right-click the user and select ***Properties***. 
<img width="1052" height="882" alt="Screenshot from 2025-07-17 23-00-59" src="https://github.com/user-attachments/assets/61d90120-0570-42c8-8f5d-85bc998b6a3f" />


Go to the ***Member of*** tab and click the ***Add*** button. Here we will be adding the user to the earlier mentioned group. In the ***Enter the object names to select*** field type ***Domain admins*** and click ***Check Names*** and click ***OK*** then ***Apply** and ***OK***
<img width="1052" height="882" alt="Screenshot from 2025-07-17 23-02-16" src="https://github.com/user-attachments/assets/cad79e2b-abad-4e08-b1c5-5f357971491f" />

Now that you have an admin account aside from the built-in admin account, sign out and sign into the account you just created

To ensure that the client can reach the internet through the domain controller, we will configure Routing Access on the DC. On the Server Manager Dashboard select ***Add Roles and Features***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-16-15" src="https://github.com/user-attachments/assets/4688614b-2347-4974-8aef-82dcc64b24c0" />


Click next in the ***Add Roles and Features*** wizard until you get to the ***Server Roles*** section. Check the box next to ***Remote Access*** and click ***Next*** until you arrive at the ***Role Services*** section
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-20-05" src="https://github.com/user-attachments/assets/99d4d6dd-19f3-4abb-bf82-da2c7793e935" />


On the ***Role Services*** section, select ***Routing*** and click ***Add Features*** in the small pop-up window
>DirectAccess and VPN (RAS) is automatically selected
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-24-29" src="https://github.com/user-attachments/assets/aadad935-7589-49b0-8b86-e25b02e27a96" />


Click ***Next*** until you are given the option to install then select ***Install***
>This may take several minutes
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-26-40" src="https://github.com/user-attachments/assets/198cc5d9-e114-4246-a2e2-d453d58248b2" />


Once the feature wizard finishes the install, click ***Close***. Click ***Tools*** at the top right of the Server Manager Dashboard and select ***Routing and Remote Access***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-36-48" src="https://github.com/user-attachments/assets/1e2ce2a2-ce34-4584-94c0-d07246af2948" />


In the ***Routing and Remote Access*** window, right-click the DC and select ***Configure and Enable Routing and Remote Access*** then click ***Next*** in the wizard
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-41-06" src="https://github.com/user-attachments/assets/b0845c31-08d7-4baa-a02e-69d480d516d7" />


Select ***Network Address Translation (NAT)*** this setting is the key to getting our client access to the internet through the DC's public IP. Click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 10-45-11" src="https://github.com/user-attachments/assets/5b11b357-d641-4471-96b4-1022debc2e28" />


You should be able to see the network adapters that are available on the DC in the ***Network Interfaces*** field; the ones that we renamed. If the ***Network Interfaces*** is empty, just click ***Cancel*** and close the Routing and Remote Access window and reopen it and the NICs should populate

If they did populate, select the public interface and click ***Next*** and ***Finish***
>The DC should have a green up arrow indicating that the service is running.
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-03-51" src="https://github.com/user-attachments/assets/a13a2dc7-bcd9-4e8e-b357-b7d50ca1603d" />


We will now add the DHCP server to our domain so the Windows 10 client we add can receive an IP address. Back on the ***Server Manager Dashboard*** select ***Add roles and features***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-17-06" src="https://github.com/user-attachments/assets/6c78e755-efa9-4f83-a033-fbc2563cab0f" />


Click ***Next*** twice

Notice how the server's name changed from ***DC*** to ***DC-01.mycooltestorg.com*** after we created the domain.

Click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-22-09" src="https://github.com/user-attachments/assets/b96c5042-b03d-4432-8678-69829abd63f2" />


Select ***DHCP Server***, click ***Add feature*** and click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-23-33" src="https://github.com/user-attachments/assets/3b3ab361-8754-49da-9f5b-fe2c69b4573a" />


Click ***Next*** until you can click ***Install***. Once it is done installing click ***Close***
>This may take several minutes.
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-25-32" src="https://github.com/user-attachments/assets/5ee81531-8ef6-4877-9e67-53aeef25892d" />


Now that we have DHCP on our domain, we will configure the scope. Click ***Tools*** and select ***DHCP***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-27-56" src="https://github.com/user-attachments/assets/7fb4ff06-10e0-40bb-9663-9fbff1564f68" />


Expand your domain in the left pane, and right-click ***IPv4*** and select ***New Scope***
click ***Next*** in the setup wizard
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-30-48" src="https://github.com/user-attachments/assets/df0c5f35-aa4d-46fc-9b5e-875397cdb99b" />


For the name you can name it after the IP address range that will be used.
Click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-32-30" src="https://github.com/user-attachments/assets/65f56813-4c41-4e2e-a4ba-ad645b81c32c" />


And for the start and end IP addresses we will use the address range that we used in the name of the scope with a subnet of ***24***.
Click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-35-04" src="https://github.com/user-attachments/assets/f01928e3-0684-4228-9db9-89987cf86207" />


We will not be including any address exclusions, so click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-37-25" src="https://github.com/user-attachments/assets/cd3a9fee-53f0-4428-b28b-b8aa180d6cf8" />


Lease duration is how long a device will hold on to an IP address before it is put back into the pool of available IP addresses. We can keep the default value. Click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-38-14" src="https://github.com/user-attachments/assets/46d2ece5-5ef9-4b6a-afdf-985dc3623f36" />


Select ***Yes*** and click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-38-41" src="https://github.com/user-attachments/assets/16f8570e-73d9-423d-aca3-616dec5ad0e0" />


Type the DC's IP address in the ***IP address*** field, click ***Add***, then click ***Next***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-40-45" src="https://github.com/user-attachments/assets/7e3e017b-ee7a-48d5-8238-8094a1605477" />


Make sure that your domain name is listed in the ***Parent domain*** field and that the IP address for your DC is in the IP address box below and click ***Next*** twice
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-43-41" src="https://github.com/user-attachments/assets/40311bf7-bb48-496c-849d-83d40d6ce951" />


Select ***Yes*** and click ***Next*** and then click ***Finish***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-46-27" src="https://github.com/user-attachments/assets/af509efa-4a86-4268-8aca-3731b15ab6af" />


Now right-click your domain server name and select ***Authorize***
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-48-53" src="https://github.com/user-attachments/assets/478dc2e3-26aa-45ca-9058-c50db1cec8a4" />


Right-click it again and select ***Refresh*** and your ***IPv4*** and ***IPv6*** nodes should be green and your scope should be seen when you expand your ***IPv4*** node.
<img width="1052" height="882" alt="Screenshot from 2025-07-18 11-50-37" src="https://github.com/user-attachments/assets/5c079946-d97c-4f12-ade2-ecfd68519ae5" />


Expand ***IPv4*** right-click ***Server Options*** and select ***Configure Options***
<img width="1051" height="881" alt="Screenshot from 2025-07-18 13-10-44" src="https://github.com/user-attachments/assets/d6604e2b-f497-418c-bb80-9327d15020df" />


Check the box next to ***003 Router*** and enter the DC's IP address in the ***IP Address*** field

Click ***Add***

Click ***Apply***
<img width="1051" height="881" alt="Screenshot from 2025-07-18 13-14-33" src="https://github.com/user-attachments/assets/f030ab59-b20c-40d5-8c32-d0a620b67987" />

To make sure these settings stick, right-click the server, highlight ***All Tasks***, then select ***Restart***
<img width="1051" height="881" alt="Screenshot from 2025-07-18 13-17-38" src="https://github.com/user-attachments/assets/6bf5693c-50be-420c-b0c3-98880e3b616d" />


Expand IPv4 and select ***Server Options*** and you will see that the DC shows as a router.
<img width="1051" height="881" alt="Screenshot from 2025-07-18 13-20-35" src="https://github.com/user-attachments/assets/8fe3a261-61e0-43c3-a8b9-8cf27c7419ae" />


Now we will open our client machine and change the name to ***CLIENT-1*** by right-clicking the Windows charm in the bottom left and selecting ***System*** and click ***Rename this PC***. Your system will automatically restart after completing this.
![Screenshot56](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/971eca19-74ec-4045-b255-fc5e0713b349)
![Screenshot57](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/ef9e1d1b-08d3-40d2-9bbe-efd836f49b03)


We will now check our IP configuration and do a ping test in the command prompt. We will run the commands ***ipconfig*** to check the configurations and ***ping mydomain.com*** to check if the two systems can communicate. After following these steps the results from your command inputs should look like this:
![Screenshot58](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a58db081-a0d7-4590-9b27-b4ebb5eddaa3)


And if you go back to the DC, you should notice that the ***Client1*** machine is now listed under the ***Address Leases*** node.
![Screenshot59](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a4ea13e9-3a19-496e-8c83-daebe1931f50)

























