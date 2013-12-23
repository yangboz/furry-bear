//
//  FeatureCell.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-27.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "FeatureCell.h"

@implementation FeatureCell

@synthesize nameLabel,ratingCountLabel,reviewCountLabel,itemImageView,userIdLabel,timeStampLabel;
@synthesize navigationController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.imageView.layer.masksToBounds = YES;
        //self.imageView.layer.cornerRadius = 5.0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [self.nameLabel release];
    [self.itemImageView release];
    [self.ratingCountLabel release];
    [self.reviewCountLabel release];
    [self.userIdLabel release];
    [self.timeStampLabel release];
    [self.navigationController release];
    //
    [super dealloc];
}
#pragma mark IBActions
- (IBAction)reviewIconAction:(id)sender
{
    [self.navigationController performSegueWithIdentifier:@"segue_review" sender:self];
}

- (IBAction)userIconAction:(id)sender
{
    [self.navigationController performSegueWithIdentifier:@"segue_review" sender:self];
}

- (IBAction)itemDetailAction:(id)sender
{
    [self.navigationController performSegueWithIdentifier:@"segue_review" sender:self];
}

#pragma mark Public Properties/Functions


@end
