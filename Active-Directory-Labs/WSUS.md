# Windows Server Update Service (WSUS)

## Lab Overview
In this lab we will explore some of the features that Windows Server Update Service (WSUS) has to offer. This includes the types of updates, how these updates are deployed to client devices, and the group of devices that will receive the update.

## What is WSUS?
The **Windows Server Update Service (WSUS)** is a service that fetches updates for Microsoft operating systems and software. Microsoft Update is the source of these updates that are pushed to clients within the Active Directory environment. This process of a WSUS server getting these updates from Microsoft Update is called **Syncronization**.

### WSUS Structure
<p>
A single server or multiple servers can be designated as a <strong>WSUS server</strong>. When there are multiple, they are organized in a hierarchical structure that allows for a downstream of updates from a main WSUS server (Upstream Server). The <strong>Upstream Server</strong> is at the top of the hierarchy and acts as the primary source of updates for an organization and also manages approvals, configurations, and computer groups.
</p>

<p>
Then you have the <strong>Downstream Servers</strong>, these are configured to receive updates from the upstream server instead of from Microsoft Update. Organizing WSUS in this fashion greatly reduces the bandwidth usage since updates are only downloaded a once by the upstream server and distributed internally to the downstream servers. Downstream servers can be placed within network segments to distribute updates to client computers.
</p>

### Downstream Server Modes
There are two modes in which Downstream Servers can be configured, <strong>Replica Mode</strong> and <strong>Autonomous Mode</strong>.
- **Replica Mode** - A server with this configuration inherits the same update approvals and configurations as the upstream server.
- **Autonomous Mode** A server with this configuration has the independence to manage the update approvals and configurations that are retrieved from the upstream server. This allows granular management over update deployments to network segments.
> Microsoft Update synchronizes updates with an Upstream WSUS Server. The Downstream WSUS Servers retrieve updates from the upstream, and client PCs connect to WSUS servers (configured via Group Policy) to receive approved updates. Downstream servers can run in replica or autonomous mode.
![WSUS Architecture Diagram](https://github.com/user-attachments/assets/4bae2df6-b4e1-424b-9df3-90a983108cff)


## Tasks
- [Installing WSUS](#install)
- [Configuring WSUS](#configure)
- [Setting Group Policy](#group-policy)


<a name="install"></a>
## Installing WSUS
I am signed into an admin account on the server that I plan on hosting the WSUS service. Open the **Server Manager** by typing it in the Windows search box below.
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-43-47" src="https://github.com/user-attachments/assets/e699e646-58a0-419c-908e-766d5e10bee2" />


Fromt the Server Manager dashboard, select **Add roles and features**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-47-39" src="https://github.com/user-attachments/assets/f1905931-8191-4136-9922-2e36800f59e7" />


Click **Next** twice and ensure that the selected server is the server you want to install WSUS onto. Click **Next**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-49-01" src="https://github.com/user-attachments/assets/7cbeb599-3838-4964-8145-0ff57de0dfe6" />


On the **Server Roles** section, scroll to the bottom and select **Windows Server Update Services** and select **Add Features**.
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-52-29" src="https://github.com/user-attachments/assets/8c7e2c22-6be1-4264-82f4-0007e96e2ad7" />


Then click **Next** until you arrive ate the **Content** section of the wizard. Here, the wizard is asking for a location to store the updates that will be downloaded from Microsoft Update. Provide a valid local path. I have a secondary drive with a folder labeled **WSUS**. This is the location where I will store updates. Click **Next**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 16-01-48" src="https://github.com/user-attachments/assets/23f7ab87-4d78-462b-8287-3cd37f4545c8" />


Click **Install**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 16-03-18" src="https://github.com/user-attachments/assets/e86f2d50-8b4e-4d8f-a430-7bc299a76d53" />


Once the installation is complete, there are post installation tasks that need to be made. Select **Launch Post-Installation Tasks**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 16-05-35" src="https://github.com/user-attachments/assets/740880a0-2549-49ac-a779-184d7d25a66c" />


If you close out the window without clicking **Launch Post-Installation Tasks**, you can click the flag at the top of the server manager window and select **Launch Post-Installation Tasks** from the drop-down menu.
<img width="1062" height="891" alt="Screenshot from 2025-08-22 17-26-56" src="https://github.com/user-attachments/assets/61697cb2-0ed8-4583-bcde-56bf3cced386" />


<a name="configure"></a>
## Configuring WSUS
Once complete, click **Tools** at the top right of the server manager dashboard window and select **Windows Server Update Services**
<img width="1062" height="891" alt="Screenshot from 2025-08-22 17-31-06" src="https://github.com/user-attachments/assets/648117dd-a56c-4319-9bd4-e863f173c14a" />


A window should pop up prompting you to complete WSUS installation. Ensure the correct local path is selected and click **Run**
> This will appear if you open WSUS before completeing post-installation tasks.
<img width="1062" height="891" alt="Screenshot from 2025-08-22 17-35-21" src="https://github.com/user-attachments/assets/f337519b-3f8f-4a6d-a77f-ecd1eed6172d" />


Once the post-installation tasks are complete, you will be brought to the initial WSUS configuration wizard. Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 12-48-56" src="https://github.com/user-attachments/assets/95e77b98-3b8a-450f-b391-19c87088591d" />


Uncheck the box next to **Yes, I would like to join the Microsoft Update Improvement Program**. Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 12-50-48" src="https://github.com/user-attachments/assets/54cb7ad9-9742-4178-9ff4-0154609a2b62" />


Since this is the upstream WSUS server, we will have this server synchronize from Microsoft Update. In an environment where there are downstream WSUS servers, we would have them synchronize from a WSUS server. Ensure the option **Synchronize from Microsoft Update** is selected. Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 12-56-40" src="https://github.com/user-attachments/assets/099b4383-87fd-4c3f-a90d-e03447dadda5" />


We will not be setting up a proxy server, click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 12-58-26" src="https://github.com/user-attachments/assets/b0878e78-6ded-4543-b73d-98f5f411a21c" />


Now we will begin the connection to Microsoft Update. Click **Start Connecting**
> This can take a significant amount of time depending on network speeds.
<img width="1052" height="891" alt="Screenshot from 2025-08-24 13-02-25" src="https://github.com/user-attachments/assets/efbe1a37-68f9-4e3e-be55-4a0d7d25e321" />


Next we will select which languages the updates will be downloaded in. Choose your native language for updates.
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-03-10" src="https://github.com/user-attachments/assets/87bf312d-06b6-43f6-97d0-58767cb65c0f" />


In this section select the products that the WSUS server will support. I will only be choosing to get updates for Windows 11 client Machines due to the storage space that update packages can consume, check off the following.
- All of the Windows 11 boxes
- Products between **Windows Dictionary Updates** and **Windows Security Platform**

Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-12-06" src="https://github.com/user-attachments/assets/8d862ac8-f10b-434c-bc03-98321e605222" />


On the **Choose Classifications** section, check all boxes except **Driver Sets** and **Drivers**. We will exclude these due to the size of the packages. Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-16-29" src="https://github.com/user-attachments/assets/20b88f0e-e04c-45f4-83cd-b78142ddc7e7" />


For the Sync Schedule we will set it to **Synchronize automatically twice** a day. Synchronizations can be large in size, multiple syncs per day can help reduce resource utilization.
> This does not push any updates to machines that reach out to the WSUS server for updates. It only automatically updates the index within the WSUS server.
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-21-41" src="https://github.com/user-attachments/assets/a89c0cd3-52ea-4398-a8d1-6bfeb17cf5a7" />


Check the box **Begin initial sychronization. Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-23-57" src="https://github.com/user-attachments/assets/d8904b4e-e3fe-44dd-9916-b682e161b7bb" />


Click **Finish**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-25-46" src="https://github.com/user-attachments/assets/d048aec3-2fe8-43ee-8295-7c059c47fa63" />


You will be brought to the WSUS utility screen and you will have access to many features such as **Updates, Computers, Downstream Servers, Synchronizations**, and **Reports**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-35-01" src="https://github.com/user-attachments/assets/ac26d9c8-0861-4043-8be8-5b15d1a335d6" />


If you click on the name of the server, you will be brought to a dashboard that shows an overview of the WSUS server. You can see important statistics such as **Synchronization Status**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-37-45" src="https://github.com/user-attachments/assets/ad801302-9783-491d-b34f-a3c4da9a5392" />


Now we have conpleted the initial configuration of WSUS. There aren't any machines configured to reach out to the WSUS server just yet. Group policy will be used to tell the machine to contact the WSUS server so it can issue these updates.


<a name="group-policy"></a>
## Configuring Group Policy











































