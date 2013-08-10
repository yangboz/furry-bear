//
//  LoginViewController.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-9.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>
- (void)loginViewControllerDidCancel:
(LoginViewController *)controller;
- (void)loginViewControllerDidSave:
(LoginViewController *)controller;
@end

@interface LoginViewController : UITableViewController

@property (nonatomic, retain) id <LoginViewControllerDelegate> delegate;

- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end
