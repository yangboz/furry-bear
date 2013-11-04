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
#import "SVProgressHUD.h"

@interface VC_FeatureCateItems : UIViewController <LoginViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *featuredCategoryItems;
}
-(void)userDefaultsLogin;
@property(nonatomic,strong)IBOutlet UITableView *myTableView;
@end
