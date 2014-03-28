//
//  UserModel.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-10.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "UserModel.h"
//@see http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CocoaFundamentals/CocoaObjects/CocoaObjects.html
@implementation UserModel

//It declares a static instance of your singleton object and initializes it to nil.
static UserModel *sharedInstance = nil;
static User *user=nil;
static NSMutableArray *data=nil;
static NSString *buddyName=nil;
static BOOL autoSignin=YES;
static NSMutableArray *friendRequests=nil;
static NSMutableArray *allFriends=nil;
static NSMutableArray *messagesFromBuddy=nil;

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(UserModel *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
	}
	return sharedInstance;
}
//It overrides the allocWithZone: method to ensure that another instance is not allocated if someone tries to allocate and initialize an instance of your class directly instead of using the class factory method. Instead, it just returns the shared object.
+(id)allocWithZone:(NSZone *)zone
{
	return [ [self sharedInstance] retain];
}
//It implements the base protocol methods copyWithZone:, release, retain, retainCount, and autorelease to do the appropriate things to ensure singleton status. (The last four of these methods apply to memory-managed code, not to garbage-collected code.)
-(id)copyWithZone:(NSZone *)zone
{
	return self;
}

-(id)retain
{
	return self;
}

-(NSUInteger)retainCount
{
	return NSUIntegerMax;//denotes an object that cannot be released.
}

//-(void)release
//{
//	//do nothing.
//}

//implementations
-(User *)getUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (defaults != nil) {
        user.userName = [defaults objectForKey:@"userName"];
        user.password = [defaults objectForKey:@"passWord"];
    }
	return user;
}

-(void)setUser:(User *)value
{
	user = value;
    //Saving the login data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value.userName forKey:@"userName"];
    [userDefaults setObject:value.password forKey:@"passWord"];
    [userDefaults synchronize];
}

-(NSMutableArray *)getData
{
	return data;
}

-(void)setData:(NSMutableArray *)value
{
	data = value;
}

#pragma mark - BuddyService
-(NSString *)getBuddyName;
{
    return buddyName;
}
-(void)setBuddyName:(NSString *)value;
{
    buddyName = value;
}
#pragma mark - Settings.bundle
-(BOOL)getAutoSignin;
{
    //@see http://www.ecanarys.com/blog-entry/implementing-ios-setting-bundle
    //read ios setting bundle
    ///for reading default value
    NSString *kAutoSigninKey=@"autoSignin_preference";
    //Set the application defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *testValue=[defaults stringForKey:kAutoSigninKey];
    NSLog(@"autoSignin_preference value(before register):%@",testValue);
    //@see http://useyourloaf.com/blog/2010/05/18/adding-a-settings-bundle-to-an-iphone-app.html
    if([testValue isEqual:nil])
    {
        //Set the application defaults
        NSDictionary *autoSigninDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:kAutoSigninKey];
        [defaults registerDefaults:autoSigninDefaults];
        [defaults synchronize];
    }else{//Get preferences
        autoSignin = [defaults boolForKey:kAutoSigninKey];
        NSLog(@"autoSignin_preference value(after register):%@",testValue);
    }
    //
    return autoSignin;
}
#pragma mark - Friends related
-(NSMutableArray *)getFriendRequests
{
    //App42_API_Utils
    BuddyService *buddyService = [[App42_API_Utils sharedInstance] getBuddyService];
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    @try{
        //App42 service API call here.
        NSArray *buddys = [buddyService getFriendRequest:userName];
        NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
        NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
        NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
        NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
        //fill up the UITableView at first.
        friendRequests = [NSMutableArray arrayWithArray:buddys];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
        //None friend request
        friendRequests = [[NSMutableArray alloc] init];
    }
    return friendRequests;
}
//
-(NSMutableArray *)getAllFriends
{
    //App42_API_Utils
    BuddyService *buddyService = [[App42_API_Utils sharedInstance] getBuddyService];
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    @try{
        //App42 service API call here.
        NSArray *buddys = [buddyService getAllFriends:userName];
        NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
        NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
        NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
        NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
        //fill up the UITableView at first.
        allFriends = [NSMutableArray arrayWithArray:buddys];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
        //None friend request
        allFriends = [[NSMutableArray alloc] init];
    }
    return allFriends;
}
#pragma mark - Messages related
-(NSMutableArray *)getAllMessagesFromBuddy:(NSString *)buddyName
{
    //App42_API_Utils
    BuddyService *buddyService = [[App42_API_Utils sharedInstance] getBuddyService];
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    @try{
        //App42 service API call here.
        NSArray *buddys = [buddyService getAllMessagesFromBuddy:buddyName toUser:userName];
        NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
        NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
        NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
        NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
        //fill up the UITableView at first.
        messagesFromBuddy = [NSMutableArray arrayWithArray:buddys];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
        //None friend request
        messagesFromBuddy = [[NSMutableArray alloc] init];
    }
    return messagesFromBuddy;
};
@end
