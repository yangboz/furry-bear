//
//  ItemDataModel.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-11-01.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@interface ItemDataModel : NSObject
{
}

+(ItemDataModel *)sharedInstance;
-(ItemData *)getItemData;
-(void)setItemData:(ItemData *)value;

-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;
@end
