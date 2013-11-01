//
//  App42_API_Utils.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-12.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "App42_API_Utils.h"

@implementation App42_API_Utils
//It declares a static instance of your singleton object and initializes it to nil.
static App42_API_Utils *sharedInstance = nil;
static ServiceAPI *serviceAPIobj = nil;

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(App42_API_Utils *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
        //
        serviceAPIobj = [[ServiceAPI alloc] init];
        serviceAPIobj.apiKey = @"c391f5559629412cb15f24b873e3da03f12f004a048b41ba637b31b03c63c8b6";
        serviceAPIobj.secretKey = @"75750a0348cc2c34e1070fe499c3d4278eca77bdde0841dffcc97f1e41ea6fc2";
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
-(UserService *)getUserService
{
    return [serviceAPIobj buildUserService];
}

-(UploadService *)getUploadService
{
    return [serviceAPIobj buildUploadService];
}

-(CatalogueService *)getCatalogueService
{
    return [serviceAPIobj buildCatalogueService];
}

-(ReviewService *)getReviewService
{
    return [serviceAPIobj buildReviewService];
}

-(StorageService *)getStorageService
{
    return [serviceAPIobj buildStorageService];
}
//
-(NSString *)getDefaultCatalogueName
{
    return @"Food";
}
-(NSString *)getDefaultCategoryName
{
    return @"Western-style";
}
-(NSString *)getTimeStampName
{
    //NSDate timestamp
    NSDate *datenow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    NSLog(@"%@", localeDate);
    //Convert it.
    //NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1363948516];
    //NSLog(@"1363948516  = %@",confromTimesp);
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeStamp);
    return timeStamp;
}
@end
