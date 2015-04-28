# handspiel-plugin-applicationcache-remover

This plugin defines a global `ApplicationCacheRemover` object, which can be used
to clear the complete applicationCache from the **current app** on iOS devices.

## Installation

    cordova plugin add https://github.com/kloener/handspiel-plugin-applicationcache-remover.git

I will push it to the cordova plugins repo soon. 

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
