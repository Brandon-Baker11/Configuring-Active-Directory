# Windows Server Update Service (WSUS)

## Lab Overview
In this lab we will explore some of the features that Windows Server Update Service (WSUS) has to offer. This includes the types of updates, how these updates are deployed to client devices, and the group of device that will receive the update.

## What is WSUS?
The **Windows Server Update Service (WSUS)** is a service that fetches updates for Microsoft operating systems and software. Microsoft Update is the source of these updates that are pushed to clients within the Active Directory environment. This process of a WSUS server getting these updates from Microsoft Update is called **Syncronization**.

## WSUS Structure
A single server or multiple servers can be designated as a **WSUS server**. When there are multiple, they are organized in a hierarchical structure that allows for a downstream of updates from a main WSUS server (Upstream Server). The **upstream server** at the top of the hierarchy and it acts as the primary source of updates for an organization and also manages approvals, configurations, and computer groups. Then you have the **Downstream Servers**, these are configured to receive updates from the upstream server instead of from Microsoft Update. Organizing WSUS in this fashion greatly reduces the bandwidth usage since updates are only downloaded a once by the upstream server and distributed internally to the downstream servers. Downstream servers can be placed within network segments to distribute updates to client computers.


