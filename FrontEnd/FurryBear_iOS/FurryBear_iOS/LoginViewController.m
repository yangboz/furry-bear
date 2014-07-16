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
@synthesize usernameTextField,passwordTextField,emailTextField;

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
    if(self.usernameTextField.text!=NULL
       &&self.passwordTextField.text!=NULL
        &&self.emailTextField.text!=NULL)
    {
    //User sign up here.
    [[App42_API_Facade sharedInstance] createUser:self.usernameTextField.text password:self.passwordTextField.text emailAddress:self.emailTextField.text]; /* returns the User object. */
    //
	[self.delegate loginViewControllerDidSave:self];
    //Auto back navigation
    [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dealloc {

    [passwordTextField release];
    [usernameTextField release];
    [emailTextField release];
    [super dealloc];
}
@end
