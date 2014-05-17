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
//Variables
double ratingDouble = 0;
NSString *fileDescription = nil;
NSData *imageData = nil;
//
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
    // Setup control using iOS7 tint Color
    self.colors = @[ [UIColor colorWithRed:0.11f green:0.38f blue:0.94f alpha:1.0f], [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f], [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f], [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f]];
    _starRating.backgroundColor  = [UIColor clearColor];
    _starRating.starImage = [UIImage imageNamed:@"star-template.png"];
    _starRating.starHighlightedImage = [UIImage imageNamed:@"star-highlighted-template.png"];
    _starRating.maxRating = 10.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2;
    _starRating.displayMode=EDStarRatingDisplayAccurate;
    [_starRating  setNeedsDisplay];
    [self starsSelectionChanged:_starRating rating:2];
    _starRating.tintColor = self.colors[1];
    // This will use a return block to handle the rating changes
    // Setting the return block automatically nils the delegate
    _starRating.returnBlock = ^(float rating)
    {
        NSLog(@"Star Rating changed to %.1f" ,rating);
    };
    //Default disable submit button first off.
    [self.submitButton setEnabled:NO];
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
    [_starRating release];
    //
    [super dealloc];
}
#pragma mark - IBActions
- (IBAction)uploadPhoto:(id)sender
{
    //ProgressHUD show
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //
    imageData = UIImagePNGRepresentation(self.photo);
    //NSData *imageData = UIImageJPEGRepresentation(self.photo,0.8);
    //If you need to run your long-running task in the main thread, you should perform it with a slight delay, so UIKit will have enough time to update the UI (i.e., draw the HUD) before you block the main thread with your task.
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        /*
        //NSOperationQueue
        operationQueue = [NSOperationQueue new];
        //[operationQueue setMaxConcurrentOperationCount:1];
        //Create a new NSOpeartion object using NSInvocationOperation subclass
        //Tell it to run the task_createCateItemId method.
        NSInvocationOperation *operation_createCateItemId = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task_createCateItemId) object:nil];
        //Add the operation to the queue and let it to be executed.
        [operationQueue addOperation:operation_createCateItemId];
        [operation_createCateItemId release];
        //The same story as above,just tell here to execute task_uploadCateItemPhoto;
        NSInvocationOperation *operation_uploadCateItemPhoto = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task_uploadCateItemPhoto) object:nil];
        [operationQueue addOperation:operation_uploadCateItemPhoto];
        [operation_uploadCateItemPhoto addDependency:operation_createCateItemId];
        [operation_uploadCateItemPhoto release];
        //
        //The same story as above,just tell here to execute task_addCateItem;
        NSInvocationOperation *operation_addCateItem = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task_addCateItem) object:nil];
        [operationQueue addOperation:operation_addCateItem];
        [operation_addCateItem addDependency:operation_uploadCateItemPhoto];
        [operation_addCateItem release];
        //
        //The same story as above,just tell here to execute task_reviewCateItem;
        NSInvocationOperation *operation_reviewCateItem = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task_reviewCateItem) object:nil];
        [operationQueue addOperation:operation_reviewCateItem];
        [operation_reviewCateItem addDependency:operation_addCateItem];
        [operation_reviewCateItem release];
         */
        //Delegate to App42_API_Facade
        
        //onInsertCateItemId
        [self task_createCateItemId];
        //onUploadCateItemPhoto
        [self task_uploadCateItemPhoto];
        //onAddCateItem
        [self task_addCateItem];
        //onCateItemReview,default review.
        [self task_reviewCateItem];
        //Hide HUD view
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //GotoAndPlay('Segue_FeedCateItem')
        self.tabBarController.selectedIndex = 1;
        //
    });
    
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
//	[self.photoButton setImage:self.photo forState:UIControlStateNormal];
    [self.photoButton setBackgroundImage:self.photo forState:UIControlStateNormal];
    //Using AssetsLibrary framework to get the
    NSString *fileName = [[[App42_API_Utils sharedInstance] getTimeStampName] stringByAppendingString:@".png"];
    self.filenameTxt.text = fileName;
    NSLog(@"Picked image file name:%@",fileName);
    //Enable submit button now.
    [self.submitButton setEnabled:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - EDStarRating protocol
-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    ratingDouble = (double)rating;
    NSLog(@"EDStarRating value:%f",ratingDouble);
}

#pragma mark - Tasks
-(void)task_uploadCateItemPhoto;
{
    [[App42_API_Facade sharedInstance] uploadFile:self.filenameTxt.text fileData:imageData fileType:IMAGE fileDescription:self.fileDescTxtView.text priceValue:self.slider_price.value];
}
-(void)task_createCateItemId;
{
    //onInsertCateItemId
    [[App42_API_Facade sharedInstance] createCateItemId];
}
-(void)task_addCateItem;
{
    //
    NSString *cateItemId = [[App42_API_Facade sharedInstance] getCurrentCateItemId];
    [[App42_API_Facade sharedInstance] addCateItem:cateItemId
        addressValue:self.addressTxt.text
        resturantValue:self.resturantTxt.text
        telephoneValue:self.telphoneTxt.text priceValue:self.slider_price.value agreeNextTimeValue:self.agreeNextTimeSwitch.isOn];
}
-(void)task_reviewCateItem;
{
    NSString *cateItemId = [[App42_API_Facade sharedInstance] getCurrentCateItemId];
    [[App42_API_Facade sharedInstance] addReview:cateItemId reviewComment:self.fileDescTxtView.text reviewRating:ratingDouble];
}

@end
