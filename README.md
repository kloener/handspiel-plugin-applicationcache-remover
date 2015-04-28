# handspiel-plugin-applicationcache-remover

This plugin defines a global `ApplicationCacheRemover` object, which can be used
to clear the complete applicationCache on iOS devices.

    ## Limitation

    Your app should be restarted after clearing the cache. Otherwise the
    app still has a cache loaded in memory.

## Installation

    cordova plugin add handspiel-plugin-applicationcache-remover

For iOS platform, after you add the plugin, you will also have to add "libsqlite3.0.dylib" for linking. To do that, perform the following:

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
      function(msg){ console.log("success: " + msg); },
      function(msg){ console.log("error: "   + msg); }
    );

#### Supported Platforms

* iOS
