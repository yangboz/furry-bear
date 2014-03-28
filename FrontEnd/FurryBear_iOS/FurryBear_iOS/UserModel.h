//
//  UserModel.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-10.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42_API_Utils.h"

@interface UserModel : NSObject
{
}

+(UserModel *)sharedInstance;
-(User *)getUser;
-(void)setUser:(User *)value;
//BuddyServie
-(NSString *)getBuddyName;
-(void)setBuddyName:(NSString *)value;
//Settings.bundle
-(BOOL)getAutoSignin;
//getFriendRequests
-(NSMutableArray *)getFriendRequests;
//
-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;

@end




