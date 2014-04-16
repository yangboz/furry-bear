//
//  VC_SegueCateItemReview.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-11-1.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_SegueCateItemReview.h"

@interface VC_SegueCateItemReview ()

@end

@implementation VC_SegueCateItemReview

@synthesize slider_rating,itemCommentsTxtView;

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
    NSLog(@"VC_SegueCateItemReview viewDidLoad!");
    //Update the UITextView with border.
    self.itemCommentsTxtView.layer.borderWidth = 1.0f;
    self.itemCommentsTxtView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.itemCommentsTxtView.layer.cornerRadius = 4.0f;
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

- (void)dealloc
{
    [slider_rating release];
    [itemCommentsTxtView release];
    //
    [super dealloc];
}

#pragma mark - IBActions
-(void)on_review_item:(id)sender
{
    NSLog(@"on_review_item sender!");
    //Get itemID
    //NSString *itemID = [[[ItemDataModel sharedInstance] getItemData] itemId];
    NSString *itemID = @"10";
    //Reviewing
    NSString *reviewComment = self.itemCommentsTxtView.text;
    double reviewRating = (double)self.slider_rating.value;
    //Befor reviewing
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //App42_API_Facade
    [[App42_API_Facade sharedInstance] createReview:itemID reviewComment:reviewComment reviewRating:reviewRating];
    //After reviewing
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //Auto back navigation
    [self.navigationController popViewControllerAnimated:YES];
}

@end
