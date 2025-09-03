# Windows Server Update Service (WSUS)

## Lab Overview
In this lab we will explore some of the features that Windows Server Update Service (WSUS) has to offer. This includes the types of updates, how these updates are deployed to client devices, and the group of devices that will receive the update.

## What is WSUS?
The **Windows Server Update Service (WSUS)** is a service that collects updates for Microsoft operating systems and software from Microsoft Update (synchronization). The servers and clients reach out to the WSUS server to check for any pending updates and the approved updates are distributed to those machines.

### WSUS Structure
<p>
A single server or multiple servers can be designated as a <strong>WSUS server</strong>. When there are multiple, they are organized in a hierarchical structure that allows for a downstream of updates from a main WSUS server (Upstream Server). The <strong>Upstream Server</strong> is at the top of the hierarchy and acts as the primary source of updates for an organization and also manages approvals, configurations, and computer groups.
</p>

<p>
Then you have the <strong>Downstream Servers</strong>, these are configured to receive updates from the upstream server instead of from Microsoft Update. Organizing WSUS in this fashion greatly reduces the bandwidth usage since updates are only downloaded once by the upstream server and distributed internally to the downstream servers. Downstream servers can be placed within network segments to distribute updates to client computers.
</p>

### Downstream Server Modes
There are two modes in which Downstream Servers can be configured, <strong>Replica Mode</strong> and <strong>Autonomous Mode</strong>.
- **Replica Mode** - A server with this configuration inherits the same update approvals and configurations as the upstream server.
- **Autonomous Mode** A server with this configuration has the independence to manage the update approvals and configurations that are retrieved from the upstream server. This allows granular management over update deployments to network segments.
> Microsoft Update synchronizes updates with an Upstream WSUS Server. The Downstream WSUS Servers retrieve updates from the upstream, and client PCs connect to WSUS servers (configured via Group Policy) to receive approved updates. Downstream servers can run in replica or autonomous mode.
<img width="1920" height="1080" alt="WSUS Architecture Diagram" src="https://github.com/user-attachments/assets/79d6f2eb-b0c0-4708-96c2-0e5ce8166731" />



## Tasks
- [Installing WSUS](#install)
- [Configuring WSUS](#configure)
- [Setting Group Policy](#group-policy)
- [Utilizing Update Approvals](#approvals)


<a name="install"></a>
## Installing WSUS
I am signed into an admin account on the server that I plan on hosting the WSUS service. Open the **Server Manager** by typing it in the Windows search box below.
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-43-47" src="https://github.com/user-attachments/assets/e699e646-58a0-419c-908e-766d5e10bee2" />


From the Server Manager dashboard, select **Add roles and features**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-47-39" src="https://github.com/user-attachments/assets/f1905931-8191-4136-9922-2e36800f59e7" />


Click **Next** twice and ensure that the selected server is the server you want to install WSUS onto. Click **Next**
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-49-01" src="https://github.com/user-attachments/assets/7cbeb599-3838-4964-8145-0ff57de0dfe6" />


On the **Server Roles** section, scroll to the bottom and select **Windows Server Update Services** and select **Add Features**.
<img width="1063" height="889" alt="Screenshot from 2025-08-22 15-52-29" src="https://github.com/user-attachments/assets/8c7e2c22-6be1-4264-82f4-0007e96e2ad7" />


Then click **Next** until you arrive at the **Content** section of the wizard. Here, the wizard is asking for a location to store the updates that will be downloaded from Microsoft Update. Provide a valid local path. I have a secondary drive with a folder labeled **WSUS**. This is the location where I will store updates. Click **Next**
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


Check the box **Begin initial sychronization**. Click **Next**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-23-57" src="https://github.com/user-attachments/assets/d8904b4e-e3fe-44dd-9916-b682e161b7bb" />


Click **Finish**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-25-46" src="https://github.com/user-attachments/assets/d048aec3-2fe8-43ee-8295-7c059c47fa63" />


You will be brought to the WSUS utility screen and you will have access to many features such as **Updates, Computers, Downstream Servers, Synchronizations**, and **Reports**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-35-01" src="https://github.com/user-attachments/assets/ac26d9c8-0861-4043-8be8-5b15d1a335d6" />


If you click on the name of the server, you will be brought to a dashboard that shows an overview of the WSUS server. You can see important statistics such as **Synchronization Status**
<img width="1052" height="891" alt="Screenshot from 2025-08-24 14-37-45" src="https://github.com/user-attachments/assets/ad801302-9783-491d-b34f-a3c4da9a5392" />


Now we have completed the initial configuration of WSUS. There aren't any machines configured to reach out to the WSUS server just yet. Group policy will be used to tell the machine to contact the WSUS server so it can issue these updates.


<a name="group-policy"></a>
## Configuring Group Policy
From my domain controller I will be establishing the policy that will make all client computers look to the WSUS server for updates. In the Server Manager dashboard, click **Tools** at the top right and select **Group Policy Management**
<img width="1042" height="792" alt="Screenshot from 2025-08-26 18-05-18" src="https://github.com/user-attachments/assets/e0f9f625-4db4-444f-a8d9-9d52d0825494" />


Once the Group Policy Management utility opens you are able to see all of the OUs and the group policy objects (GPOs) associated to each respectively. Since this is a lab environment, everything is utilizing the **Default Domain Policy**. We will be creating a new GPO. Right-click on the folder labeled **Group Policy Objects** and select **New**.
<img width="1042" height="792" alt="Screenshot from 2025-08-26 18-13-46" src="https://github.com/user-attachments/assets/35ddb5de-d0fb-4736-8488-5144e2e38437" />


We'll name this **WSUS Policy**. Click **Ok**. The WSUS Policy GPO should appear under the **Group Policy Objects** folder. Right-click the WSUS GPO and select **Edit**
<img width="1042" height="792" alt="Screenshot from 2025-08-26 18-20-17" src="https://github.com/user-attachments/assets/8b2d44a2-3755-42ab-8fce-c024df125f20" />


On the **Group Policy Management Editor** expand **Policies** -> **Administrative Templates: Policy Definitions** -> **Windows Components**. Highlight **Windows Update** and you will be able to see the policies associated with Windows Update
<img width="1042" height="792" alt="Screenshot from 2025-08-26 22-39-49" src="https://github.com/user-attachments/assets/6f806bc6-5a3b-46bd-a043-42512794d368" />


Search the list of items for **Specify intranet Microsoft update service location** and select it. In the Specify intranet Microsoft update service location policy window click **Enabled**. In the **Set intranet update service for detecting updates:** field enter http://<\your server name>\:8530. Copy/paste that value into the second field as well. Keep default settings for the other options. Click **Apply**, then click **Ok**
>Both fields (update service and statistics server) should point to the same WSUS instance in most environments.
<img width="1042" height="792" alt="Screenshot from 2025-08-27 12-54-57" src="https://github.com/user-attachments/assets/9bec1b8d-7a7b-47c2-8d3b-9504f34ee54b" />


In the previous step we specified a server that client machines will download their updates from. The server will also get compliance statistics uploaded to it from those client machines. We also set the WSUS server to listen on port 8530 for HTTP traffic from client machines. This is the default port for WSUS updates over HTTP. In a production environment it is best practice to transmit this data over HTTPS instead of HTTP and set the port to 8531.


Next, search for the policy **Configure Automatic Updates**. Here we will configure when client machines will check in with the WSUS server for any available updates. Click **Enabled**. Ensure that **Auto download and notify for install** is selected in the drop down menu. Schedule the install day for **Every day** at **3:00**. The rest of the settings can be kept as default. Click **Apply** then **Ok**.
<img width="1042" height="792" alt="Screenshot from 2025-08-27 14-22-48" src="https://github.com/user-attachments/assets/9a78b427-a858-4983-8738-bf09cd62649d" />


As you can see, I have an OU containing the clients and servers that are in my organization. Since I want this policy to apply to the clients, this it will be linked to the **Clients** OU that I created.
<img width="1042" height="792" alt="Screenshot from 2025-08-27 14-51-41" src="https://github.com/user-attachments/assets/4fb2f5a1-6199-4ed2-8c97-8437a8bc19ee" />


Going back to the Group Policy Management window, I will be linking the OU that I want this policy to apply to. Right-click the OU you wish to apply the policy to, in my case it is the **Clients** OU and select **Link an Existing GPO...** 
<img width="1042" height="792" alt="Screenshot from 2025-08-27 14-55-20" src="https://github.com/user-attachments/assets/385d0efb-9358-4a14-8253-771d440a3227" />


Select the **WSUS Policy** GPO we just made and click **Ok**.
<img width="1042" height="792" alt="Screenshot from 2025-08-27 17-26-30" src="https://github.com/user-attachments/assets/65d57cc2-b75c-4338-aef0-4b078cd66cf2" />


You should now see the policy appear under the OU it was assigned to.
<img width="1042" height="792" alt="Screenshot from 2025-08-27 17-27-06" src="https://github.com/user-attachments/assets/b45c7263-f87f-40ad-afb8-ac9fe3d51d33" />


To verify that the policy was set into place I will sign into my CLIENT-1 vm. Open a command prompt window by clicking the Windows Start charm in the task bar and type **cmd**. Once open, run the command `gpupdate /force` and this will force the system to update its group policies, to include the policy we just put in place.
<img width="1052" height="882" alt="Screenshot from 2025-08-27 17-48-13" src="https://github.com/user-attachments/assets/2fb93172-73ac-42ce-99ac-b6db6c86279a" />


Now to confirm the policies have been applied click the Windows start charm and select **Settings**
<img width="1052" height="882" alt="Screenshot from 2025-08-27 17-53-55" src="https://github.com/user-attachments/assets/faf8aba5-162b-4991-9c06-7320f204ca51" />


Scroll down the list of items on the left hand side and select **Windows Update**
<img width="1052" height="882" alt="Screenshot from 2025-08-27 17-56-08" src="https://github.com/user-attachments/assets/592ea50f-adb7-4780-9e63-bd2d60ee653e" />


Click **Advanced Options**
<img width="1052" height="882" alt="Screenshot from 2025-08-27 17-57-43" src="https://github.com/user-attachments/assets/10c0a5bc-8bba-411a-9cf8-9381b742d3c8" />


Scroll down and select **Configured Update Policies**
<img width="1052" height="882" alt="Screenshot from 2025-08-27 17-59-57" src="https://github.com/user-attachments/assets/991ae584-4ae6-4c53-bb92-e92ef3437432" />


You should now see the GPOs that we assigned to the WSUS policy from earlier.
<img width="1052" height="882" alt="Screenshot from 2025-08-27 18-01-13" src="https://github.com/user-attachments/assets/bd8a5d55-c40b-4624-a416-d61c617ac7f0" />


<a name="approvals"></a>
## Utilizing Update Approvals
Switching back to my WSUS server SVR-1, on the Update Services utility select **Updates** then **All Updates**. This will be the panel where you will approve or deny pending updates for the machines in your environment.

You will also see that the updates that populated are based on the two filters at the top of the window. You are seeing the updates that have an approval state of **Unapproved** and a status of **Failed or Needed**. You can change the filters to populate the specific updates you want to see.
<img width="1052" height="882" alt="Screenshot from 2025-09-02 17-28-21" src="https://github.com/user-attachments/assets/e803843e-860f-462f-845c-c162e9164864" />


To accept these updates you can simply highlight the update you intend to accept. In my lab I'll be accepting them all. Press ctrl+a on your keyboard to highlight all of the items, then right-click them and select **Approve**.
<img width="1051" height="881" alt="Screenshot from 2025-09-02 18-05-25" src="https://github.com/user-attachments/assets/8157ebd2-55c7-4ec9-821d-3b85996e2fc6" />


On the **Approve Updates** window click the dropdown menu next to **All Computers** and select **Approved for install**. Click **Ok** and accept the license terms on behalf of all of the users in your environment.
<img width="1051" height="881" alt="Screenshot from 2025-09-02 18-08-16" src="https://github.com/user-attachments/assets/7dfe3d9b-44ae-49dc-8c3a-ef835f6b2390" />


An **Approval Progress** window should appear and once the approvals are complete you should see something like this. Click **Close**

If you click **Refresh** at the top of the panel, those updates should be gone since they have been approved.
>Approving updates does not immediately install them on clients, it only makes them available. Clients will download and install them based on the specified GPO schedule.
<img width="1051" height="881" alt="Screenshot from 2025-09-02 18-12-23" src="https://github.com/user-attachments/assets/7e532913-9f0d-4895-ae75-ae254692de9e" />


Now if you go to the server in the **Update Services** utility you will see in the **Download Status** section that the files for the updates are being downloaded.
<img width="1058" height="890" alt="Screenshot from 2025-09-02 18-17-43" src="https://github.com/user-attachments/assets/245ac56b-5b5f-4f2e-8b1c-5c32a6c69801" />


You can also check the status of the update installs of the machines in your environment by selecting **All Computers**
<img width="1058" height="890" alt="Screenshot from 2025-09-02 18-20-30" src="https://github.com/user-attachments/assets/77ad92fb-5341-4e48-bd84-ae96a2ac2a24" />


## Conclusion
In this lab, we installed and configured a WSUS server, synchronized updates from Microsoft Update, and created a Group Policy to direct domain clients to use WSUS. We also explored the approval process to control which updates are deployed. This setup demonstrates how WSUS enables centralized, bandwidth-efficient, and policy-driven update management in an Active Directory environment.


