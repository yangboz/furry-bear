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

@interface VC_FeatureCateItems : UIViewController <LoginViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *featuredCategoryItems;
}
-(void)userDefaultsLogin;
-(void)loadFeaturedCategoryItems;
@property(nonatomic,strong)IBOutlet UITableView *myTableView;
@property(nonatomic,strong)IBOutlet UITabBarItem *cateTabBarItem;
-(void)displayLoginPopup;
//App42_API calls
-(void)App42_findDocumentById:(NSString *)docId;
-(int)App42_getReviewsCountByItem:(NSString*)itemId;
-(void)App42_getReviewByItem:(NSString*)itemId;
-(void)App42_getAverageReviewByItem:(NSString *)itemId;
@end
