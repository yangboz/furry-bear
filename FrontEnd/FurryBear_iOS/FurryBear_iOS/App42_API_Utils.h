//
//  App42_API_Utils.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-12.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App42_API_Utils : UIView
{
    
}
+(App42_API_Utils *)sharedInstance;
//
-(NSString *)getDefaultCatalogueName;
-(NSString *)getDefaultCategoryName;
-(NSString *)getTimeStampName;
-(NSString *)getFormattedDate:(NSDate *)date;


@end
