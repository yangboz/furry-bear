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
static BOOL introViewed=NO;
static NSMutableArray *friendRequests=nil;
static NSMutableArray *allFriends=nil;
static NSMutableArray *categoryList=nil;

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
        user.userName = [defaults objectForKey:PREFERENCE_KEY_USER_NAME];
        user.password = [defaults objectForKey:PREFERENCE_KEY_PASS_WORD];
    }
	return user;
}
#pragma mark - User perference saves
-(void)setUser:(User *)value
{
	user = value;
    //Saving the login data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value.userName forKey:PREFERENCE_KEY_USER_NAME];
    [userDefaults setObject:value.password forKey:PREFERENCE_KEY_PASS_WORD];
    [userDefaults synchronize];
}

-(void)setIntroViewed:(BOOL)value
{
    //Saving the login data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:PREFERENCE_KEY_INTRO_VIEWED];
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

-(void)setFriendRequests:(NSMutableArray *)value
{
    friendRequests = value;
}

-(NSMutableArray *)getFriendRequests
{
    return friendRequests;
}

-(void)setAllFriends:(NSMutableArray *)value
{
    allFriends = value;
}

-(NSMutableArray *)getAllFriends
{
    return allFriends;
}

#pragma mark - Settings.bundle
-(BOOL)getAutoSignin;
{
    //@see http://www.ecanarys.com/blog-entry/implementing-ios-setting-bundle
    //read ios setting bundle
    ///for reading default value
    //Set the application defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *testValue=[defaults stringForKey:PREFERENCE_KEY_AUTO_SIGN_IN];
    NSLog(@"autoSignin_preference value(before register):%@",testValue);
    //@see http://useyourloaf.com/blog/2010/05/18/adding-a-settings-bundle-to-an-iphone-app.html
    if([testValue isEqual:nil])
    {
        //Set the application defaults
        NSDictionary *autoSigninDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:PREFERENCE_KEY_AUTO_SIGN_IN];
        [defaults registerDefaults:autoSigninDefaults];
        [defaults synchronize];
    }else{//Get preferences
        autoSignin = [defaults boolForKey:PREFERENCE_KEY_AUTO_SIGN_IN];
        NSLog(@"autoSignin_preference value(after register):%@",testValue);
    }
    //
    return autoSignin;
}
-(BOOL)getIntroViewed;
{
    //@see http://www.ecanarys.com/blog-entry/implementing-ios-setting-bundle
    //read ios setting bundle
    ///for reading default value
    //Set the application defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *testValue=[defaults stringForKey:PREFERENCE_KEY_INTRO_VIEWED];
    NSLog(@"introView_preference value(before register):%@",testValue);
    //@see http://useyourloaf.com/blog/2010/05/18/adding-a-settings-bundle-to-an-iphone-app.html
    if([testValue isEqual:nil])
    {
        //Set the application defaults
        NSDictionary *introViewedDefaults = [NSDictionary dictionaryWithObject:@"NO" forKey:PREFERENCE_KEY_INTRO_VIEWED];
        [defaults registerDefaults:introViewedDefaults];
        [defaults synchronize];
    }else{//Get preferences
        introViewed = [defaults boolForKey:PREFERENCE_KEY_INTRO_VIEWED];
        NSLog(@"introView_preference value(after register):%@",testValue);
    }
    //
    return introViewed;
}

#pragma mark CategoryList

-(NSMutableArray *)getCategoryList
{
    return categoryList;
}

-(void)setCategoryList:(NSMutableArray *)value
{
    categoryList = value;
}

@end
