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
static UploadService *uploadService = nil;
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
        //-Enabling trace will enable the logs inside the framework, that you can see in Xcode console.
        [serviceAPIobj enableApp42Trace:YES];
        //-Enabling crashEventHandler, enable your app to send crash reports to the AppHQDash board.
        [App42API enableCrashEventHandler:YES];
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
-(BOOL)userLogin:(NSString *)userName pwdValue:(NSString *)passWord;
{
    NSLog(@"User inputed username:%@,password:%@",userName,passWord);
    //    User *user = [userService authenticateUser:userName password:password];
    BOOL isSuccess = NO;
    @try{
        //        App42Response *response = [userService createUser:userName password:password emailAddress:@"YoungWelle@gmail.com"];
        App42Response *response = [userService authenticateUser:userName password:passWord];
        isSuccess = [response isResponseSuccess];
        NSString *jsonResponse = [response toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"App42 user authenticate result:%d,%@",isSuccess,jsonResponse);
        //Save the login info to userDefaults
        User *user = [[User alloc] init];
        user.userName = userName;
        user.password = passWord;
        [[UserModel sharedInstance] setUser:user];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //Alert messages.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App42Fault" message:@"Username/Password did not match.Authentication Failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //
    return isSuccess;
}
-(User *)createUser:(NSString *)userName password:(NSString *)password emailAddress:(NSString *)emailAddress;
{
    User *user = nil;
    @try{
        user = [userService createUser:userName password:password emailAddress:emailAddress]; /* returns the User object. */
        NSLog(@"userName is %@" , user.userName);
        NSLog(@"emailId is %@" ,  user.email);
        NSString *jsonResponse = [user toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"UserService->createUser results:%@",jsonResponse);
        //Save user object to model.
        User *userObj = [[User alloc] init];
        userObj.userName = userName;
        userObj.password = password;
        [[UserModel sharedInstance] setUser:userObj];
        //Auto relogin.
        
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    //
    return user;
}

#pragma mark -UploadService
-(void)uploadFile:(NSString *)fileName  fileData:(NSData *)imageData
         fileType:(NSString *)fileType
  fileDescription:(NSString *)description priceValue:(float)price;
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
        ItemData *itemData = [[ItemDataModel sharedInstance] getItemData];
        itemData.name = [[App42_API_Utils sharedInstance] getTimeStampName]; //Make it unique,time-based sort-able.
        itemData.imageName = fileName;
        itemData.imageInputStream = imageData;
        //itemData.itemId = [[NSUUID UUID] UUIDString];//Make it unique,equal to the NoSQL docID
        itemData.description = description;
        itemData.price = price;
        //Update itemDataModel
        [[ItemDataModel sharedInstance]setItemData:itemData];
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
-(void)createCateItemId
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
    Storage *storage = [storageService insertJSONDocument:dbName collectionName:collectionName json:jsonStr]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocArray = storage.jsonDocArray;
    ItemData *itemData = [[ItemData alloc] init];
    for(JSONDocument *jsonDoc in jsonDocArray)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        //Save the docId as a ItemID
        itemData.itemId = jsonDoc.docId;
        NSLog(@"JsonDoc is = %@" , jsonDoc.docId);
    }
    /* returns the response in JSON format. */
    NSString *jsonResponse_noSQL = [storage toString];
    NSLog(@"JSON response_noSQL:%@",jsonResponse_noSQL);
    //Update the item data model.
    [[ItemDataModel sharedInstance] setItemData:itemData];
}
-(NSString *)getCurrentCateItemId;
{
    ItemData *itemData = [[ItemDataModel sharedInstance] getItemData];
    //
    return itemData.itemId;
}
-(void)addCateItem:(NSString *)cateItemId
    addressValue:(NSString *)address
    resturantValue:(NSString *)resturant telephoneValue:(NSString *)telephone priceValue:(float)price agreeNextTimeValue:(BOOL)agreeNextTime
{
    //ItemData transporting.
    ItemData *itemData = [[ItemDataModel sharedInstance] getItemData];
    //Get default catalogue and category name.
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //NoSQL storage with extra information.
    NSString *dbName = defaultCatalogueName;
    NSString *collectionName = defaultCategoryName;
    NSMutableDictionary *storageDict = [[NSMutableDictionary alloc] init];
    //UserName
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    [storageDict setValue:userName forKey:KEY_NAME_OWNERNAME];
    [storageDict setValue:address forKey:KEY_NAME_ADDRESS];
    [storageDict setValue:telephone forKey:KEY_NAME_TELPHONE];
    [storageDict setValue:resturant forKey:KEY_NAME_RESTAURANT];
    [storageDict setValue:[NSNumber numberWithBool:agreeNextTime] forKey:KEY_NAME_AGREE_NEXT_TIME];
    NSString *jsonStr = [storageDict JSONString];
    NSLog(@"JSON storageDict:%@",jsonStr);
    Storage *storage = [storageService updateDocumentByDocId:dbName collectionName:collectionName docId:itemData.itemId newJsonDoc:jsonStr];
    //Storage *storage = [storageService insertJSONDocument:dbName collectionName:collectionName json:jsonStr]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocArray = storage.jsonDocArray;
    //
    for(JSONDocument *jsonDoc in jsonDocArray)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        //Save the docId as a ItemID
        itemData.itemId = jsonDoc.docId;
        NSLog(@"Updated JsonDoc is = %@" , jsonDoc.jsonDoc);
    }
    /* returns the response in JSON format. */
    NSString *jsonResponse_noSQL = [storage toString];
    NSLog(@"JSON response_noSQL:%@",jsonResponse_noSQL);
    //TODO:JSON Response string parse to save $oid
    //NSDictionary *jsonResponseDict_noSQL = [[jsonResponse_noSQL JSONData] objectFromJSONData];
    //NSLog(@"JSON responseDict_noSQL:%@",jsonResponseDict_noSQL);
    //hard-code the ItemID for testing.
    //itemData.itemId = @"11";
    Catalogue *catalogue = [catalogueService addItem:defaultCatalogueName categoryName:defaultCategoryName itemData:itemData];
    //    NSString *catalogueName =  catalogue.name;
    NSMutableArray *categoryList = catalogue.categoryListArray;
    for(CategoryData *category in categoryList)
    {
        NSLog(@"name is = %@",category.name);
        NSLog(@"description is = %@",category.description);
        NSMutableArray *itemList = category.itemListArray;
        for (categoryItem *item in itemList)
        {
            NSLog(@"price is = %f",item.price);
            NSLog(@"itemId is = %@",item.itemId);
            NSLog(@"name is = %@",item.name);
        }
    }
    NSString *jsonResponse = [catalogue toString]; /* returns the response in JSON format. */
    NSLog(@"Add catalogue service response:%@",jsonResponse);
    //Notify to notification center.
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NAME_CATE_ITEM_ADDED object:self];
}
//Catalogue
-(void)createCatalogue:(NSString *)catalogueName catalogueDescription:(NSString *)catalogueDescription
{
    @try{
        //
        Catalogue *catalogue = [catalogueService createCatalogue:catalogueName catalogueDescription:catalogueDescription]; /* returns the Catalogue object. */
        NSLog(@"catalogueName is = %@",catalogue.name);
        NSLog(@"catalogueDescription is = %@",catalogue.description);
        NSString *jsonResponse = [catalogue toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"CatalogueService_catalogue jsonResponse:%@",jsonResponse);        //
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
}
//Category
-(void)createCategory:(NSString *)catalogueName categoryName:(NSString *)categoryName categoryDescription:(NSString *)categoryDescription
{
    //
    @try{
        //
        Catalogue *catalogue = [catalogueService createCategory:catalogueName categoryName:categoryName categoryDescription:categoryDescription]; /* returns the Catalogue object. */
        NSLog(@"categoryName is = %@",catalogue.name);
        NSLog(@"categoryDescription is = %@",catalogue.description);
        NSString *jsonResponse = [catalogue toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"CatalogueService_category jsonResponse:%@",jsonResponse);
        //
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
}
-(NSMutableArray *)getItemsByCategory:(NSString *)defaultCatalogueName categoryName:(NSString *)defaultCategoryName;
{
    NSMutableArray *categoryList = [[NSMutableArray alloc] init];
    //
    @try{
        //
        Catalogue *catalogue = [catalogueService getItemsByCategory:defaultCatalogueName categoryName:defaultCategoryName];
        //
        categoryList = catalogue.categoryListArray;
        //
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    return categoryList;
}
#pragma mark -ReviewService
-(void)addReview:(NSString *)itemID reviewComment:(NSString *)reviewComment reviewRating:(double)reviewRating
{
    //Get default username
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    @try{
        //
        Review *review = [reviewService createReview:userName itemID:itemID reviewComment:reviewComment reviewRating:reviewRating]; /* returns the Review object. */
        NSLog(@"userId =%@", review.userId);
        NSLog(@"itemId =%@", review.itemId);
        NSLog(@"comment =%@", review.comment);
        NSLog(@"rating =%f", review.rating);
        NSString *jsonResponse = [review toString]; /* returns the response in JSON format. */
        NSLog(@"reviewService jsonResponse:%@",jsonResponse);
        //
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
}
-(int)getReviewsCountByItem:(NSString *)itemId;
{
    int totalRecords = 0;
    @try{
        //
        App42Response *response = [reviewService getReviewsCountByItem:itemId]; /* returns the App42Response objects. */
        BOOL success = response.isResponseSuccess;
        NSLog(@"App42_getReviewsCountByItem success?%d",success);
        totalRecords = response.totalRecords;
        NSLog(@"App42_getReviewsCountByItem totalRecords:%d",totalRecords);
        NSString *jsonResponse = [response toString];
        NSLog(@"App42_getReviewsCountByItem jsonResponse:%@",jsonResponse);
        /* returns the response in JSON format. (as shown below)
         {
         "app42": {
         "response": {
         "success": true,
         "totalRecords": 3
         }
         }
         }*/
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    return totalRecords;
}
-(NSMutableArray *)getReviewsByItem:(NSString *)itemId;
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    @try{
        //    NSString *itemId = @"itemID";
        NSArray *reviewList = [reviewService getReviewsByItem:itemId]; /* returns the list of Review object. */
        for(Review *review in reviewList){
            NSLog(@"userId =%@", review.userId);
            NSLog(@"itemId =%@", review.itemId);
            NSLog(@"comment=%@",review.comment);
            NSLog(@"rating=%f", review.rating);
            NSString *jsonResponse = [review toString]; /* returns the response in JSON format. */
            NSLog(@"App42_getReviewsByItem jsonResponse:%@",jsonResponse);
        }
        //
        results = [[[NSMutableArray alloc] initWithArray:reviewList] retain];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    return results;
}
-(Review *)getAverageReviewByItem:(NSString *)itemId;
{
    Review *review = nil;
    @try{
        // NSString *itemId = @"itemID";
        Review *review = [reviewService getAverageReviewByItem:itemId]; /* returns the Review object. */
        NSLog(@"userId =%@", review.userId);
        NSLog(@"itemId =%@", review.itemId);
        NSLog(@"comment=%@",review.comment);
        NSLog(@"rating=%f", review.rating);
        NSString *jsonResponse = [review toString]; /* returns the response in JSON format. */
        NSLog(@"App42_getAverageReviewByItem jsonResponse:%@",jsonResponse);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    return review;
}
-(NSMutableArray *)getCommentsByItem:(NSString *)itemId
{
    NSMutableArray *comments = [[NSMutableArray alloc] init];
    @try{
        // NSString *itemId = @"itemID";
        NSArray *commentList = [reviewService getCommentsByItem:itemId];
        for(Review *review in commentList)
        {
            NSLog(@"userId  is %@", review.userId);
            NSLog(@"itemId  is %@", review.itemId);
        }
        comments = [NSMutableArray arrayWithArray:commentList];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    return comments;
}
#pragma mark -StorageService
-(Storage *)findDocumentById:(NSString *)dbName collectionName:(NSString *)collectionName docId:(NSString *)docId;
{
    Storage *storage = nil;
    @try{
        //
        storage = [storageService findDocumentById:dbName collectionName:collectionName docId:docId];
        //
        NSString *jsonResponse = [storage toString]; /* returns the response in JSON format. */
        NSLog(@"App42_API_Facade->findDocumentById jsonResponse:%@",jsonResponse);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    return storage;
}
#pragma mark -RecommenderService
#pragma mark -QueueService
#pragma mark -RewardService
#pragma mark -EmailService
-(Email *)sendMail:(NSString *)sendTo subject:(NSString *)subject Message:(NSString *)message fromEmail:(NSString *)fromEmail emailMIME:(NSString *)emailMIME;
{
    Email *email = nil;
    @try{
        //App42 service API call here.
        email = [emailService sendMail:sendTo subject:subject Message:message fromEmail:fromEmail emailMIME:emailMIME];/* returns the Email object. */
        NSString *jsonResponse = [email toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"EmailService json response:%@",jsonResponse);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
    }
    return email;
}
#pragma mark -ScoreBoardService
#pragma mark -LogService
#pragma mark -BuddyService
#pragma mark - Friends related
-(NSMutableArray *)getFriendRequests
{
    NSMutableArray *friendRequests = [[NSMutableArray alloc] init];
    //
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    @try{
        //App42 service API call here.
        NSArray *buddys = [buddyService getFriendRequest:userName];
        NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
        NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
        NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
        NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
        //fill up the UITableView at first.
        friendRequests = [NSMutableArray arrayWithArray:buddys];
        //SetModel
        [[UserModel sharedInstance] setFriendRequests:friendRequests];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
        //None friend request
        
    }
    return friendRequests;
}
//
-(NSMutableArray *)getAllFriends
{
    NSMutableArray *allFriends = [[NSMutableArray alloc] init];
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    @try{
        //App42 service API call here.
        NSArray *buddys = [buddyService getAllFriends:userName];
        NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
        NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
        NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
        NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
        //fill up the UITableView at first.
        allFriends = [NSMutableArray arrayWithArray:buddys];
        [[UserModel sharedInstance] setAllFriends:allFriends];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
        //None friend request
    }
    return allFriends;
}
#pragma mark - Messages related
-(NSMutableArray *)getAllMessagesFromBuddy:(NSString *)buddyName
{
    NSMutableArray *messagesFromBuddy = [[NSMutableArray alloc] init];
    //
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    //1.Get friend request
    @try{
        //App42 service API call here.
        NSArray *buddys = [buddyService getAllMessagesFromBuddy:buddyName toUser:userName];
        NSLog(@"userName is : %@",[[buddys objectAtIndex:0] userName]);
        NSLog(@"buddyName is : %@"  , [[buddys objectAtIndex:0] buddyName]);
        NSLog(@"message is : %@",[[buddys objectAtIndex:0] message]);
        NSLog(@"sendedOn is : %@"  , [[buddys objectAtIndex:0] sendedOn]);
        //fill up the UITableView at first.
        messagesFromBuddy = [NSMutableArray arrayWithArray:buddys];
        //SetModel
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
        //None friend request
    }
    return messagesFromBuddy;
};
-(void)sendFriendRequestFromUser:(NSString *)userName toBuddy:(NSString *)buddyName withMessage:(NSString *)message;
{
    @try{
        //App42 service API call here.
        Buddy *buddy = [buddyService sendFriendRequestFromUser:userName toBuddy:buddyName withMessage:message];
        //
        NSLog(@"userName is : %@", buddy.userName);
        NSLog(@"buddyName is : %@", buddy.buddyName);
        NSLog(@"message is : %@", buddy.message);
        NSLog(@"sendedOn is : %@", buddy.sendedOn);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
        if(4613==ex.appErrorCode)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Your are already friends!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
    }
}
-(void)sendMessage:(NSString *)message toFriend:(NSString *)buddyName fromUser:(NSString *)userName;
{
    @try{
        //App42 service API call here.
        Buddy *buddy = [buddyService sendMessage:message toFriend:buddyName fromUser:userName];
        //
        NSLog(@"userName is : %@", buddy.userName);
        NSLog(@"buddyName is : %@", buddy.buddyName);
        NSLog(@"message is : %@", buddy.message);
        NSLog(@"sendedOn is : %@", buddy.sendedOn);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //NSAlert here.
    }
}
@end