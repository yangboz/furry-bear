//
//  UserModel.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-10.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App42_API_Facade.h"

@interface UserModel : NSObject
{
}

+(UserModel *)sharedInstance;
-(User *)getUser;
//Sets
-(void)setUser:(User *)value;
-(void)setIntroViewed:(BOOL)value;
//BuddyServie
-(NSString *)getBuddyName;
-(void)setBuddyName:(NSString *)value;
//Settings.bundle
-(BOOL)getAutoSignin;
-(BOOL)getIntroViewed;
//friendsRelated
-(NSMutableArray *)getFriendRequests;
-(NSMutableArray *)getAllFriends;
//messageRelated
-(NSMutableArray *)getAllMessagesFromBuddy:(NSString *)buddyName;
//
-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;
//
-(int)numberOfFriendRequests;
@end




