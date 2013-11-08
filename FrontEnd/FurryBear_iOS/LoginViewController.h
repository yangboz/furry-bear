//
//  LoginViewController.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-9.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
#import "UserModel.h"
#import "App42_API_Utils.h"

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>
- (void)loginViewControllerDidCancel:
(LoginViewController *)controller;
- (void)loginViewControllerDidSave:
(LoginViewController *)controller;
@end

@interface LoginViewController : UITableViewController

@property (nonatomic, retain) id <LoginViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITextField *usernameTextField;

@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@property (retain, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end
