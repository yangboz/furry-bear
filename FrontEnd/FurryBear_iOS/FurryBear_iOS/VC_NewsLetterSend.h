//
//  VC_NewsLetterSend.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-2-10.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App42_API_Utils.h"

@interface VC_NewsLetterSend : UITableViewController <UITableViewDelegate,UITableViewDataSource>
{}
@property(nonatomic,strong)IBOutlet UITextField *txt_sendTo;
@property(nonatomic,strong)IBOutlet UITextField *txt_sendSubject;
@property(nonatomic,strong)IBOutlet UITextField *txt_sendMsg;
@property(nonatomic,strong)IBOutlet UITextField *txt_sendFrom;
@property (retain, getter=isOn) IBOutlet UISegmentedControl *textMimeTypeSegmentedCtr;
//
- (IBAction)on_send_newsletter:(id)sender;
@end
