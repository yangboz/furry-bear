//
//  FeatureCell.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-27.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureCell : UITableViewCell
{}
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIImageView
*ratingImageView;
@property (nonatomic, strong) IBOutlet UIImageView
*itemImageView;
@end
