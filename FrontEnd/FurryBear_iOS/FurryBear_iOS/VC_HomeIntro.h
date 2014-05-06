//
//  VC_HomeIntro.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "App42_API_Facade.h"
#import "EAIntroView.h"

@interface VC_HomeIntro : UIViewController <LoginViewControllerDelegate,EAIntroDelegate>
{
}
-(void)userDefaultsLogin;
-(void)displayLoginPopup;
//EAIntroView
- (void)showIntroWithFixedTitleView;
//App42_API calls
//IBOutlets

@end
