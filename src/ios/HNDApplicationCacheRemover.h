/**
 *
 */

 #import <Foundation/Foundation.h>
 #import <Cordova/CDVPlugin.h>
 #import <Cordova/CDVInvokedUrlCommand.h>
 #import <sqlite3.h>

@interface HNDApplicationCacheRemover : CDVPlugin

- (void)clearApplicationCache:(CDVInvokedUrlCommand*)command;

@end
