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
//Sets
-(void)setUser:(User *)value;
-(void)setIntroViewed:(BOOL)value;
//
-(void)setBuddyName:(NSString *)value;
-(void)setAllFriends:(NSMutableArray *)value;
-(void)setFriendRequests:(NSMutableArray *)value;
//Gets
-(User *)getUser;
//friendsRelated
-(NSMutableArray *)getFriendRequests;
-(NSMutableArray *)getAllFriends;
//BuddyServie
-(NSString *)getBuddyName;
//Settings.bundle
-(BOOL)getAutoSignin;
-(BOOL)getIntroViewed;
//messageRelated
//-(NSMutableArray *)getAllMessagesFromBuddy:(NSString *)buddyName;
//
-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;

@end




