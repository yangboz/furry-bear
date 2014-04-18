//
//  VC_ImageUpload_CateItemAdd.m
//  FurryBear_iOS
//
//  Created by yangboz on 14-4-15.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

#import "VC_ImageUpload_CateItemAdd.h"

@interface VC_ImageUpload_CateItemAdd ()

@end

@implementation VC_ImageUpload_CateItemAdd

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"VC_ImageUpload_CateItemAdd viewDidLoad!");
    //Update the UITextView with border.
    self.fileDescTxtView.layer.borderWidth = 1.0f;
    self.fileDescTxtView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.fileDescTxtView.layer.cornerRadius = 4.0f;
    //Update the UIButton with border.
    self.photoButton.layer.borderWidth = 1.0f;
    self.photoButton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.photoButton.layer.cornerRadius = 4.0f;
    //Slider initialize text
    [self updateSliderPopoverText];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateSliderPopoverText
{
    self.slider_price.popover.textLabel.text = [NSString stringWithFormat:@"%.0f", self.slider_price.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_photoButton release];
    [_filenameTxt release];
    [_fileDescTxtView release];
    [_slider_price release];
    //
    [_addressTxt release];
    [_resturantTxt release];
    [_telphoneTxt release];
    [_agreeNextTimeSwitch release];
    //
    [super dealloc];
}
#pragma mark - IBActions
- (IBAction)uploadPhoto:(id)sender
{
    //ProgressHUD show
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //
    NSString *fileType = IMAGE;//IMAGE
    NSString *fileDescription = self.fileDescTxtView.text;
    //NSData *imageData = UIImagePNGRepresentation(self.photo);
    NSData *imageData = UIImageJPEGRepresentation(self.photo,0.8);
    //Delegate to App42_API_Facade
    [[App42_API_Facade sharedInstance] uploadFile:self.filenameTxt.text fileData:imageData fileType:fileType fileDescription:fileDescription];
    //onAddCateItem
    [[App42_API_Facade sharedInstance] insertCateItemId];
    //
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)onAddCateItem:(id)sender
{
    
}

-(void)sliderValueChanged:(id)sender
{
    [self updateSliderPopoverText];
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
    //Using AssetsLibrary framework to get the
    NSString *fileName = [[[App42_API_Utils sharedInstance] getTimeStampName] stringByAppendingString:@".png/jpg"];
    self.filenameTxt.text = fileName;
    NSLog(@"Picked image file name:%@",fileName);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
