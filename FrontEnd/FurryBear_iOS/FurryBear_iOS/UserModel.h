//
//  UserModel.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-10.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@interface UserModel : NSObject
{
}

+(UserModel *)sharedInstance;
-(User *)getUser;
-(void)setUser:(User *)value;

-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;

@end




