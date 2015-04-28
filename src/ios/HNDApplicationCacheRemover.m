/**
 The class can delete the whole ApplicationCache.db file from the
 current app bundle.
 Be careful while using it, it could also crash your app if we wouldn't
 quit the app after deletion.

 @author Christian Illies
*/

#import <Cordova/CDVPluginResult.h>

@implementation HNDApplicationCacheRemover

static NSString *cacheDatabaseName = @"ApplicationCache.db";

- (void)clearApplicationCache:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult;

    /*Check that the db is created, if not we return as sqlite3_open would create
     an empty database and webkit will crash on us when accessing this empty database*/
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self cacheDatabasePath]]) {
      /*
        No database means no cache so the command is okay.
       */
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }

    if (![[NSFileManager defaultManager] removeItemAtPath:[self cacheDatabasePath]]) {
        NSLog(@"HNDApplicationCacheRemover: The cache manifest db could not be deleted!");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"could not delete database."];
    } else {
      // files was deleted successfully so return command okay.
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }

    // setKeepCallback is for async processes.. isn't it?
    // [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];

    // return result to the app
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/**
 Retrieves the path of the ApplicationCache sqite db. The db is located in `Library/Caches/your.bundle.id/ApplicationCache.db`

 @source http://www.benjaminloulier.com/posts/clear-the-html5-application-cache-of-an-uiwebview/

 @return The path of the db
 */
- (NSString *)cacheDatabasePath {
    NSArray *pathsList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *pathSuffix = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundleIdentifier], cacheDatabaseName];
    NSString *path = [(NSString *)pathsList[0] stringByAppendingPathComponent:pathSuffix];
    return path;
}


@end
