//
//  VC_FeatureCateItems.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "App42_API_Facade.h"
#import "Prefs.h"
#import "VC_CategoryItemMain.h"
#import "PopupManager_AlertTable.h"
#import "AppDelegate.h"
#import "HYCircleLoadingView.h"


@interface VC_FeatureCateItems : UIViewController <LoginViewControllerDelegate>
{
    NSMutableArray *featuredCategoryItems;
}
-(void)userDefaultsLogin;
-(void)displayLoginPopup;
//App42_API calls
//IBOutlets
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@end
