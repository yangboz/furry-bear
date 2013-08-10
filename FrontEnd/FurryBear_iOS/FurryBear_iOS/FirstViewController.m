//
//  FirstViewController.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoginViewControllerDelegate

- (void)loginViewControllerDidCancel:
(LoginViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginViewControllerDidSave:
(LoginViewController *)controller
{
    //Initialize the App42 serviceAPI instance
    User *user = [UserModel getUser];
    NSString *userName = user.userName;
    NSString *password = user.password;
    NSLog(@"User inputed username:%@,password:%@",userName,password);
    ServiceAPI *serviceAPIObj = [[ServiceAPI alloc] init];
    serviceAPIObj.apiKey = @"bed6761e541cd0a135104c31b2f736a02b7294eef20daee891c1a5b864fb93fd";
    serviceAPIObj.secretKey = @"b3d47468ec8dd5a232c5b6dbd4efd5c2f4fc954575c809fc16f4e6252dd1cdd6";
    UserService *userService = [serviceAPIObj buildUserService];
//    User *user = [userService authenticateUser:userName password:password];
    @try{
//        App42Response *response = [userService createUser:userName password:password emailAddress:@"YoungWelle@gmail.com"];
        App42Response *response = [userService authenticateUser:userName password:password];
        BOOL success = [response isResponseSuccess];
        NSString *jsonResponse = [response toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"App42 user authenticate result:%d,%@",success,jsonResponse);
        //Dismiss loginView modal.
        [self dismissViewControllerAnimated:YES completion:nil];
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
        //Alert messages.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App42Fault" message:@"Username/Password did not match.Authentication Failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UserLogin"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        LoginViewController *loginViewController = [[navigationController viewControllers] objectAtIndex:0];
        loginViewController.delegate = self;
    }
}

@end
