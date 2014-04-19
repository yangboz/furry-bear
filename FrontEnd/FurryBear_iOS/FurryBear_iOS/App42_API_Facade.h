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
#import "UploadModel.h"
#import "MBProgressHUD.h"

@interface App42_API_Facade : NSObject
{
    
}

+(App42_API_Facade *)sharedInstance;
//Facade exposed interface
#pragma mark -UserService
-(BOOL)userLogin:(NSString *)userName pwdValue:(NSString *)passWord;
-(User *)createUser:(NSString *)userName password:(NSString *)password emailAddress:(NSString *)emailAddress;
#pragma mark -UploadService
-(void)uploadFile:(NSString *)fileName  fileData:(NSData *)imageData
         fileType:(NSString *)fileType
  fileDescription:(NSString *)description;
#pragma mark -CatalogueService
-(void)insertCateItemId;
-(void)insertCateItem:(NSString *)address resturantValue:(NSString *)resturant telephoneValue:(NSString *)telephone agreeNextTimeValue:(BOOL) agreeNextTime;
-(NSMutableArray *)getItemsByCategory:(NSString *)defaultCatalogueName categoryName:(NSString *)defaultCategoryName;
//Catalogue,Category
-(void)createCatalogue:(NSString *)catalogueName catalogueDescription:(NSString *)catalogueDescription;
-(void)createCategory:(NSString *)catalogueName categoryName:(NSString *)categoryName categoryDescription:(NSString *)categoryDescription;
#pragma mark -ReviewService
-(void)createReview:(NSString *)itemID reviewComment:(NSString *)reviewComment reviewRating:(double)reviewRating;
-(int)getReviewsCountByItem:(NSString *)itemId;
-(NSMutableArray *)getReviewsByItem:(NSString *)itemId;
-(Review *)getAverageReviewByItem:(NSString *)itemId;
#pragma mark -StorageService
-(Storage *)findDocumentById:(NSString *)dbName collectionName:(NSString *)collectionName docId:(NSString *)docId;
#pragma mark -RecommenderService
#pragma mark -QueueService
#pragma mark -RewardService
#pragma mark -EmailService
-(Email *)sendMail:(NSString *)sendTo subject:(NSString *)subject Message:(NSString *)message fromEmail:(NSString *)fromEmail emailMIME:(NSString *)emailMIME;
#pragma mark -ScoreBoardService
#pragma mark -LogService
#pragma mark -BuddyService
//friendsRelated
-(NSMutableArray *)getFriendRequests;
-(NSMutableArray *)getAllFriends;
//messageRelated
-(NSMutableArray *)getAllMessagesFromBuddy:(NSString *)buddyName;
-(void)sendFriendRequestFromUser:(NSString *)userName toBuddy:(NSString *)buddyName withMessage:(NSString *)message;
-(void)sendMessage:(NSString *)message toFriend:(NSString *)buddyName fromUser:(NSString *)userName;
@end
