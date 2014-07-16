//
//  VC_HomeIntro.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-8.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_HomeIntro.h"

@implementation VC_HomeIntro
//
@synthesize addButton;
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Update the UIButton with border.
    self.addButton.layer.borderWidth = 1.0f;
    self.addButton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.addButton.layer.cornerRadius = 4.0f;
	// Do any additional setup after loading the view, typically from a nib.
    if (![[UserModel sharedInstance] getIntroViewed]) {
        [self showIntroWithFixedTitleView];
    }
    //if auto signin
    if ([[UserModel sharedInstance] getAutoSignin]) {
        [self userDefaultsLogin];
    }else
    {
        [self displayLoginPopup];
    }
    //
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
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
        [self displayLoginPopup];
    }
}

-(void)displayLoginPopup
{
    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Enter Credentials" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    prompt.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [[prompt textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeEmailAddress];
    [prompt show];
    [prompt release];
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //
    BOOL loginSuccess = [[App42_API_Facade sharedInstance] userLogin:userName pwdValue:passWord];
    //Dismiss loginView modal.
    if (loginSuccess) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    //
    [self tryLogin:userName pwdValue:passWord];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UserLogin"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        //
        LoginViewController *loginViewController = [[navigationController viewControllers] objectAtIndex:0];
        loginViewController.delegate = self;
    }
}

#pragma mark - EAIntroDelegate
- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"EAIntroView DidFinish callback!");
    //Save user perference.
    [[UserModel sharedInstance] setIntroViewed:YES];
}

- (void)showIntroWithFixedTitleView
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = INTRO_DESCRIPTION_00;
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = INTRO_DESCRIPTION_01;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = INTRO_DESCRIPTION_02;
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"This is page 4";
    page4.desc = INTRO_DESCRIPTION_03;
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fork-128"]];
    intro.titleView = titleView;
    intro.titleViewY = 60;
    intro.backgroundColor = [UIColor colorWithRed:1.0f green:0.49f blue:0.96f alpha:1.0f]; //iOS7 dark blue
    
    [intro showInView:self.view animateDuration:0.3];
    //FIXME:SkipButton disappear..
    [intro showSkipButtonOnlyOnLastPage];
}

#pragma mark -IBActions
- (IBAction)addOneDish:(id)sender
{
    self.tabBarController.selectedIndex = 2;
}

@end
