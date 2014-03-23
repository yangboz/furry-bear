//
//  VC_CategoryItemContent.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-23.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_CategoryItemContent.h"

@interface VC_CategoryItemContent ()

@end

@implementation VC_CategoryItemContent

@synthesize titleLabel,userImageView,desTextView;
@synthesize titleText,userImageFile,descText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Site initialization with site properties
    self.titleLabel.text = self.titleText;
    self.desTextView.text = self.descText;
    self.userImageView.image = [UIImage imageNamed:self.userImageFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    //IBOutlets
    [titleLabel release];
    [userImageView release];
    [desTextView release];
    //Site properties
    [titleText release];
    [userImageFile release];
    [descText release];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
