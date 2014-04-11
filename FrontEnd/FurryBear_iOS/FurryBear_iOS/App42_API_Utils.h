//
//  App42_API_Utils.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-12.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

#import "JSONKit.h"
#import "UserModel.h"
#import "ItemDataModel.h"
#import "Prefs.h"

@interface App42_API_Utils : UIView
{
    
}
+(App42_API_Utils *)sharedInstance;
//
-(UserService *)getUserService;
-(UploadService *)getUploadService;
-(CatalogueService *)getCatalogueService;
-(ReviewService *)getReviewService;
-(StorageService *)getStorageService;
-(RecommenderService *)getRecommenderService;
-(QueueService *)getQueueService;
-(ScoreBoardService *)getScoreBoardService;
-(EmailService *)getEmailService;
-(BuddyService *)getBuddyService;
-(LogService *)getLogService;
//
-(NSString *)getDefaultCatalogueName;
-(NSString *)getDefaultCategoryName;
-(NSString *)getTimeStampName;
-(NSString *)getFormattedDate:(NSDate *)date;


@end
