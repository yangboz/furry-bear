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
+(User *)getUser
{
	return user;
}

+(void)setUser:(User *)value
{
	user = value;
}

+(NSMutableArray *)getData
{
	return data;
}

+(void)setData:(NSMutableArray *)value
{
	data = value;
}

@end
