//
//  StorageModel.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-11-01.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

#define KEY_NAME_ADDRESS @"address"
#define KEY_NAME_TELPHONE @"telphone"
#define KEY_NAME_RESTAURANT @"restaurant"
#define KEY_NAME_AGREE_NEXT_TIME @"agreeNextTime"

@interface StorageModel : NSObject
{
}

+(StorageModel *)sharedInstance;
-(Storage *)getStorage;
-(void)setStorage:(Storage *)value;

-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;
@end
