/**
 The class can delete the whole ApplicationCache.db file from the
 current app bundle.
 Be careful while using it, it could also crash your app if we wouldn't
 quit the app after deletion.

 @author Christian Illies
*/

#import <Cordova/CDVPluginResult.h>
#import "HNDApplicationCacheRemover.h"

@implementation HNDApplicationCacheRemover

static NSString *cacheDatabaseName = @"ApplicationCache.db";
static NSString *cacheTable = @"Caches";
static NSString *cacheGroupTable = @"CacheGroups";

- (void)clearApplicationCache:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult;
    sqlite3* newDBconnection;

    /*Check that the db is created, if not we return as sqlite3_open would create
     an empty database and webkit will crash on us when accessing this empty database*/
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self cacheDatabasePath]]) {
      /*
        No database means no cache so the command is okay.
       */
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    else {
      if (sqlite3_open([[self cacheDatabasePath]  UTF8String], &newDBconnection) == SQLITE_OK) {
        if (sqlite3_exec(newDBconnection, "BEGIN EXCLUSIVE TRANSACTION", 0, 0, 0) != SQLITE_OK) {
          NSLog(@"SQL Error: %s", sqlite3_errmsg(newDBconnection));
          pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"could not start transaction."];
        }
        else {
          /*Remove the corresponding entries in the Caches and CacheGroups tables*/
          [self deleteCacheResourcesUsingDBConnection:newDBconnection];
          [self deleteCacheGroupsUsingDBConnection:newDBconnection];
          if (sqlite3_exec(newDBconnection, "COMMIT TRANSACTION", 0, 0, 0) != SQLITE_OK) {
            NSLog(@"SQL Error: %s",sqlite3_errmsg(newDBconnection));
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"committing failed."];
          }
          else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
          }
        }
        sqlite3_close(newDBconnection);
      }
      else {
        NSLog(@"Error opening the database located at: %@", [self cacheDatabasePath]);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"database couldn't be opened."];
        newDBconnection = NULL;
      }
    }
    // setKeepCallback is for async processes.. isn't it?
    // [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];

    // return result to the app
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/**
 * deletes all entries if the given table in the sqlite connection
 *
 * @param NSString table the table you wanna clear
 * @param sqlite3 db connection to the sqlite database
 *
 * @return BOOL YES on success, otherwise NO
 */
- (BOOL)_clearSQLiteTable:(NSString *)table usingDBConnection:(sqlite3 *)db {
  sqlite3_stmt *statement;
  BOOL returnValue = NO;
  // query will delete ALL sets in the CACHES table.
  NSString *queryString = [NSString stringWithFormat:@"DELETE FROM %@", table];
  const char *query = [queryString UTF8String];
  if (sqlite3_prepare_v2(db, query, -1, &statement, NULL) == SQLITE_OK)
  {
    sqlite3_step(statement);
    returnValue = YES;
  } else {
    NSLog(@"SQL Error: %s", sqlite3_errmsg(db));
    returnValue = NO;
  }
  sqlite3_finalize(statement);
  return returnValue;
}

/**
 * deletes the whole table-entries in `Caches` from the ApplicationCache.db.
 *
 * @param SQLiteConnection db
 *
 * @return BOOL YES on success, otherwise NO
 */
- (BOOL)deleteCacheResourcesUsingDBConnection:(sqlite3 *)db {
    return [self _clearSQLiteTable:cacheTable usingDBConnection:db];
}

/**
 * deletes the whole table-entries in `CacheGroups` from the ApplicationCache.db.
 *
 * @param SQLiteConnection db
 *
 * @return BOOL YES on success, otherwise NO
 */
- (BOOL)deleteCacheGroupsUsingDBConnection:(sqlite3 *)db {
    return [self _clearSQLiteTable:cacheGroupTable usingDBConnection:db];
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
