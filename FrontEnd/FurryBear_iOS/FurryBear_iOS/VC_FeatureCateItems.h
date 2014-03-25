//
//  VC_FeatureCateItems.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
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

@interface VC_FeatureCateItems : UIViewController <LoginViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *featuredCategoryItems;
}
-(void)userDefaultsLogin;
-(void)loadFeaturedCategoryItems;
- (NSString *)symbolForRating:(int)rating;
@property(nonatomic,strong)IBOutlet UITableView *myTableView;
@property(nonatomic,strong)IBOutlet UITabBarItem *cateTabBarItem;
-(void)displayLoginPopup;
//App42_API calls
-(JSONDocument *)App42_findDocumentById:(NSString *)docId;
-(int)App42_getReviewsCountByItem:(NSString*)itemId;
-(NSMutableArray *)App42_getReviewsByItem:(NSString*)itemId;
-(int)App42_getAverageReviewByItem:(NSString *)itemId;//Rating value only.
//IBActions inside of cell
-(void)reviewIconAction:(id)sender;
-(void)userIconAction:(id)sender;
-(void)itemDetailAction:(id)sender;
@end
