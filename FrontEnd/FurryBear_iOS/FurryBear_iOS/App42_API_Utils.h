//
//  App42_API_Utils.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-12.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@interface App42_API_Utils : NSObject
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
//
-(NSString *)getDefaultCatalogueName;
-(NSString *)getDefaultCategoryName;
-(NSString *)getTimeStampName;
@end
