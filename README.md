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

## TODOs

* support Android
* use 'cordova' as namespace instead of the 'ApplicationCacheRemover' global. So a method call would look like `cordova.ApplicationCacheRemover.clear()` instead of the example above.

## Licence

The MIT License (MIT)

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
