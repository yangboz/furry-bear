//
//  VC_FeatureCateItems.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_FeatureCateItems.h"

@interface VC_FeatureCateItems ()

@end

@implementation VC_FeatureCateItems

@synthesize myTableView,cateTabBarItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //
    [self userDefaultsLogin];
    // table view data is being set here
    //featuredCategoryItems = [[NSMutableArray alloc] init];
    //Notify listening
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFeaturedCategoryItems) name:@"categoryItemsAdded" object:nil];
    //TableView customize style
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [featuredCategoryItems release];
    [myTableView release];
    [cateTabBarItem release];
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
    //ProgressHUD show
    [SVProgressHUD show];
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
    //ProgressHUD dismiss
    [SVProgressHUD dismiss];
}

-(void)loadFeaturedCategoryItems
{
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
        featuredCategoryItems = [[[NSMutableArray alloc] initWithArray:itemList] retain];
        for (categoryItem *item in itemList)
        {
            NSLog(@"price is = %f",item.price);
            NSLog(@"itemId is = %@",item.itemId);
            NSLog(@"name is = %@",item.name);
            NSLog(@"tinyUrl is = %@",item.tinyUrl);
            //Load itemId related NoSQL documents.
            //#1.FIND DOCUMENT BY ID
            [self App42_findDocumentById:item.itemId];
            //#2.GET REVIEWS COUNT BY ITEM
            [self App42_getReviewsCountByItem:item.itemId];
            //#3.GET REVIEW BY ITEM
            //[self App42_getReviewByItem:item.itemId];
            //#4.GET AVERAGE REVIEW BY ITEM
            [self App42_getAverageReviewByItem:item.itemId];
        }
        //Table view reload
        [self.myTableView reloadData];
        //
        //self.cateTabBarItem.badgeValue = @"1";
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
    User *user = [[UserModel sharedInstance] getUser];
    NSString *userName = user.userName;
    NSString *passWord = user.password;
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UserLogin"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        LoginViewController *loginViewController = [[navigationController viewControllers] objectAtIndex:0];
        loginViewController.delegate = self;
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
	categoryItem *catItem = (categoryItem *)[featuredCategoryItems objectAtIndex:indexPath.row];
    //Customize cell.
    //cell.contentView.layer.cornerRadius = 4.0f;
    //[cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.contentView.layer setBorderWidth:1.0f];
    //
	cell.nameLabel.text = catItem.name;
	//cell.detailTextLabel.text = itemData.imageName;
    NSURL* aURL = [NSURL URLWithString:catItem.tinyUrl];
    //NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    //cell.itemImageView.image = [UIImage imageWithData:data];
    cell.itemImageView.imageURL = aURL;
    return cell;
}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
}

#pragma mark App42 APIs
-(void)App42_findDocumentById:(NSString *)docId
{
    NSString *dbName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *collectionName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
//    NSString *docId = @"4faa3f1ac68df147a51f8bd7";
    StorageService *storageService = [[App42_API_Utils sharedInstance] getStorageService];
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
}

-(void)App42_getReviewsCountByItem:(NSString*)itemId
{
    //NSString *itemId = @"ItemID";
    ReviewService *reviewService = [[App42_API_Utils sharedInstance] getReviewService];
    App42Response *response = [reviewService getReviewsCountByItem:itemId]; /* returns the App42Response objects. */
    BOOL success = response.isResponseSuccess;
    NSLog(@"App42_getReviewsCountByItem success?%d",success);
    int totalRecords = response.totalRecords;
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
}
//@see:http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/review_api.html#get_reviewbyitem
-(void)App42_getReviewByItem:(NSString*)itemId
{
//    NSString *itemId = @"itemID";
    ReviewService *reviewService = [[App42_API_Utils sharedInstance] getReviewService];
    NSArray *reviewList = [reviewService getReviewsByItem:itemId]; /* returns the list of Review object. */
    for(Review *review in reviewList){
        NSLog(@"userId =%@", review.userId);
        NSLog(@"itemId =%@", review.itemId);
        NSLog(@"comment=%@",review.comment);
              NSLog(@"rating=%f", review.rating);
                    NSString *jsonResponse = [review toString]; /* returns the response in JSON format. */
        NSLog(@"App42_getReviewByItem jsonResponse:%@",jsonResponse);
                    }
}
//@see:http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/review_api.html#getaverage_reviewbyitem
-(void)App42_getAverageReviewByItem:(NSString *)itemId
{
   // NSString *itemId = @"itemID";
    ReviewService *reviewService = [[App42_API_Utils sharedInstance]getReviewService];
    Review *review = [reviewService getAverageReviewByItem:itemId]; /* returns the Review object. */
    NSLog(@"userId =%@", review.userId);
    NSLog(@"itemId =%@", review.itemId);
    NSLog(@"comment=%@",review.comment);
    NSLog(@"rating=%f", review.rating);
    NSString *jsonResponse = [review toString]; /* returns the response in JSON format. */
    NSLog(@"App42_getAverageReviewByItem jsonResponse:%@",jsonResponse);
}
@end
