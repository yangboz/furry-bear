//
//  VC_FeedCateItems.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-5.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_FeedCateItems.h"

@interface VC_FeedCateItems ()

@end

@implementation VC_FeedCateItems

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //if auto signin
    if ([[UserModel sharedInstance] getAutoSignin]) {
        [self userDefaultsLogin];
    }else
    {
        [self displayLoginPopup];
    }
    // table view data is being set here
    //featuredCategoryItems = [[NSMutableArray alloc] init];
    //Notify listening
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFeaturedCategoryItems) name:NOTIFY_NAME_CATE_ITEM_ADDED object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [featuredCategoryItems release];
    [super dealloc];
}

#pragma mark - UserLoginAlertView
-(void)userDefaultsLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *passWord = [defaults objectForKey:@"passWord"];
    if((userName!=nil && passWord!=nil))
    {
        [self tryLogin:userName pwdValue:passWord];
    }else//Display login popup view
    {
        [self displayLoginPopup];
    }
}

-(void)displayLoginPopup
{
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Enter Credentials" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    prompt.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [[prompt textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeEmailAddress];
    [prompt show];
    [prompt release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *username = [alertView textFieldAtIndex:0];
    UITextField *password = [alertView textFieldAtIndex:1];
    //    NSLog(@"Username: %@\nPassword: %@", username.text, password.text);
    [self tryLogin:username.text pwdValue:password.text];
}

-(void)tryLogin:(NSString *)userName pwdValue:(NSString *)passWord
{
    NSLog(@"User inputed username:%@,password:%@",userName,passWord);
    UserService *userService = [ [App42_API_Utils sharedInstance] getUserService ];
    //    User *user = [userService authenticateUser:userName password:password];
    @try{
        //        App42Response *response = [userService createUser:userName password:password emailAddress:@"YoungWelle@gmail.com"];
        App42Response *response = [userService authenticateUser:userName password:passWord];
        BOOL success = [response isResponseSuccess];
        NSString *jsonResponse = [response toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"App42 user authenticate result:%d,%@",success,jsonResponse);
        //Dismiss loginView modal.
        [self dismissViewControllerAnimated:YES completion:nil];
        //Save the login info to userDefaults
        User *user = [[User alloc] init];
        user.userName = userName;
        user.password = passWord;
        [[UserModel sharedInstance] setUser:user];
        //Get default catalogue and category name.
        [self loadFeaturedCategoryItems];
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
        //Display the login popup window again.
        //[self displayLoginPopup];
    }
}
#pragma mark -UITableView reload
-(void)loadFeaturedCategoryItems
{
    //ProgressBar show
    //[[PopupManager_DTAlertView sharedInstance] popupProgressBar];
    //
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //GET ITEMS BY CATEGORY
    CatalogueService *cataService = [[App42_API_Utils sharedInstance] getCatalogueService];
    Catalogue *catalogue = [cataService getItemsByCategory:defaultCatalogueName categoryName:defaultCategoryName];
    NSMutableArray *categoryList = catalogue.categoryListArray;
    for(CategoryData *category in categoryList)
    {
        NSLog(@"name is = %@",category.name);
        NSLog(@"description is = %@",category.description);
        NSMutableArray *itemList = category.itemListArray;
        //
        NSLog(@"category itemList len:%d",[itemList count]);
        //        featuredCategoryItems = [[[NSMutableArray alloc] initWithArray:itemList] retain];
        featuredCategoryItems = [[NSMutableArray alloc] init];
        for (categoryItem *item in itemList)
        {
            NSLog(@"price is = %f",item.price);
            NSLog(@"itemId is = %@",item.itemId);
            NSLog(@"name is = %@",item.name);
            NSLog(@"tinyUrl is = %@",item.tinyUrl);
            //Load itemId related NoSQL documents.
            //featuredCategoryItem dictionary:
            NSMutableDictionary *fCateItemDict = [[NSMutableDictionary alloc] init];
            //#1.FIND DOCUMENT BY ID
            JSONDocument *jsonDoc = [self App42_findDocumentById:item.itemId];
            //#2.GET USER NAME
            NSString *username = [self App42_getItemOwnerName:jsonDoc];
            //#3.GET ITEM TIMESTAMP
            NSString *timestamp = [self App42_getItemTimeStamp:jsonDoc];
            //With try catch...
            //#4.GET REVIEWS COUNT BY ITEM
            int reviewCount = [self App42_getReviewsCountByItem:item.itemId];
            NSLog(@"App42_getReviewsCountByItem result:%d",reviewCount);
            //#5.GET REVIEWs BY ITEM
            //[self App42_getReviewsByItem:item.itemId];
            //#6.GET AVERAGE REVIEW BY ITEM
            int rating = [self App42_getAverageReviewByItem:item.itemId];
            
            //
            [fCateItemDict setObject:item forKey:DICT_KEY_CATE_ITEM];
            [fCateItemDict setObject:[NSNumber numberWithInt:reviewCount] forKey:DICT_KEY_REVIEW_COUNT];
            [fCateItemDict setObject:[NSNumber numberWithInt:rating] forKey:DICT_KEY_RATING];
            [fCateItemDict setObject:username forKey:DICT_KEY_USER_NAME];
            [fCateItemDict setObject:timestamp forKey:DICT_KEY_TIME_STAMP];
            //
            [featuredCategoryItems addObject:fCateItemDict];
            for (NSMutableDictionary *fCateItemDict in featuredCategoryItems) {
                for (id key in fCateItemDict) {
                    NSLog(@"key: %@, value: %@ \n", key, [fCateItemDict objectForKey:key]);
                }
            }
        }
        //Table view reload
        [self.tableView reloadData];
        //
        //self.cateTabBarItem.badgeValue = @"1";
        //ProgressBar hide
        //[[PopupManager_DTAlertView sharedInstance] dismissProgressBar];
    }
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewControllerDidCancel:
(LoginViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginViewControllerDidSave:
(LoginViewController *)controller
{
    //Initialize the App42 serviceAPI instance
    user = [[UserModel sharedInstance] getUser];
    NSString *userName = user.userName;
    NSString *passWord = user.password;
    NSLog(@"User inputed username:%@,password:%@",userName,passWord);
    userService = [ [App42_API_Utils sharedInstance] getUserService ];
    //    User *user = [userService authenticateUser:userName password:password];
    @try{
        //        App42Response *response = [userService createUser:userName password:password emailAddress:@"YoungWelle@gmail.com"];
        App42Response *response = [userService authenticateUser:userName password:passWord];
        BOOL success = [response isResponseSuccess];
        NSString *jsonResponse = [response toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"App42 user authenticate result:%d,%@",success,jsonResponse);
        //Dismiss loginView modal.
        [self dismissViewControllerAnimated:YES completion:nil];
        
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
}
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SEGUE_NAME_LOGIN]) {
        UINavigationController *navigationController = segue.destinationViewController;
        //
        LoginViewController *loginViewController = [[navigationController viewControllers] objectAtIndex:0];
        loginViewController.delegate = self;
    }
    //VC_CategoryItemDetail
    if ([segue.identifier isEqualToString:SEGUE_NAME_ITEM_DETAIL]) {
        VC_CateItemDetail *categoryItemDetailVC = segue.destinationViewController;
        categoryItemDetailVC.cateItemData = [self getCategoryItemData:selectedNSIndexPath];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"featuredCategoryItems,count:%d",[featuredCategoryItems count]);
	return [featuredCategoryItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FeatureCell *cell = (FeatureCell *)[tableView
                                        dequeueReusableCellWithIdentifier:@"FeatureCell"];
    NSLog(@"featuredCategoryItems count:%d",[featuredCategoryItems count]);
    //	categoryItem *catItem = (categoryItem *)[featuredCategoryItems objectAtIndex:indexPath.row];
    NSDictionary *fCateItemDict = (NSDictionary *)[featuredCategoryItems objectAtIndex:indexPath.row];
    //Customize cell.
    //cell.contentView.layer.cornerRadius = 4.0f;
    //[cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.contentView.layer setBorderWidth:1.0f];
    //
    categoryItem *catItem = (categoryItem *)[fCateItemDict objectForKey:@"cateItem"];
	cell.nameLabel.text = catItem.description;
	//cell.detailTextLabel.text = itemData.imageName;
    NSURL* aURL = [NSURL URLWithString:catItem.tinyUrl];
    //NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    //cell.itemImageView.image = [UIImage imageWithData:data];
    cell.itemImageView.imageURL = aURL;
    NSString *reviewCount = [NSString stringWithFormat:@"%ld",(long)[[fCateItemDict objectForKey:DICT_KEY_REVIEW_COUNT] integerValue]];
    cell.reviewCountLabel.text = reviewCount;
    //    NSString *ratingCount = [NSString stringWithFormat:@"%d",[[fCateItemDict objectForKey:@"rating"] integerValue]];
    cell.ratingCountLabel.text = [self symbolForRating:[[fCateItemDict objectForKey:DICT_KEY_RATING] integerValue]];
    cell.userIdLabel.text = [fCateItemDict objectForKey:DICT_KEY_USER_NAME];
    cell.timeStampLabel.text = [fCateItemDict objectForKey:DICT_KEY_TIME_STAMP];
    //Contray to MVC,temporary transfor the navigationController reference to cell
    cell.navigationController = self.navigationController;
    //IBAction for cell buttons
    [cell.reviewIconBtn addTarget:self action:@selector(reviewIconAction:) forControlEvents:UIControlEventTouchUpInside];
    //Set buddy name
    [[UserModel sharedInstance] setBuddyName: cell.userIdLabel.text];
    //see friend request
    [cell.userIconBtn addTarget:self action:@selector(userIconAction:) forControlEvents:UIControlEventTouchUpInside];
    //see detail by tap image.
    cell.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemDetailAction:)] autorelease];
    [cell.imageView addGestureRecognizer:tapGesture];
    //Favorite item icon click handler
    [cell.favIconBtn addTarget:self action:@selector(itemFavoriteAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%ld Row:%ld selected and its data is %@",
          (long)indexPath.section,(long)indexPath.row,cell.textLabel.text);
    //Go to detail view with data.
    selectedNSIndexPath = indexPath;
    [self performSegueWithIdentifier:SEGUE_NAME_ITEM_DETAIL sender:self];
}

#pragma mark App42 APIs
-(JSONDocument *)App42_findDocumentById:(NSString *)docId
{
    dbName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    collectionName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //    NSString *docId = @"4faa3f1ac68df147a51f8bd7";
    storageService = [[App42_API_Utils sharedInstance] getStorageService];
    //
    
    //
    Storage *storage = [storageService findDocumentById:dbName collectionName:collectionName docId:docId]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocList = storage.jsonDocArray;
    for(JSONDocument *jsonDoc in jsonDocList)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        NSLog(@"JsonDoc is = %@" , jsonDoc.jsonDoc);
    }
    
    NSString *jsonResponse = [storage toString]; /* returns the response in JSON format. */
    NSLog(@"App42_findDocumentById jsonResponse:%@",jsonResponse);
    return [jsonDocList objectAtIndex:0];
}

-(int)App42_getReviewsCountByItem:(NSString*)itemId
{
    int totalRecords = 0;
    @try{
        //NSString *itemId = @"ItemID";
        ReviewService *reviewService = [[App42_API_Utils sharedInstance] getReviewService];
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
//@see:http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/review_api.html#get_reviewbyitem
-(NSMutableArray *)App42_getReviewsByItem:(NSString*)itemId
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    @try{
        //    NSString *itemId = @"itemID";
        ReviewService *reviewService = [[App42_API_Utils sharedInstance] getReviewService];
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
//@see:http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/review_api.html#getaverage_reviewbyitem
-(int)App42_getAverageReviewByItem:(NSString *)itemId
{
    int avgRating = 0;
    @try{
        // NSString *itemId = @"itemID";
        ReviewService *reviewService = [[App42_API_Utils sharedInstance]getReviewService];
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
    return avgRating;
}
//@private
-(NSString *)App42_getItemOwnerName:(JSONDocument *)jsonDoc
{
    NSString *username = @"nil";
    NSDictionary *dict = [[jsonDoc jsonDoc] objectFromJSONString];
    //
    username = [dict objectForKey:KEY_NAME_OWNERNAME];
    return username;
}
-(NSString *)App42_getItemTimeStamp:(JSONDocument *)jsonDoc
{
    NSString *timestamp = @"";
    NSDictionary *dict = [[jsonDoc jsonDoc] objectFromJSONString];
    //
    timestamp = [dict objectForKey:@"_$updatedAt"];
    NSLog(@"json._$updatedAt:%@", timestamp);
    return timestamp;
}
#pragma mark Utility functions
- (NSString *)symbolForRating:(int)rating
{
    switch (rating) {
        case 0: return @"☆";
        case 1: return @"★";
        case 2: return @"★★";
        case 3: return @"★★★";
        case 4: return @"★★★★";
        case 5: return @"★★★★★";
    }
    return nil;
}

- (categoryItem *)getCategoryItemData:(NSIndexPath *)indexPath
{
    NSDictionary *fCateItemDict = (NSDictionary *)[featuredCategoryItems objectAtIndex:indexPath.row];
    categoryItem *catItem = (categoryItem *)[fCateItemDict objectForKey:@"cateItem"];
    return catItem;
}
#pragma mark IBActions inside of cell.
- (void)reviewIconAction:(id)sender
{
    //    self.tabBarController.selectedIndex = 2;
    //    [self.navigationController performSegueWithIdentifier:SEGUE_NAME_REVIEW sender:self];
    [[PopupManager_AlertTable sharedInstance]popupCateItemDetail];
}

- (void)userIconAction:(id)sender
{
    //    self.tabBarController.selectedIndex = 2;
    //    [self.navigationController performSegueWithIdentifier:@"segue_review" sender:self];
    //    VC_SegueCateItemReview *itemReview = [[VC_SegueCateItemReview alloc] init];
    //    [self.navigationController pushViewController:itemReview animated:YES];
    //    [self presentViewController:itemReview animated:YES completion:NULL];
    //    [itemReview release];
    //Send user friends request with PopupManager.
    [[PopupManager_DTAlertView sharedInstance] popupFriendRequest];
}

- (void)itemFavoriteAction:(id)sender
{
    //@see http://api.shephertz.com/app42-docs/user-management-service/#add_json_object
    UserService *userService = [[App42_API_Utils sharedInstance] getUserService];
    //Favorite item json object assemble
    NSMutableDictionary *storageDict = [[NSMutableDictionary alloc] init];
    //Get cate item's id
    categoryItem *cateItem = [self getCategoryItemData:selectedNSIndexPath];
    NSLog(@"categoryItem id:%@",cateItem.itemId);
    //Insert username key-value.
    [storageDict setObject:cateItem.itemId forKey:KEY_NAME_FAV_ITEM];
    NSString *jsonStr = [storageDict JSONString];
    NSLog(@"JSON storageDict:%@",jsonStr);
    //TODO:Add JSON object.
    
}

@end
