# Enabling Access-Based Enumeration


## Lab Overview
This lab will cover implementing a security feature offered in Windows that is called Access-Based Enumeration (ABE). I'll enable it for both network shared folders and Distributed File System (DFS) folders.


## What is Access-Based Enumeration?
It simplifies the user's experience by hiding shared network folders they don't have permissions to view. This makes it so only the folders and files they are authorized to interact with appear when browsing a shared network folder. ABE filters folders and files based on NTFS permissions that users/groups have. If they don't at least have **Read** permissions, the folder will not be displayed to them. Here are some benefits of implementing ABE in a production environment:
- ABE keeps sensitive data from being accessed from unauthorized users by limiting visibility.
- Users have a simpler interface when interacting with shared network folders.
- ABE can reduce the "noise" in complex folder structures by hiding irrelivant folders.


