//
//  ThirdViewController.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-8-9.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "ThirdViewController.h"
#import "UserModel.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize photo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)uploadPhoto:(id)sender
{
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    NSString *fileName = [self.filenameTxt.text stringByAppendingString:@".png"];
//    NSString *filePath = @"Local file path";
    NSString *fileType = IMAGE;//IMAGE
    NSString *fileDescription = self.fileDescTxtView.text;
    UploadService *uploadService = [[App42_API_Utils sharedInstance] getUploadService];
//    UploadService *uploadService = [[App42_API_Utils getServiceAPI] buildUploadService];    //
    NSData *imageData = UIImagePNGRepresentation(self.photo);
    @try{
//        Upload *upload = [uploadService uploadFile:fileName filePath:@"first.png" uploadFileType:fileType fileDescription:fileDescription];
//        Upload *upload = [uploadService uploadFileForUser:fileName userName:userName filePath:@"second.png" uploadFileType:IMAGE fileDescription:fileDescription];
        Upload *upload = [uploadService uploadFileForUser:fileName userName:userName fileData:imageData uploadFileType:fileType fileDescription:fileDescription]; /* returns the Upload object. */
//    NSMutableArray *fileList =  upload.fileListArray;
//    for(File *file in fileList)
//    {
//        NSLog(@"File Name is  %@" , file.name);
//        NSLog(@"File Type is  %@" ,  file.type);
//        NSLog(@"File Url is  %@" , file.url);
//        NSLog(@"File Description is %@" ,  file.description);
//    }
        NSLog(@"uploaded file=%@",upload.fileListArray);
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
}

- (IBAction)choosePhoto:(id)sender
{
    UIActionSheet *choosePhotoActionSheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"choose_photo", @"")
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"take_photo_from_camera", @""), NSLocalizedString(@"take_photo_from_library", @""), nil];
    } else {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"choose_photo", @"")
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"take_photo_from_library", @""), nil];
    }
    
    [choosePhotoActionSheet showInView:self.view];
    [choosePhotoActionSheet release];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    } else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
	[self presentModalViewController:imagePickerController animated:YES];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissModalViewControllerAnimated:YES];
	self.photo = [info objectForKey:UIImagePickerControllerEditedImage];
	[self.photoButton setImage:self.photo forState:UIControlStateNormal];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    [_photoButton release];
    [_filenameTxt release];
    [_fileDescTxtView release];
    [_slider_rating release];
    [_slider_price release];
    [_txt_address release];
    [_txt_restaurant release];
    [_txt_telephone release];
    [_switch_agree release];
    [_btn_add_item release];
    [super dealloc];
}
- (IBAction)on_add_item:(id)sender {
    NSLog(@"on_add_item!");
    //
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //
    ItemData *itemData = [[ItemData alloc] init];
     itemData.itemId = @"8";
    itemData.price = self.slider_price.value;
//    itemData.rating = self.slider_rating.value;
    itemData.name = self.filenameTxt.text;
    itemData.description = self.fileDescTxtView.text;
    itemData.imageName = [self.filenameTxt.text stringByAppendingString:@".png"];
//    itemData.imageInputStream = UIImagePNGRepresentation(self.photo);
    itemData.image =  [[NSBundle mainBundle]pathForResource:@"Scallop00" ofType:@"jpg"];
    //
    CatalogueService *cataService = [[App42_API_Utils sharedInstance] getCatalogueService];
    Catalogue *catalogue = [cataService addItem:defaultCatalogueName categoryName:defaultCategoryName itemData:itemData];
//    NSString *catalogueName =  catalogue.name;
    NSMutableArray *categoryList = catalogue.categoryListArray;
    for(CategoryData *category in categoryList)
    {
        NSLog(@"name is = %@",category.name);
        NSLog(@"description is = %@",category.description);
        NSMutableArray *itemList = category.itemListArray;
        for (categoryItem *item in itemList)
        {
            NSLog(@"price is = %f",item.price);
            NSLog(@"itemId is = %@",item.itemId);
            NSLog(@"name is = %@",item.name);
        }
    }
    NSString *jsonResponse = [catalogue toString]; /* returns the response in JSON format. */
    NSLog(@"Add catalogue service response:%@",jsonResponse);
}
@end
