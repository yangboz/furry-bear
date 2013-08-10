//
//  LoginViewController.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-9.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize delegate;
@synthesize usernameTextField,passwordTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelAction:(id)sender
{
	[self.delegate loginViewControllerDidCancel:self];
}
- (IBAction)doneAction:(id)sender
{
    //Save user object to model.
    User *user = [[User alloc] init];
    user.userName = self.usernameTextField.text;
    user.password = self.passwordTextField.text;
    [UserModel setUser:user];
    //
	[self.delegate loginViewControllerDidSave:self];
}
- (void)dealloc {

    [passwordTextField release];
    [usernameTextField release];
    [super dealloc];
}
@end
