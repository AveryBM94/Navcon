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
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
         self.navigationItem.rightBarButtonItem = editButton;
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    

    
//    if ([self.title isEqualToString:@"Apple mobile devices"]) {
//        self.products = [[NSMutableArray alloc]initWithObjects: @"iPhone", @"iPod Touch",@"iPad Pro",nil];
//        self.productPhotos = [[NSMutableArray alloc]initWithObjects:@"iPodTouch.png", @"iPhone.jpeg", @"iPadPro.jpeg", nil]; //apple product photos
//    }
//    else if ([self.title isEqualToString:@"Black Berry mobile devices"]){
//        self.products = [[NSMutableArray alloc]initWithObjects:@"Passport", @"Leap", @"Priv",nil];
//        self.productPhotos = [[NSMutableArray alloc]initWithObjects:@"passport.jpeg", @"leap.jpeg", @"priv.jpeg", nil];
//    }
//    else if ([self.title isEqualToString:@"Motorola Moto mobile devices"]){
//        
//        self.products = [[NSMutableArray alloc]initWithObjects:@"Moto Z Play", @"Moto G4 Plus", @"Moto Z Force Droid", nil];
//        self.productPhotos = [[NSMutableArray alloc]initWithObjects:@"MotoZPlay.jpeg", @"MotoG4Plus.jpeg", @"MotoZForceDroid.jpeg", nil];
//    }
//    
//    else if ([self.title isEqualToString:@"Samsung mobile devices"]) {
//        self.products = [[NSMutableArray alloc]initWithObjects: @"Galaxy S7", @"Galaxy Note", @"Galaxy Tab", nil];
//        self.productPhotos = [[NSMutableArray alloc]initWithObjects:@"GalaxyS7.jpeg", @"GalaxyNote7.jpeg", @"GalaxyTab.jpeg", nil];
//    }
//    [self.tableView reloadData];
}

-(void)toggleEditMode {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
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
        [self.currentCompany.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
     NSString *productToMove = [self.products objectAtIndex:fromIndexPath.row];
//     NSLog(@"happened with %@", companyToMove);
     [self.products removeObjectAtIndex:fromIndexPath.row];
     [self.products insertObject:productToMove atIndex:toIndexPath.row];
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
     self.webViewControler = [[WebViewCon alloc]init];
     Product *productSelected = [self.currentCompany.products objectAtIndex:indexPath.row];
     
     self.webViewControler.urlToLoad = [NSURL URLWithString:productSelected.urlString];
     
     
     /*if ([productSelected isEqualToString:@"iPad Pro"]) {
         NSURL *url = [NSURL URLWithString:@"http://www.apple.com/ipad/"];
         self.webViewControler.urlToLoad = url;
     } 
     
     if ([productSelected isEqualToString:@"iPod Touch"]) {
         NSURL *url = [NSURL URLWithString:@"http://www.apple.com/ipod/"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"iPhone"]) {
         NSURL *url = [NSURL URLWithString:@"http://www.apple.com/iphone/"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Passport"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_ss_i_2_17?url=search-alias%3Dmobile&field-keywords=black+berry+passport&sprefix=black+berry+passp%2Cmobile%2C273&crid=1L7VD8AGDZS7D&rh=n%3A2335752011%2Ck%3Ablack+berry+passport"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Leap"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/BlackBerry-Leap-Unlocked-Cellphone-Shadow/dp/B00UH9AMKM/ref=sr_1_1?ie=UTF8&qid=1489605089&sr=8-1&keywords=black+berry+leap"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Priv"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=black+berry+priv"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Moto Z Play"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=Moto+Z+Play&rh=n%3A2335752011%2Ck%3AMoto+Z+Play"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Moto G4 Plus"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=Moto+G4+Plus&rh=n%3A2335752011%2Ck%3AMoto+G4+Plus"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Moto Z Force Droid"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=Moto+Z+Force+Droid&rh=n%3A2335752011%2Ck%3AMoto+Z+Force+Droid"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Galaxy S7"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=Galaxy+S7&rh=n%3A2335752011%2Ck%3AGalaxy+S7"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Galaxy Note"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=Galaxy+Note&rh=n%3A2335752011%2Ck%3AGalaxy+Note"];
         self.webViewControler.urlToLoad = url;
     }

     if ([productSelected isEqualToString:@"Galaxy Tab"]) {
         NSURL *url = [NSURL URLWithString:@"https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Dmobile&field-keywords=galaxy+tab&rh=n%3A2335752011%2Ck%3Agalaxy+tab"];
         self.webViewControler.urlToLoad = url;
         */
    // }

     
     
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:self.webViewControler animated:YES];
 }
 



- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
