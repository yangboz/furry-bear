//
//  UploadModel.h
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-14.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>

@interface UploadModel : NSObject
{}
+(UploadModel *)sharedInstance;
-(Upload *)getUpload;
-(void)setUpload:(Upload *)value;

-(NSMutableArray *)getData;
-(void)setData:(NSMutableArray *)value;

-(NSString *)getFileName;
-(void)setFileName:(NSString *)value;
-(NSString *)getFileType;
-(void)setFileType:(NSString *)value;
-(NSString *)getFileDescription;
-(void)setFileDescription:(NSString *)value;

-(NSData *)getImageData;
-(void)setImageData:(NSData *)value;

@end
