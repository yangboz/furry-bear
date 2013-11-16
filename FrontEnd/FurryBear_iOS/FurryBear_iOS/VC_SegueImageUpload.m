//
//  VC_SegueImageUpload.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-23.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_SegueImageUpload.h"

@interface VC_SegueImageUpload ()

@end

@implementation VC_SegueImageUpload

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
    NSLog(@"VC_SegueImageUpload viewDidLoad!");
    //Update the UITextView with border.
    self.fileDescTxtView.layer.borderWidth = 1.0f;
    self.fileDescTxtView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.fileDescTxtView.layer.cornerRadius = 4.0f;
    //Update the UIButton with border.
    self.photoButton.layer.borderWidth = 1.0f;
    self.photoButton.layer.borderColor = [[UIColor grayColor] CGColor];
    self.photoButton.layer.cornerRadius = 4.0f;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
#pragma mark - IBActions
- (IBAction)uploadPhoto:(id)sender
{
    //ProgressHUD show
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    NSString *fileName = [self.filenameTxt.text stringByAppendingString:@".png"];
    //    NSString *filePath = @"Local file path";
    NSString *fileType = IMAGE;//IMAGE
    NSString *fileDescription = self.fileDescTxtView.text;
    UploadService *uploadService = [[App42_API_Utils sharedInstance] getUploadService];
    //    UploadService *uploadService = [[App42_API_Utils getServiceAPI] buildUploadService];    //
    NSData *imageData = UIImagePNGRepresentation(self.photo);
    @try{
        //
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
        //Save to ItemDataModel
//        [[UploadModel sharedInstance] setUpload:upload];
        ItemData *itemData = [[ItemData alloc] init];

        itemData.name = [[App42_API_Utils sharedInstance] getTimeStampName]; //Make it unique,time-based sort-able.
        itemData.imageName = fileName;
        itemData.imageInputStream = imageData;
        //itemData.itemId = [[NSUUID UUID] UUIDString];//Make it unique,equal to the NoSQL docID
        itemData.description = fileDescription;
        [[ItemDataModel sharedInstance]setItemData:itemData];
        //Auto back navigation
        [self.navigationController popViewControllerAnimated:YES];
        //ProgressHUD dismiss
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }@catch (App42BadParameterException *ex) {
        NSLog(@"BadParameterException found,status code:%d",ex.appErrorCode);
    }@catch (App42SecurityException *ex) {
        NSLog(@"SecurityException found!");
    }@catch (App42Exception *ex) {
        NSLog(@"App42 Exception found:%@",ex.description);
    }
    //Get default catalogue and category name.
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //NoSQL storage with extra information.
    NSString *dbName = defaultCatalogueName;
    NSString *collectionName = defaultCategoryName;
    NSMutableDictionary *storageDict = [[NSMutableDictionary alloc] init];
    NSString *jsonStr = [storageDict JSONString];
    NSLog(@"JSON storageDict:%@",jsonStr);
    StorageService *storageService = [[App42_API_Utils sharedInstance] getStorageService];
    Storage *storage = [storageService insertJSONDocument:dbName collectionName:collectionName json:jsonStr]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocArray = storage.jsonDocArray;
    ItemData *itemData = [[ItemDataModel sharedInstance] getItemData];
    for(JSONDocument *jsonDoc in jsonDocArray)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        //Save the docId as a ItemID
        itemData.itemId = jsonDoc.docId;
        NSLog(@"JsonDoc is = %@" , jsonDoc.jsonDoc);
    }
    /* returns the response in JSON format. */
    NSString *jsonResponse_noSQL = [storage toString];
    NSLog(@"JSON response_noSQL:%@",jsonResponse_noSQL);
    //Update the item data model.
    [[ItemDataModel sharedInstance] setItemData:itemData];
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
    [self.slider_price release];
    [super dealloc];
}
@end
