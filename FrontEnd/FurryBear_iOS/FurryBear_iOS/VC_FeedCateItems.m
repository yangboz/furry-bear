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

- (void)loadView
{
    [super loadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    // Any UI-related configuration goes here. It may be called multiple times,
    // but each time it is called, `self.view` will be freshly loaded from the nib
    // file.
    //Get default catalogue and category name.
    //    [self loadFeaturedCategoryItems:nil];
    // table view data is being set here
    //featuredCategoryItems = [[NSMutableArray alloc] init];
    //Notify listening
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFeaturedCategoryItems:) name:NOTIFY_NAME_CATE_ITEM_ADDED object:nil];
    if (featuredCategoryItems==nil) {
        [self loadFeaturedCategoryItems:nil];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Set all IBOutlets to `nil` here.
    // Drop any lazy-load data that you didn't drop in viewWillDisappear:
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Most data loading should go here to make sure the view matches the model
    // every time it's put on the screen. This is also a good place to observe
    // notifications and KVO, and to setup timers.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Unregister from notifications and KVO here (balancing viewWillAppear:).
    // Stop timers.
    // This is a good place to tidy things up, free memory, save things to
    // the model, etc.
}

- (void)dealloc {
    // standard release stuff if non-ARC
    //[[NSNotificationCenter defaultCenter] removeObvserver:self]; // If you observed anything
    // Stop timers.
    // Don't unregister KVO here. Observe and remove KVO in viewWill(Dis)appear.
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
    [[App42_API_Facade sharedInstance] userLogin:userName pwdValue:passWord];
    //
    //Get default catalogue and category name.
    [self loadFeaturedCategoryItems:nil];
}
#pragma mark -UITableView reload
- (IBAction)loadFeaturedCategoryItems:(id)sender
{
    //ProgressBar show
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //If you need to run your long-running task in the main thread, you should perform it with a slight delay, so UIKit will have enough time to update the UI (i.e., draw the HUD) before you block the main thread with your task.
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //GET ITEMS BY CATEGORY
//    NSMutableArray *categoryList = [[App42_API_Facade sharedInstance] getItemsByCategory:defaultCatalogueName categoryName:defaultCategoryName];
    NSMutableArray *categoryList = [[UserModel sharedInstance] getCategoryList];
    //
    for(CategoryData *category in categoryList)
    {
        NSLog(@"name is = %@",category.name);
        NSLog(@"description is = %@",category.description);
        NSMutableArray *itemList = category.itemListArray;
        //
        NSLog(@"category itemList len:%lu",(unsigned long)[itemList count]);
        //        featuredCategoryItems = [[[NSMutableArray alloc] initWithArray:itemList] retain];
        featuredCategoryItems = [[NSMutableArray alloc] init];
        for (categoryItem *item in itemList)
        {
            NSLog(@"price is = %f",item.price);
            NSLog(@"itemId is = %@",item.itemId);
            NSLog(@"name is = %@",item.name);
            NSLog(@"tinyUrl is = %@",item.tinyUrl);
            NSLog(@"url is = %@",item.url);
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
//            int commentsCount = [self App42_getCommentsCountByItem:item.itemId];
            NSMutableArray *comments =
            [[App42_API_Facade sharedInstance]getReviewsByItem:item.itemId];
            int commentsCount = (int)[comments count];
            NSLog(@"App42_getCommentsCountByItem result:%d",commentsCount);
            //#5.GET REVIEWs BY ITEM
            //[self App42_getReviewsByItem:item.itemId];
            //#6.GET AVERAGE REVIEW BY ITEM
            int rating = [self App42_getAverageReviewByItem:item.itemId];
            
            //
            [fCateItemDict setObject:item forKey:DICT_KEY_CATE_ITEM];
            [fCateItemDict setObject:[NSNumber numberWithInt:reviewCount] forKey:DICT_KEY_REVIEW_COUNT];
            [fCateItemDict setObject:[NSNumber numberWithInt:commentsCount] forKey:DICT_KEY_COMMENT_COUNT];
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
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    });
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
    BOOL isLoggedIn = [[App42_API_Facade sharedInstance] userLogin:userName pwdValue:passWord];
    if (isLoggedIn) {
        //Dismiss loginView modal.
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        //Alert messages.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录出错" message:@"用户名/密码不匹配.验证失败." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    categoryItem *catItem = (categoryItem *)[fCateItemDict objectForKey:DICT_KEY_CATE_ITEM];
	cell.nameLabel.text = catItem.description;
	//cell.detailTextLabel.text = itemData.imageName;
    NSURL* aURL = [NSURL URLWithString:catItem.url];
    //NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    //cell.itemImageView.image = [UIImage imageWithData:data];
    cell.itemImageView.imageURL = aURL;
//    NSString *reviewCount = [NSString stringWithFormat:@"%ld",(long)[[fCateItemDict objectForKey:DICT_KEY_REVIEW_COUNT] integerValue]];
    NSString *reviewCount = [NSString stringWithFormat:@"%ld",(long)[[fCateItemDict objectForKey:DICT_KEY_COMMENT_COUNT] integerValue]];
    cell.reviewCountLabel.text = reviewCount;
    //    NSString *ratingCount = [NSString stringWithFormat:@"%d",[[fCateItemDict objectForKey:@"rating"] integerValue]];
    cell.ratingCountLabel.text = [self symbolForRating:(int)[[fCateItemDict objectForKey:DICT_KEY_RATING] integerValue]];
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
    //
    Storage *storage = [[App42_API_Facade sharedInstance] findDocumentById:dbName collectionName:collectionName docId:docId]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocList = storage.jsonDocArray;
    for(JSONDocument *jsonDoc in jsonDocList)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        NSLog(@"JsonDoc is = %@" , jsonDoc.jsonDoc);
    }
    //
    return [jsonDocList objectAtIndex:0];
}

-(int)App42_getReviewsCountByItem:(NSString*)itemId
{
    return [[App42_API_Facade sharedInstance]getReviewsCountByItem:itemId];
}

-(int)App42_getCommentsCountByItem:(NSString*)itemId
{
    return [[[App42_API_Facade sharedInstance] getCommentsByItem:itemId] count];
}
//@see:http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/review_api.html#get_reviewbyitem
-(NSMutableArray *)App42_getReviewsByItem:(NSString*)itemId
{
    return [[App42_API_Facade sharedInstance]getReviewsByItem:itemId];
}
//@see:http://api.shephertz.com/cloudapidocs/guide/0.8.1.1/ios/review_api.html#getaverage_reviewbyitem
-(int)App42_getAverageReviewByItem:(NSString *)itemId
{
    return [[App42_API_Facade sharedInstance] getAverageReviewByItem:itemId].rating;
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
    //FIXME:JSON string parse changed here!!!
    timestamp = [dict objectForKey:KEY_NAME_RESTAURANT];
    NSLog(@"json._$updatedAt:%@", timestamp);
    return timestamp;
}
#pragma mark Utility functions
- (NSString *)symbolForRating:(int)rating
{
    NSString *ratingResult = @"☆";
    switch (rating) {
        case 0:
            ratingResult = @"☆";
            break;
        case 1:
            ratingResult = @"★";
            break;
        case 2:
            ratingResult = @"★☆";
            break;
        case 3:
            ratingResult = @"★★";
            break;
        case 4:
            ratingResult = @"★★☆";
            break;
        case 5:
            ratingResult = @"★★★";
            break;
        case 6:
            ratingResult = @"★★★☆";
            break;
        case 7:
            ratingResult = @"★★★★";
            break;
        case 8:
            ratingResult = @"★★★★☆";
            break;
        case 9:
            ratingResult = @"★★★★★";
            break;
        default:
            break;
    }
    return ratingResult;
}

- (categoryItem *)getCategoryItemData:(NSIndexPath *)indexPath
{
    NSDictionary *fCateItemDict = (NSDictionary *)[featuredCategoryItems objectAtIndex:indexPath.row];
    categoryItem *catItem = (categoryItem *)[fCateItemDict objectForKey:@"cateItem"];
    return catItem;
}

-(NSString *)getSelectedCateItemId
{
    //Get cate item's id
    categoryItem *cateItem = [self getCategoryItemData:selectedNSIndexPath];
    NSLog(@"Current selected categoryItem id:%@",cateItem.itemId);
    return cateItem.itemId;
}
#pragma mark IBActions inside of cell.
- (void)reviewIconAction:(id)sender
{
    //Send feed item review with PopupManager.
    //@see https://github.com/inamiy/YIPopupTextView
    YIPopupTextView* popupReview = [[YIPopupTextView alloc] initWithPlaceHolder:@"Review here" maxCount:140 buttonStyle:YIPopupTextViewButtonStyleRightCancelAndDone];
    popupReview.delegate = self;
    popupReview.caretShiftGestureEnabled = YES;   // default = NO
   // popupReview.text = self.textView.text;
    //popupReview = NO;                  // set editable=NO to show without keyboard
    
    //[popupReview showInView:self.view];
    [popupReview showInViewController:self]; // recommended, especially for iOS7
}

- (void)userIconAction:(id)sender
{
    //Send user friends request with PopupManager.
    [[PopupManager_DTAlertView sharedInstance] popupFriendRequest];
}

- (void)itemFavoriteAction:(id)sender
{
    //@see http://api.shephertz.com/app42-docs/user-management-service/#add_json_object
    //
    @try{
        //Favorite item json object assemble
        NSMutableDictionary *storageDict = [[NSMutableDictionary alloc] init];
        //Get cate item's id
        NSString *cateItemId = [self getSelectedCateItemId];
        //Insert username key-value.
        [storageDict setObject:cateItemId forKey:KEY_NAME_FAV_ITEM];
        NSString *jsonStr = [storageDict JSONString];
        NSLog(@"JSON storageDict:%@",jsonStr);
//        NSString *_collectionName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
//        [_userService addUserInfo:storageDict collectionName:_collectionName];
        //
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }

}

-(void)addCategoryItems:(id)sender
{
    self.tabBarController.selectedIndex = 2;
}

#pragma -mark YIPopupTextView Delegate
- (void)popupTextView:(YIPopupTextView*)textView willDismissWithText:(NSString*)text cancelled:(BOOL)cancelled;
{
    //Empty handle
}
- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled;
{
    if (!cancelled) {
        NSString *cateItemId = [self getSelectedCateItemId];
        [[App42_API_Facade sharedInstance] addReview:cateItemId reviewComment:text reviewRating:4.0];
    }
}
@end
