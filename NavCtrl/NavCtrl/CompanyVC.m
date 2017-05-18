//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"
#import "Company.h"
#import "Product.h"
#import "AddButtonDataViewController.h"
@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //how to init
   // self.addButtonVC = [[AddButtonDataViewController alloc] init];
    //create ipad
    //create iphone
    //create ipod
    //make a mutable array out of these three PRoduct objects
    //Product & Company are custom classes
    
    
   // self.companies = [[NSMutableArray alloc]initWithObjects:apple, samsung, blackBerry, moto, nil];
    
    
    /////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dao = [DAO sharedManager];
    self.dao.delegate = self;
    
    
    self.productViewController = [[ProductVC alloc]init];
    
    self.editButtonVC = [[EditButtonViewController alloc]initWithNibName:@"EditButtonViewController" bundle:nil];
    

    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    //line below adds an edit button to the nav con
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonScreen)];
    
  

   // self.navigationItem.rightBarButtonItem = editButton;
    // self.navigationItem.leftBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];
    
    self.tableView.allowsSelectionDuringEditing = TRUE;
    
    //line below sets the title at the top of the nav con
    self.navigationItem.title = @"Mobile Device Company";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated {
    self.dao.isCompanyAddMode = NO;
    self.dao.isCompanyEditMode = NO;
    self.dao.isProductAddMode = NO;
    self.dao.isProductEditMode = NO;
    
    [self.dao httpGetRequest];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source



- (IBAction)undoButton:(UIButton *)sender {
    //if ([self.dao.context hasChanges]) {
        [self.dao.context.undoManager undo];
        [self.dao fetchFromCoreData];
        [self.dao httpGetRequest];
    //}
}



- (IBAction)redoButton:(UIButton *)sender {
    //if ([self.dao.context hasChanges]) {
        [self.dao.context.undoManager redo];
        [self.dao fetchFromCoreData];
        [self.dao httpGetRequest];
    //}
}




-(void)addButtonScreen{
    //line below init's the AddButtonDataViewController with addButtonVC
    
    self.addButtonVC = [[AddButtonDataViewController alloc] init];
        self.dao.isCompanyAddMode = YES;
    //line below pushes to the addButtonViewController
    [self.navigationController pushViewController:self.addButtonVC animated:YES];
}

-(void)saveButton{
    self.addButtonVC = [[AddButtonDataViewController alloc] init];
    
}

-(void)toggleEditMode {
    if (self.tableView.editing) {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        [self.tableView reloadData];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        
    }
    
    else
    {
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Done";
        [self.tableView reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dao.companies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //if ([[self.companies objectAtIndex:indexPath.row] isEqualToString:@"Apple mobile devices"]) {
     
    //}
    Company *test =  [self.dao.companies objectAtIndex:indexPath.row];
    cell.textLabel.text = test.companyName;
    cell.detailTextLabel.text = test.tickerPrice;
    cell.imageView.image = [UIImage imageNamed:test.logos];
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView.editing == true){
        //show button
    }
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Company* selectedCompany = [self.dao.companies objectAtIndex:indexPath.row];
    //[self.dao.companies removeObjectAtIndex:indexPath.row];
       [self.dao deleteCompanyFromDB:selectedCompany];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Company *companyToMove = [self.dao.companies objectAtIndex:fromIndexPath.row];
    // NSString *companyPhotoToMove = [self.trueImageList objectAtIndex:fromIndexPath.row];
    NSLog(@"happened with %@", companyToMove.companyName);
    [companyToMove retain];
    [self.dao.companies removeObjectAtIndex:fromIndexPath.row];
    [self.dao.companies insertObject:companyToMove atIndex:toIndexPath.row];
    
    
    
    //[self.trueImageList removeObjectAtIndex:fromIndexPath.row];
    //[self.trueImageList insertObject:companyPhotoToMove atIndex:toIndexPath.row];
    
    [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    [self.tableView endUpdates];
    [companyToMove release];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Company *selectedCompany = [self.dao.companies objectAtIndex:[indexPath row]];
    
    
  
    
    if (self.isEditing == TRUE){
        
        self.editButtonVC.selectedCompany = selectedCompany;
        self.editButtonVC.isEditingCompany = TRUE;
        
        [self.navigationController pushViewController:self.editButtonVC animated:TRUE];
        
    } else{
        
    
    self.productViewController.currentCompany = selectedCompany;
    
         
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
        
    }
    
}

-(void) reloadTableView{
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
