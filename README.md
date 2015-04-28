# handspiel-plugin-applicationcache-remover

This plugin defines a global `ApplicationCacheRemover` object, which can be used
to clear the complete applicationCache on iOS devices.

## Installation

    cordova plugin add handspiel-plugin-applicationcache-remover

## Properties

* ApplicationCacheRemover.clearApplicationCache

### ApplicationCacheRemover.clearApplicationCache

This method tries to clear the whole applicationCache by removing the
ApplicationCache.db file from the current app. It accepts two callback
parameters.

    ApplicationCacheRemover.clearApplicationCache(successCallback, errorCallback);

Example:

    ApplicationCacheRemover.clearApplicationCache(
      function(msg){ console.log("success: " + msg); },
      function(msg){ console.log("error: "   + msg); }
    );

#### Supported Platforms

* iOS
