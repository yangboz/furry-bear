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
    //
    [self userDefaultsLogin];
    // table view data is being set here
    testingData = [[NSMutableArray alloc] init];
    ItemData *itemData = [[ItemData alloc] init];
    itemData.itemId = @"0";
    itemData.name = @"Default";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"first.png";
    itemData.price = 2;
    [testingData addObject:itemData];
    itemData = [[ItemData alloc] init];
    itemData.itemId = @"1";
    itemData.name = @"Scallop";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"Scallop000.jpg";
    itemData.price = 4;
    [testingData addObject:itemData];
    itemData = [[ItemData alloc] init];
    itemData.itemId = @"2";
    itemData.name = @"Hanburge";
    itemData.image = @"http://www.google.com";
    itemData.imageName = @"Hanburge000.jpg";
    itemData.price = 5;
    [testingData addObject:itemData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [myTableView release];
    [super dealloc];
}

#pragma mark - UserLoginAlertView
-(void)userDefaultsLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *passWord = [defaults objectForKey:@"passWord"];
    if((userName!=nil && passWord!=nil))
    {
        [self tryLogin:userName pwdValue:passWord];
    }else//Display login popup view
    {
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Enter Credentials" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        prompt.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [[prompt textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeEmailAddress];
        [prompt show];
        [prompt release];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *username = [alertView textFieldAtIndex:0];
    UITextField *password = [alertView textFieldAtIndex:1];
//    NSLog(@"Username: %@\nPassword: %@", username.text, password.text);
    [self tryLogin:username.text pwdValue:password.text];
}

-(void)tryLogin:(NSString *)userName pwdValue:(NSString *)passWord
{
    NSLog(@"User inputed username:%@,password:%@",userName,passWord);
    UserService *userService = [ [App42_API_Utils sharedInstance] getUserService ];
    //    User *user = [userService authenticateUser:userName password:password];
    @try{
        //        App42Response *response = [userService createUser:userName password:password emailAddress:@"YoungWelle@gmail.com"];
        App42Response *response = [userService authenticateUser:userName password:passWord];
        BOOL success = [response isResponseSuccess];
        NSString *jsonResponse = [response toString]; /* returns the response in JSON format. (as shown below)*/
        NSLog(@"App42 user authenticate result:%d,%@",success,jsonResponse);
        //Dismiss loginView modal.
        [self dismissViewControllerAnimated:YES completion:nil];
        //Save the login info to userDefaults
        User *user = [[User alloc] init];
        user.userName = userName;
        user.password = passWord;
        [[UserModel sharedInstance] setUser:user];
        //Get default catalogue and category name.
        NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
        NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
        //GET ITEMS BY CATEGORY
        CatalogueService *cataService = [[App42_API_Utils sharedInstance] getCatalogueService];
        Catalogue *catalogue = [cataService getItemsByCategory:defaultCatalogueName categoryName:defaultCategoryName];
        NSMutableArray *categoryList = catalogue.categoryListArray;
        for(CategoryData *category in categoryList)
        {
            NSLog(@"name is = %@",category.name);
            NSLog(@"description is = %@",category.description);
            NSMutableArray *itemList = category.itemListArray;
            for (categoryItem *item in itemList)
            {
                NSLog(@"price is = %f",item.price);
                NSLog(@"itemId is = %@",item.itemId);
                NSLog(@"name is = %@",item.name);  
            }    
        }
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
    User *user = [[UserModel sharedInstance] getUser];
    NSString *userName = user.userName;
    NSString *passWord = user.password;
    NSLog(@"User inputed username:%@,password:%@",userName,passWord);
    UserService *userService = [ [App42_API_Utils sharedInstance] getUserService ];
//    User *user = [userService authenticateUser:userName password:password];
    @try{
//        App42Response *response = [userService createUser:userName password:password emailAddress:@"YoungWelle@gmail.com"];
        App42Response *response = [userService authenticateUser:userName password:passWord];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [testingData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"FeatureCell"];
	ItemData *itemData = [testingData objectAtIndex:indexPath.row];
	cell.textLabel.text = itemData.name;
	cell.detailTextLabel.text = itemData.imageName;
    return cell;
}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Section:%d Row:%d selected and its data is %@",
          indexPath.section,indexPath.row,cell.textLabel.text);
}

@end
