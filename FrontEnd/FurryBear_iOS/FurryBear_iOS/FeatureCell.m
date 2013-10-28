//
//  FeatureCell.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-27.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "FeatureCell.h"

@implementation FeatureCell

@synthesize nameLabel,ratingImageView,itemImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
    [self.ratingImageView release];
    //
    [super dealloc];
}

@end
