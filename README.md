![what-is-active-directory-and-why-is-it-used](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b70fada4-5e40-4341-b2d3-36ab560c0227)
# Configuring Active Directory (OracleVM VirtualBox)
This tutorial will show the steps to create a basic Windows network environment on a VirtualBox VM that runs on Windows Server 2019 as the Domain Controller (DC) and Windows 10 (Client).

## Environments and Technologies Used
- OracleVM VirtualBox
- Active Directory Domain Services

## Operating Systems Used
- Windows Server 2019
- Windows 10 (22H2)

## Deployment and Configuration Steps
In this lab, we will go through the steps of connecting a client machine to your Domain Controller (DC). These steps include:

- Configuring the IP Address for the DC's internal network
- Installing Active Directory Domain Services
- Creating the domain
- Creating an admin account for the domain
- Adding a DHCP role to the DC
- Configuring the DHCP scope
- Testing domain connectivity with a created user

![VMWare Network](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/d5aa3be6-9445-4bfe-bce3-7959eaa5e5a9)


We will first configure the IP address for the DC's internal network. Click the ***Network*** icon in the system tray located at the bottom right corner of your screen, click your network, and then select ***Change Adapter Settings***
![Screenshot1](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/89f52ce1-dd2a-4e7b-9087-9e0424191977)
![Screenshot2](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/bd4da9fc-ad1b-4ed6-9619-a949eb704f69)


We will next identify the network being used as our domain's internal network. You identify it by double-clicking your network, and in the ***Status*** window that pops up click the ***Details*** button. You will then look for the ***IPv4*** address. If it has an Automatic Private IP Addressing (APIPA), we will be changing that IP address. You can tell it's an APIPA address if the address begins with 169.254 in the first two octets.
![Screenshot3](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/29bb4617-f78e-483f-9e29-b9620974bbae)
![Screenshot4](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/ad698356-f21b-449e-a825-e02450a267c4)


Close the ***Details*** window, select ***Properties*** in the ***Status*** window, and double-click ***Internet Protocol Version 4 (TCP/IPv4)***. In the ***Internet Protocol Version 4 (TCP/IPv4)*** window, we will be assinging the IP address for the internal network.
![Screenshot5](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/5cf4308f-e591-4509-8874-c2a69cb2bbaf)
![Screenshot6](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/8399f98d-dbe0-4684-8da7-b999842c7e8d)


Make sure you click the ***Use the following IP address:*** bubble in the ***Internet Protocol Version 4 (TCP/IPv4) Properties*** window. Then type the following address information and click ***OK***.
> We are using ***127.0.0.1*** as the preferred DNS server because that address is known as the "loopback" address meaning that when this address is pinged, the machine that pings it will ping itself and the DC address will use itself as the DNS server.
![Screenshot7](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/ebbcd7eb-84e8-45ae-82d6-211f94557b91)


Next, we will rename the PC to make it easier to identify as the DC. Right-click the ***Start*** charm at the bottom left of the screen, select ***System***, and click ***Rename this PC***. We will name it ***DC*** and follow the prompts shown.
![Screenshot8](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b13d78ca-82c7-46ab-8fde-f0a5b06611e5)
![Screenshot9](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/e65c5d0e-a025-477b-b11c-2255d70111ee)


Now we will be installing Active Directory in the server manager. In the ***Server Manager Dashboard*** click ***Add roles and features***.
![Screenshot10](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/191ef064-7e70-400a-b046-1a8f0e00a340)


Click ***Next***
![Screenshot11](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a405e88f-0a3d-40ef-8bc9-7dfac476fbdc)


Click ***Next***
![Screenshot12](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/7fbd63ce-1d8e-437a-a57a-f8810b9a4c52)


In the ***Server Selection*** window, you should only have the server that we just renamed ***DC***. Make sure it's selected and click ***Next***
![Screenshot13](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/f387b1d5-cd31-4e83-ba84-5e7aa10cc171)


In the ***Select server roles*** window select ***Active Directory Domain Services*** and click ***Add Features*** in the pop-up window. Multiple roles begin with ***Active Directory***, so make sure you don't click the wrong one by accident.

Click ***Next***
![Screenshot14](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/2667e6d3-9b39-49aa-9ab9-4db236df1ee2)


Click ***Next***
![Screenshot15](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/1c5ca714-2512-4804-9466-af8e3775e145)


Click ***Next***
![Screenshot16](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/57d2d87d-0211-4b21-a745-0d0d34f95b2c)


Click ***Install*** and once it's done installing click ***Close***
> Installing roles in the server manager can take some time.
![Screenshot17](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/32e79243-eddf-4947-a695-f76b995eacd6)


You should now see the role ***AD DS*** added under ***Roles and Server Groups*** in the ***Server Manager Dashboard***
![Screenshot18](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/85ffbf0e-1eac-4e31-a250-5510db8464b9)


We will now promote the server to a domain controller. Click the Flag at the top of the ***Server Manager Dashboard*** and click ***Promote the server to a domain controller***
> What we are doing here will be creating the actual domain.
![Screenshot19](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/c0fa3e9c-0401-4323-a584-61cd00222d78)


Now in the ***Deployment Configuration*** section, click ***Add a new forest*** and in the ***Root domain name*** field type the name of your domain. In my example, I'll be using ***mydomain.com*** as the name of my domain. 

Click ***Next***
![Screenshot20](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/4617a804-df76-401e-a57d-847a073205fc)


Here you will be prompted to create a password for the ***Directory Services Restore Mode***. Create a password and click ***Next***
![Screenshot21](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a4ccdaaf-14dc-4dbd-9454-0987183fd608)


Click ***Next***
![Screenshot22](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/18c685c5-1d35-4ad0-957c-861767b2047b)


Click ***Next***
![Screenshot23](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/4d2cbb6c-0bd2-46b5-a1c4-e9cd6d1aeb07)


Click ***Next***
![Screenshot24](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/d63da796-d3f6-40d1-b300-ad6d384a7d00)


Click ***Next***
![Screenshot25](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/dc4f5afb-a0a8-4869-9589-39d5f84fca09)


Click ***Install***
Once finished installing, your system will prompt you to restart.
> This may take a while.
![Screenshot26](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/6829af79-1965-49cc-b4c5-49cf9ef478f7)


We will now create a dedicated admin account for this domain instead of using the built-in admin account. From the ***Server Manager Dashboard*** click ***Tools*** at the top right of the screen and select ***Active Directory Users and Computers***
![Screenshot27](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/b7e2a7b0-9bc9-4df3-9891-183c5ee1b1f1)


Right-click your domain select ***New > Organizational Unit*** and this OU will hold the new admin account we will create. In the ***New Object - Organizational Unit*** pop window type ***_ADMINS*** as the name and uncheck the option below the name field.

Click ***OK***
![Screenshot29](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/a0178ee0-41f5-4ce5-b792-f5161413c378)


Now that the Organizational Unit has been created, we can create a new admin account as well as give it the proper permissions and priviledges. Right-click the ***_ADMINS*** OU we just created, select ***New*** and click ***User***.
![Screenshot30](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/7fb66111-e591-41b4-9ecf-00e84ec9953f)


To make it easy, you can use your name as the name of the new admin account. Enter your name in the ***First name*** and ***Last name*** fields. And in the ***User logon name*** field, a common way that usernames are assigned are first initial then last name, we will be doing the same but we will add ***a-*** to show that it's an admin account.

Click ***Next***
![Screenshot31](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/f0f14d60-b850-4dc7-99b3-af21912f70e0)


And then on the next page type in a password for the account and uncheck the ***User must change password at next logon*** box and check the ***Password never expires*** box if this is just a practice lab.

Click ***Next*** and then click ***Finish***
![Screenshot32](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/c79f2f74-778a-4f7a-a2c5-7d1a0d726b4d)


Now we will add the user to the domain admin group. Right-click the user and select ***Properties***. 
![Screenshot33](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/770cbf53-873e-4118-9dc2-70047a9086b9)


Go to the ***Member of*** tab and click the ***Add*** button. Here we will be adding the user to the earlier mentioned group. In the ***Enter the object names to select*** field type ***Domain adminis*** and click ***Check Names*** and click ***OK*** then ***Apply** and ***OK***
![Screenshot34](https://github.com/Brandon-Baker11/Configuring-Active-Directory/assets/140644499/ab7c43d1-039a-41c2-a399-78986261d6c0)


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

























