# Origin Private File System Checker 

Want to check on your current browser? [Click here](https://wendylabsinc.github.io/opfs-checker/)

This repo is a simple tool to check if an iOS, macOS, or Android app that has an embedded web view:

- Can support the Origin Private File System APIs 
- Can get the estimated maximum disk size
- Can get the current disk usage
- Can get the percent of the disk that is used

## What is Origin Private File System?

The Origin Private File System is a storage system that is only accessible by a web browser on the specific origin. You can learn more about it [here](https://developer.mozilla.org/en-US/docs/Web/API/File_System_API/Origin_private_file_system).

You can think of it as a private disk space for your web app similar to how mobile apps have their own sandboxed private file system. Except, the Origin Private File System is compartmentalized by the origin (think of it as the app's bundle ID or the web app's URL). 

So if you have a web app that is accessible at `https://example.com` and another web app that is accessible at `https://example2.com/`, they would have separate Origin Private File Systems.

The origin private file system is completely opaque. Meaning that each browser has to implement their own way of interacting with it; most of them are just wrappers around the device's file system. However, that does mean that you can't just access it from outside of the origin. Browsers don't guarantee that there is a 1-1 mapping between the file system on the device and the file system in the Origin Private File System.

The nice thing about the Origin Private File System is that it does not require an alert or permission prompt to have access! So you can create Offline-First applications in JavaScript without issue. 

### What is the Origin Private File System used for?

The Origin Private File System is used for storing data that is specific to the web app or website. This could be things like:

- Offline data
- App data
- User data
- SQLite WASM to store data in a more efficient way than IndexedDB
   - See [this article](https://developer.chrome.com/blog/sqlite-wasm-in-the-browser-backed-by-the-origin-private-file-system) for more information
   - Try it out in your new project with `npm install @sqlite.org/sqlite-wasm` 

## Note on Chrome and Chromium-based Browsers

In browsers based on the Chromium open-source project, including Chrome and Edge, an origin can store up to 60% of the total disk size in both persistent and best-effort modes. This means that if you have 512GB of storage, you would have 307GB of storage for each origin.
[Source](https://developer.mozilla.org/en-US/docs/Web/API/Storage_API/Storage_quotas_and_eviction_criteria)

## Note on WebKit

File System with origin private file system is enabled in WebKit from 242951@main. It is available in Safari on:

* Just Safari on macOS 12.2 and above
* Any Browser on iOS 15.2 and above
[Source]((https://webkit.org/blog/12257/the-file-system-access-api-with-origin-private-file-system/))

Starting with macOS 14 and iOS 17, Safari allots up to around 20% of the total disk space for each origin. [Source](https://developer.mozilla.org/en-US/docs/Web/API/File_System_API/Origin_private_file_system). This means that if you have 512GB of storage, you would have 102GB of storage for each origin

Important note: On iOS, even if you're using the iOS Chrome, Brave, Edge (or any other browser), it actually uses WebKit under the hood. So it's still limited to 20% of the total disk space for each origin. 

