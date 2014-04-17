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

@interface VC_FeatureCateItems : UIViewController <LoginViewControllerDelegate>
{
}
-(void)userDefaultsLogin;
-(void)displayLoginPopup;
//App42_API calls
//IBOutlets

@end
