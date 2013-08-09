//
//  AppDelegate.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //Initialize the App42 serviceAPI instance
    NSString *userName = @"KnightZhou";
    NSString *password = @"7740321";
    ServiceAPI *serviceAPIObj = [[ServiceAPI alloc] init];
    serviceAPIObj.apiKey = @"c391f5559629412cb15f24b873e3da03f12f004a048b41ba637b31b03c63c8b6";
    serviceAPIObj.secretKey = @"75750a0348cc2c34e1070fe499c3d4278eca77bdde0841dffcc97f1e41ea6fc2";
    UserService *userService = [serviceAPIObj buildUserService];
    
    User *user = [userService authenticateUser:userName password:password];
    NSString *jsonResponse = [user userName];
    NSLog(@"App42 user authenticate result:%@",jsonResponse);
    //
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
