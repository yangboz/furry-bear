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
    //User sign up here.
    UserService *userService = [[App42_API_Utils sharedInstance] getUserService];
    User *user = [userService createUser:self.usernameTextField.text password:self.passwordTextField.text emailAddress:self.emailTextField.text]; /* returns the User object. */
    NSLog(@"userName is %@" , user.userName);
    NSLog(@"emailId is %@" ,  user.email);
    NSString *jsonResponse = [user toString]; /* returns the response in JSON format. (as shown below)*/
    NSLog(@"UserService->createUser results:%@",jsonResponse);
    //Save user object to model.
    User *userObj = [[User alloc] init];
    userObj.userName = self.usernameTextField.text;
    userObj.password = self.passwordTextField.text;
    [[UserModel sharedInstance] setUser:userObj];
    //
	[self.delegate loginViewControllerDidSave:self];
    //Auto back navigation
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {

    [passwordTextField release];
    [usernameTextField release];
    [emailTextField release];
    [super dealloc];
}
@end
