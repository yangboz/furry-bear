//
//  LoginViewController.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-9.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Facade.h"

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
