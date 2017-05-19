//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"

@interface ProductVC ()

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideOrShow];

    self.dao = [DAO sharedManager];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonScreen)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];

        // self.navigationItem.rightBarButtonItem = editButton;
    self.tableView.allowsSelectionDuringEditing = TRUE;


}

- (void)viewWillAppear:(BOOL)animated {
    [self hideOrShow];

    self.companyLogoView.image = [UIImage imageNamed:self.currentCompany.logos];
    self.companyInfoLabel.text = [NSString stringWithFormat:@" %@ (%@)",_currentCompany.companyName, _currentCompany.ticker];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)addButtonScreen{
    //line below init's the AddButtonDataViewController with addButtonVC
    
    self.addButtonVC = [[AddButtonDataViewController alloc] init];
   // [self.addButtonVC.companyNameTextField setPlaceholder:@"Product Name "];
    //[self.addButtonVC.companyLogoTextField setPlaceholder:@"Product Photo"];
    //[self.addButtonVC.companyTickerTextField setPlaceholder:@"Product Ticker"];
    self.dao.isProductAddMode = YES;
    
    
    self.addButtonVC.currentCompany = self.currentCompany;
    
    //line below pushes to the addButtonViewController
    [self.navigationController pushViewController:self.addButtonVC animated:YES];
}


-(void)toggleEditMode {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
       // UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonScreen)];
       // self.navigationItem.leftBarButtonItem = addButton;
        
        [self.tableView reloadData];
    }
    
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Done";
        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        Product* selectedProduct = [self.currentCompany.products objectAtIndex:indexPath.row];
        [selectedProduct retain];
        [self.currentCompany.products removeObjectAtIndex:indexPath.row];

        [self.dao deleteProductFromDB:selectedProduct fromCompany:self.currentCompany];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self hideOrShow];

    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.currentCompany.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
//     if (indexPath.row == 0){
//        UIImage *image1 = [UIImage imageNamed:@"navConSamsung.png"];
//        cell.imageView.image = image1;
//        
//    }
//    
//     else if (indexPath.row == 1){
//         UIImage *image1 = [UIImage imageNamed:@"navConSamsung.png"];
//         cell.imageView.image = image1;
//         
//     }
//
//     else if (indexPath.row == 2){
//         UIImage *image1 = [UIImage imageNamed:@"navConSamsung.png"];
//         cell.imageView.image = image1;
//         
//     }
    
    Product *thisProduct = [self.currentCompany.products objectAtIndex:indexPath.row];
    
    
    UIImage *currentImage = [UIImage imageNamed:thisProduct.productPhotos];
    
    cell.imageView.image = currentImage;
    cell.textLabel.text = thisProduct.productNames;
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


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
     NSString *productToMove = [self.currentCompany.products objectAtIndex:fromIndexPath.row];
//     NSLog(@"happened with %@", companyToMove);
     [self.currentCompany.products removeObjectAtIndex:fromIndexPath.row];
     [self.currentCompany.products insertObject:productToMove atIndex:toIndexPath.row];
     NSString *productPhotoToMove = [self.productPhotos objectAtIndex:fromIndexPath.row];
          NSLog(@"happened with %@", productToMove);
     [self.productPhotos removeObjectAtIndex:fromIndexPath.row];
     [self.productPhotos insertObject:productPhotoToMove atIndex:toIndexPath.row];
     
     [self.tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
     [self.tableView endUpdates];
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
 // Navigation logic may go here, for example:
 // Create the next view controller.
     
     
     Product *productSelected = [self.currentCompany.products objectAtIndex:indexPath.row];

     if (self.isEditing == TRUE){
         self.editButtonVC = [[EditButtonViewController alloc]init];
         self.editButtonVC.selectedCompany = self.currentCompany;
         self.editButtonVC.selectedProduct = productSelected;
         [self.navigationController pushViewController:self.editButtonVC animated:YES];
         
     }

     else{
         
     self.webViewControler = [[WebViewCon alloc]init];
     
     self.webViewControler.urlToLoad = [NSURL URLWithString:productSelected.urlString];
     
     
    
        
         [self.navigationController pushViewController:self.webViewControler animated:YES];

     }
     
     
     
     
     
     
   
     
     
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 }

-(void)hideOrShow{
    
    if (self.currentCompany.products.count == 0) {
        [self.secondAddButton setHidden:false];
        [self.hideOrNot setHidden:false];
        [self.addProductLabel setHidden:false];
    }
    else{
        [self.hideOrNot setHidden:true];
        [self.secondAddButton setHidden:true];
        [self.addProductLabel setHidden:true];

    }
}


- (void)dealloc {
    [_tableView release];
    [_companyLogoView release];
    [_companyInfoLabel release];
    [_hideOrNot release];
    [_secondAddButton release];

    [_addProductLabel release];
    [super dealloc];
}
- (IBAction)secondAddButton:(UIButton *)sender {
    
    [self addButtonScreen];
}

@end
