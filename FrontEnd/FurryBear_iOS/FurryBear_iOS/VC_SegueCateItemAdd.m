//
//  VC_SegueItemReview.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-23.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_SegueCateItemAdd.h"

@interface VC_SegueCateItemAdd ()

@end

@implementation VC_SegueCateItemAdd

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
    NSLog(@"VC_SegueCateItemAdd viewDidLoad!");
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
#pragma mark -IBActions
- (IBAction)on_add_item:(id)sender {
    NSLog(@"CategoryService->on_add_item!");
    //Display ProgressBar
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //App42_API_Facade.
    [[App42_API_Facade sharedInstance] insertCateItem:self.addressTxt.text resturantValue:self.resturantTxt.text telephoneValue:self.telphoneTxt.text agreeNextTimeValue:self.agreeNextTimeSwitch.isOn];
    //Hide ProgressBar
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)dealloc {
    [self.addressTxt release];
    [self.resturantTxt release];
    [self.telphoneTxt release];
    [self.agreeNextTimeSwitch release];
    [super dealloc];
}

@end
