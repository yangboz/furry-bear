//
//  FirstViewController.h
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

@interface FirstViewController : UIViewController <LoginViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *featuredCategoryItems;
    IBOutlet UITableView *myTableView;
}
-(void)userDefaultsLogin;
@end
