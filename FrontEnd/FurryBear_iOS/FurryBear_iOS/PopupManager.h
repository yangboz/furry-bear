//
//  PopupManager.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-20.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAlertView.h"
@interface PopupManager : UIView
{}
+(PopupManager *)sharedInstance;

//ProgressView
-(void)showProgressBar;
-(void)hideProgressBar;
@end
