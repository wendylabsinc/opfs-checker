# Origin Private File System Checker 

Want to check on your current browser? [Click here](https://wendylabsinc.github.io/opfs-checker/)

This repo is a simple tool to check if an iOS, macOS, or Android app that has an embedded web view:

- Can support the Origin Private File System APIs 
- Can get the estimated maximum disk size
- Can get the current disk usage
- Can get the percent of the disk that is used

## What is Origin Private File System?

The Origin Private File System is a storage system that is only accessible by a web browser on the specific origin. You can learn more about it [here](https://developer.mozilla.org/en-US/docs/Web/API/File_System_API/Origin_private_file_system).

## Note on Chrome and Chromium-based Browsers

In browsers based on the Chromium open-source project, including Chrome and Edge, an origin can store up to 60% of the total disk size in both persistent and best-effort modes.
[Source](https://developer.mozilla.org/en-US/docs/Web/API/Storage_API/Storage_quotas_and_eviction_criteria)


## Note on WebKit

File System with origin private file system is enabled in WebKit from 242951@main. It is available in Safari on:

* Just Safari on macOS 12.2 and above
* Any Browser on iOS 15.2 and above
[Source]((https://webkit.org/blog/12257/the-file-system-access-api-with-origin-private-file-system/))

Starting with macOS 14 and iOS 17, Safari allots up to around 20% of the total disk space for each origin. [Source](Starting with macOS 14 and iOS 17, Safari allots up to around 20% of the total disk space for each origin. )