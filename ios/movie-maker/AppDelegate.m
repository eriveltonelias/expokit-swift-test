// Copyright 2015-present 650 Industries. All rights reserved.

#import "AppDelegate.h"
#import "ExpoKit.h"
#import "EXViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) EXViewController *rootViewController;

@end

@implementation AppDelegate

RCT_EXPORT_MODULE()

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [[ExpoKit sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    _rootViewController = [ExpoKit sharedInstance].rootViewController;
    _window.rootViewController = _rootViewController;
    
    [_rootViewController loadReactApplication];
    [_window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - Handling URLs

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    return [[ExpoKit sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray * _Nullable))restorationHandler
{
    return [[ExpoKit sharedInstance] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

#pragma mark - Notifications

- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification
{
    [[ExpoKit sharedInstance] application:application didReceiveLocalNotification:notification];
}


- (void)goToReactNative {
    
    [self.window.rootViewController dismissViewControllerAnimated:TRUE completion:nil];
    
}

- (void)goNativeStoryboard {
    
    UIViewController *vc = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    
    [self.window.rootViewController presentViewController:vc animated:true completion:nil];
    
}

@end
