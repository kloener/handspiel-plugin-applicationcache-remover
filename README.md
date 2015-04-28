# handspiel-plugin-applicationcache-remover

This plugin defines a global `ApplicationCacheRemover` object, which can be used
to clear the complete applicationCache from the **current app** on iOS devices.

## Installation

    cordova plugin add handspiel-plugin-applicationcache-remover

For iOS platform, after you add the plugin, you will also have to add "libsqlite3.dylib" for linking. To do that, perform the following:

* Click on the project name on the left pane in XCode. That would load the project configurations.
* Click on the 'Build Phases' tab. Next select 'Link Binary With Libraries'
* Click the '+' icon to add a library. In the dialog box that appears, search for sqlite and select "libsqlite3.0.dylib".

## Properties

* ApplicationCacheRemover.clearApplicationCache

### ApplicationCacheRemover.clearApplicationCache

This method tries to clear the whole applicationCache by deleting all entries in `Caches` and `CacheGroups` from the `ApplicationCache.db` sqlite-file from the current app. It accepts two callback
parameters.

    ApplicationCacheRemover.clearApplicationCache(successCallback, errorCallback);

Example:

    ApplicationCacheRemover.clearApplicationCache(
      function(){ console.log("success"); },
      function(){ console.log("error"); }
    );

#### Supported Platforms

* iOS

## Licence

[creative commons - Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)
