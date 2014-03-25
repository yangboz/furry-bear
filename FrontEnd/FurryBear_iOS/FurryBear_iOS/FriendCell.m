//
//  FriendCell.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-3-25.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

@synthesize buddyNameLabel,acceptedOnLabel,blockIconBtn,unblockIconBtn;

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

- (void)dealloc
{
    [super dealloc];
    //
    [self.acceptedOnLabel release];
    [self.buddyNameLabel release];
    [self.blockIconBtn release];
    [self.unblockIconBtn release];
}

@end
