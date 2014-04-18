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

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(App42_API_Utils *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
        //
	}
    //
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

//
#pragma mark -Default variables
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

-(NSString *)getFormattedDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter stringFromDate:date];
}

@end
