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





















































