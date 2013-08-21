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
        serviceAPIobj.apiKey = @"bed6761e541cd0a135104c31b2f736a02b7294eef20daee891c1a5b864fb93fd";
        serviceAPIobj.secretKey = @"b3d47468ec8dd5a232c5b6dbd4efd5c2f4fc954575c809fc16f4e6252dd1cdd6";
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
-(NSString *)getDefaultCatalogueName
{
    return @"Food";
}
-(NSString *)getDefaultCategoryName
{
    return @"Western-style";
}
@end
