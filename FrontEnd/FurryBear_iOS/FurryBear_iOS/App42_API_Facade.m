//
//  App42_API_Facade.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-11.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "App42_API_Facade.h"

@implementation App42_API_Facade
//It declares a static instance of your singleton object and initializes it to nil.
static App42_API_Facade *sharedInstance = nil;
//
static ServiceAPI *serviceAPIobj = nil;
//
static UserService *userService = nil;
static UploadService *uploadService;
static CatalogueService *catalogueService = nil;
static ReviewService *reviewService = nil;
static StorageService *storageService = nil;
static RecommenderService *recommenderService = nil;
static QueueService *queueService = nil;
static ScoreBoardService *scoreBoardService= nil;
static EmailService *emailService= nil;
static BuddyService *buddyService= nil;
static LogService *logService= nil;

//In your class factory method for the class (named something like “sharedInstance” or “sharedManager”), it generates an instance of the class but only if the static instance is nil.
+(App42_API_Facade *)sharedInstance
{
	if (sharedInstance==nil) {
		sharedInstance = [[super allocWithZone:NULL] init];
        //
        serviceAPIobj = [[ServiceAPI alloc] init];
        serviceAPIobj.apiKey = @"bed6761e541cd0a135104c31b2f736a02b7294eef20daee891c1a5b864fb93fd";
        serviceAPIobj.secretKey = @"b3d47468ec8dd5a232c5b6dbd4efd5c2f4fc954575c809fc16f4e6252dd1cdd6";
        //Private service initialization.
        userService = [serviceAPIobj buildUserService];
        uploadService =[serviceAPIobj buildUploadService];
        catalogueService = [serviceAPIobj buildCatalogueService];
        reviewService =[serviceAPIobj buildReviewService];
        storageService =[serviceAPIobj buildStorageService];
        recommenderService = [serviceAPIobj buildRecommenderService];
        queueService=[serviceAPIobj buildQueueService];
        scoreBoardService=[serviceAPIobj buildScoreBoardService];
        emailService = [serviceAPIobj buildEmailService];
        buddyService =[serviceAPIobj buildBuddyService];
        logService =[serviceAPIobj buildLogService];
	}
    //
	return sharedInstance;
}
//It overrides the allocWithZone: method to ensure that another instance is not allocated if someone tries to allocate and initialize an instance of your class directly instead of using the class factory method. Instead, it just returns the shared object.
+(id)allocWithZone:(NSZone *)zone
{
	return [ [self sharedInstance] retain];
}
//It implements the base protocol methods copyWithZone:, release, retain, retainCount, and autorelease to do the appropriate things to ensure singleton status. (The last four of these methods apply to memory-managed code, not to garbage-collected code.)
-(id)copyWithZone:(NSZone *)zone
{
	return self;
}

-(id)retain
{
	return self;
}

-(NSUInteger)retainCount
{
	return NSUIntegerMax;//denotes an object that cannot be released.
}

//-(void)release
//{
//	//do nothing.
//}

//implementations
#pragma mark -UserService

#pragma mark -UploadService
-(void)uploadFile:(NSString *)fileName  fileData:(NSData *)imageData
         fileType:(NSString *)fileType
  fileDescription:(NSString *)description;
{
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
//    NSString *fileType = IMAGE;//IMAGE
    //
    @try{
        //
        Upload *upload = [uploadService uploadFileForUser:fileName userName:userName fileData:imageData uploadFileType:fileType fileDescription:description]; /* returns the Upload object. */
        //    NSMutableArray *fileList =  upload.fileListArray;
        //    for(File *file in fileList)
        //    {
        //        NSLog(@"File Name is  %@" , file.name);
        //        NSLog(@"File Type is  %@" ,  file.type);
        //        NSLog(@"File Url is  %@" , file.url);
        //        NSLog(@"File Description is %@" ,  file.description);
        //    }
        NSLog(@"uploaded file=%@",upload.fileListArray);
        //Save to ItemDataModel
        //        [[UploadModel sharedInstance] setUpload:upload];
        ItemData *itemData = [[ItemData alloc] init];
        
        itemData.name = [[App42_API_Utils sharedInstance] getTimeStampName]; //Make it unique,time-based sort-able.
        itemData.imageName = fileName;
        itemData.imageInputStream = imageData;
        //itemData.itemId = [[NSUUID UUID] UUIDString];//Make it unique,equal to the NoSQL docID
        itemData.description = description;
        [[ItemDataModel sharedInstance]setItemData:itemData];
        //Auto back navigation
        //        [self.navigationController popViewControllerAnimated:YES];
        //ProgressHUD dismiss
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //Save the fileName to Model.
        [[UploadModel sharedInstance] setUploadImageFile:fileName];
        //
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
}
#pragma mark -CatalogueService
-(void)insertCateItemId
{
    //Get default username
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //Get default catalogue and category name.
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //NoSQL storage with extra information.
    NSString *dbName = defaultCatalogueName;
    NSString *collectionName = defaultCategoryName;
    NSMutableDictionary *storageDict = [[NSMutableDictionary alloc] init];
    //Insert username key-value.
    [storageDict setObject:userName forKey:KEY_NAME_OWNERNAME];
    NSString *jsonStr = [storageDict JSONString];
    NSLog(@"JSON storageDict:%@",jsonStr);
    StorageService *storageService = [[App42_API_Utils sharedInstance] getStorageService];
    Storage *storage = [storageService insertJSONDocument:dbName collectionName:collectionName json:jsonStr]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocArray = storage.jsonDocArray;
    ItemData *itemData = [[ItemDataModel sharedInstance] getItemData];
    for(JSONDocument *jsonDoc in jsonDocArray)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        //Save the docId as a ItemID
        itemData.itemId = jsonDoc.docId;
        NSLog(@"JsonDoc is = %@" , jsonDoc.jsonDoc);
    }
    /* returns the response in JSON format. */
    NSString *jsonResponse_noSQL = [storage toString];
    NSLog(@"JSON response_noSQL:%@",jsonResponse_noSQL);
    //Update the item data model.
    [[ItemDataModel sharedInstance] setItemData:itemData];
}

#pragma mark -ReviewService
#pragma mark -StorageService
#pragma mark -RecommenderService
#pragma mark -QueueService
#pragma mark -RewardService
#pragma mark -EmailService
#pragma mark -ScoreBoardService
#pragma mark -LogService

@end