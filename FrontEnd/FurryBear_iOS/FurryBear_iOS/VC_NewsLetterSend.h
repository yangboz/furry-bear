//
//  VC_NewsLetterSend.h
//  FurryBear_iOS
//
//  Created by yangboz on 14-2-10.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_NewsLetterSend : UITableViewController
{}
@property(nonatomic,strong)IBOutlet UITextField *txt_sendTo;
@property(nonatomic,strong)IBOutlet UITextField *txt_sendSubject;
@property(nonatomic,strong)IBOutlet UITextField *txt_sendMsg;
@property(nonatomic,strong)IBOutlet UITextField *txt_sendFrom;
@property (retain, getter=isOn) IBOutlet UISegmentedControl *textMimeTypeSegmentedCtr;
@property(nonatomic,strong)IBOutlet UIButton *btn_send;
@end
