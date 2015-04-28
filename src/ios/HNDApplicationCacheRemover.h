/**
 *
 */

 #import <Cordova/CDVPlugin.h>
 #import <Cordova/CDVInvokedUrlCommand.h>

@interface HNDApplicationCacheRemover : CDVPlugin

- (void)clearApplicationCache:(CDVInvokedUrlCommand*)command;

@end
