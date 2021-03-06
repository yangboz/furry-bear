//
//  VC_FeedCateItems.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-5.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "App42_API_Facade.h"
#import "FeatureCell.h"
#import "AsyncImageView.h"
#import "VC_SegueCateItemReview.h"
#import "PopupManager_DTAlertView.h"
#import "PopupManager_AlertTable.h"
#import "AppDelegate.h"
#import "VC_CateItemDetail.h"
//
#import "YIPopupTextView.h"

@interface VC_FeedCateItems : UITableViewController <UITableViewDataSource,UITableViewDelegate,YIPopupTextViewDelegate>
{
    NSMutableArray *featuredCategoryItems;
    NSIndexPath *selectedNSIndexPath;
    //App42 related variables
    NSString *dbName;
    NSString *collectionName;
    StorageService *storageService;
    UserService *userService;
    User *user;
}
//IBActions
- (IBAction)loadFeaturedCategoryItems:(id)sender;
- (IBAction)addCategoryItems:(id)sender;
//
@end
