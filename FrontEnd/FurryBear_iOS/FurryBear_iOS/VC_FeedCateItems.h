//
//  VC_FeedCateItems.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-5.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "App42_API_Utils.h"
#import "FeatureCell.h"
#import "AsyncImageView.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "Prefs.h"
#import "VC_SegueCateItemReview.h"
#import "PopupManager_DTAlertView.h"
#import "UserModel.h"
#import "VC_CategoryItemMain.h"
#import "PopupManager_AlertTable.h"
#import "VC_SegueFeatureCateItemDetail.h"
#import "AppDelegate.h"
#import "VC_CateItemDetail.h"

@interface VC_FeedCateItems : UITableViewController <UITableViewDataSource,UITableViewDelegate>
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
@end
