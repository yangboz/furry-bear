//
//  VC_SegueItemReview.m
//  FurryBear_iOS
//
//  Created by yangboz on 13-10-23.
//  Copyright (c) 2013年 GODPAPER. All rights reserved.
//

#import "VC_SegueCateItemAdd.h"

@interface VC_SegueCateItemAdd ()

@end

@implementation VC_SegueCateItemAdd

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
    NSLog(@"VC_SegueCateItemAdd viewDidLoad!");
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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
- (IBAction)on_add_item:(id)sender {
    NSLog(@"on_add_item!");
    //Display MBProgressHUD
    //@see:https://github.com/matej/MBProgressHUD
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //ItemData transporting.
    ItemData *itemData = [[ItemDataModel sharedInstance] getItemData];
    //Get default catalogue and category name.
    NSString *defaultCatalogueName = [[App42_API_Utils sharedInstance] getDefaultCatalogueName];
    NSString *defaultCategoryName = [[App42_API_Utils sharedInstance] getDefaultCategoryName];
    //NoSQL storage with extra information.
    NSString *dbName = defaultCatalogueName;
    NSString *collectionName = defaultCategoryName;
    NSMutableDictionary *storageDict = [[NSMutableDictionary alloc] init];
    //UserName
    NSString *userName = [[[UserModel sharedInstance] getUser] userName];
    [storageDict setValue:userName forKey:KEY_NAME_OWNERNAME];
    [storageDict setValue:self.addressTxt.text forKey:KEY_NAME_ADDRESS];
    [storageDict setValue:self.telphoneTxt.text forKey:KEY_NAME_TELPHONE];
    [storageDict setValue:self.resturantTxt.text forKey:KEY_NAME_RESTAURANT];
    [storageDict setValue:[NSNumber numberWithBool:self.agreeNextTimeSwitch.isOn] forKey:KEY_NAME_AGREE_NEXT_TIME];
    NSString *jsonStr = [storageDict JSONString];
    NSLog(@"JSON storageDict:%@",jsonStr);
    StorageService *storageService = [[App42_API_Utils sharedInstance] getStorageService];
    Storage *storage = [storageService updateDocumentByDocId:dbName collectionName:collectionName docId:itemData.itemId newJsonDoc:jsonStr];
    //Storage *storage = [storageService insertJSONDocument:dbName collectionName:collectionName json:jsonStr]; /* returns the Storage object. */
    NSLog(@"dbName is = %@",storage.dbName);
    NSLog(@"collectionName is = %@",storage.collectionName);
    NSMutableArray *jsonDocArray = storage.jsonDocArray;
    //
    for(JSONDocument *jsonDoc in jsonDocArray)
    {
        NSLog(@"docId is = %@ " , jsonDoc.docId);
        //Save the docId as a ItemID
        itemData.itemId = jsonDoc.docId;
        NSLog(@"Updated JsonDoc is = %@" , jsonDoc.jsonDoc);
    }
    /* returns the response in JSON format. */
    NSString *jsonResponse_noSQL = [storage toString];
    NSLog(@"JSON response_noSQL:%@",jsonResponse_noSQL);
    //TODO:JSON Response string parse to save $oid
    //NSDictionary *jsonResponseDict_noSQL = [[jsonResponse_noSQL JSONData] objectFromJSONData];
    //NSLog(@"JSON responseDict_noSQL:%@",jsonResponseDict_noSQL);
    //hard-code the ItemID for testing.
    //itemData.itemId = @"11";
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
    //Auto back navigation
    [self.navigationController popViewControllerAnimated:YES];
    //Notify to notification center.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryItemsAdded" object:self];
    //
    UITabBarController *bottomTabBarCtrl= (UITabBarController *)self.navigationController.parentViewController;
    bottomTabBarCtrl.selectedIndex = 0;
}

- (void)dealloc {
    [self.addressTxt release];
    [self.resturantTxt release];
    [self.telphoneTxt release];
    [self.agreeNextTimeSwitch release];
    [super dealloc];
}

@end
