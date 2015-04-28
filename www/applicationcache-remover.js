/**
 * Plugin Interface for the cordova app
 *
 * @author Christian Illies <illies@handspiel.net>
 */
 var exec = require('cordova/exec');
 var ApplicationCacheRemover = {
    clearApplicationCache: function (successCallback, errorCallback) {
        exec(successCallback, errorCallback, "ApplicationCacheRemover", "clearApplicationCache", []);
    }
};

module.exports = ApplicationCacheRemover;
