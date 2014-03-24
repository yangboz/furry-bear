//
//  BuddyCell.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-24.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "BuddyCell.h"

@implementation BuddyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [super dealloc];
    //
    [self.userNameLabel dealloc];
    [self.buddyNameLabel dealloc];
    [self.messageLabel dealloc];
    [self.acceptIconBtn dealloc];
    [self.rejectIconBtn dealloc];
}

#pragma mark IBActions


#pragma mark Public Properties/Functions

@end
