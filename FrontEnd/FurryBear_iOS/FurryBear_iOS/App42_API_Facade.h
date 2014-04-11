//
//  App42_API_Facade.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-11.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
//
#import "App42_API_Utils.h"
#import "JSONKit.h"
#import "UserModel.h"
#import "ItemDataModel.h"
#import "Prefs.h"

@interface App42_API_Facade : NSObject
{

}

+(App42_API_Facade *)sharedInstance;
//Facade exposed interface
#pragma mark -UserService

#pragma mark -UploadService

#pragma mark -CatalogueService
-(void)setCateItemId;

#pragma mark -ReviewService
#pragma mark -StorageService
#pragma mark -RecommenderService
#pragma mark -QueueService
#pragma mark -RewardService
#pragma mark -EmailService
#pragma mark -ScoreBoardService
#pragma mark -LogService


@end
