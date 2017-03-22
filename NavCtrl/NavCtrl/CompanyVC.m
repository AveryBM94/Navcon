//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;

    
    //change these to nsmutable arrays
//    self.companyList = @[@"Apple mobile devices",@"Samsung mobile devices", @"Black Berry mobile devices", @"Motorola Moto mobile devices"];
    self.trueCompanyList = [[NSMutableArray alloc]initWithObjects:@"Apple mobile devices",@"Samsung mobile devices", @"Black Berry mobile devices", @"Motorola Moto mobile devices", nil];
    self.trueImageList = [[NSMutableArray alloc]initWithObjects:@"navConApple.jpeg",@"navConSamsung.png", @"navConBlackBerry.jpeg", @"navConMotorola.png", nil];
    self.title = @"Mobile device makers";
    // Do any additional setup after loading the view from its nib.
    
    
    // Do any additional setup after loading the view from its nib.
    
        self.appleProds = [[NSMutableArray alloc]initWithObjects: @"iPhone", @"iPod Touch",@"iPad Pro",nil];
        self.appleProdPhotos = [[NSMutableArray alloc]initWithObjects:@"iPodTouch.png", @"iPhone.jpeg", @"iPadPro.jpeg", nil]; //apple product photos

        self.blackBerryProds = [[NSMutableArray alloc]initWithObjects:@"Passport", @"Leap", @"Priv",nil];
        self.blackBerryProdPhotos = [[NSMutableArray alloc]initWithObjects:@"passport.jpeg", @"leap.jpeg", @"priv.jpeg", nil];
    
        self.motorolaProds = [[NSMutableArray alloc]initWithObjects:@"Moto Z Play", @"Moto G4 Plus", @"Moto Z Force Droid", nil];
        self.motoProdPhotos = [[NSMutableArray alloc]initWithObjects:@"MotoZPlay.jpeg", @"MotoG4Plus.jpeg", @"MotoZForceDroid.jpeg", nil];

        self.samsungProds = [[NSMutableArray alloc]initWithObjects: @"Galaxy S7", @"Galaxy Note", @"Galaxy Tab", nil];
        self.samsungProdPhotos = [[NSMutableArray alloc]initWithObjects:@"GalaxyS7.jpeg", @"GalaxyNote7.jpeg", @"GalaxyTab.jpeg", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.trueCompanyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([[self.trueCompanyList objectAtIndex:indexPath.row] isEqualToString:@"Apple mobile devices"]) {
     
    }
    cell.textLabel.text = [self.trueCompanyList objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.trueImageList objectAtIndex:indexPath.row]];
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
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     [_trueImageList removeObjectAtIndex:indexPath.row];
     [_trueCompanyList removeObjectAtIndex:indexPath.row];

 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }



 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
    
     NSString *companyToMove = [self.trueCompanyList objectAtIndex:fromIndexPath.row];
     NSString *companyPhotoToMove = [self.trueImageList objectAtIndex:fromIndexPath.row];
      NSLog(@"happened with %@", companyToMove);
     [self.trueCompanyList removeObjectAtIndex:fromIndexPath.row];
     [self.trueCompanyList insertObject:companyToMove atIndex:toIndexPath.row];
     
     [self.trueImageList removeObjectAtIndex:fromIndexPath.row];
     [self.trueImageList insertObject:companyPhotoToMove atIndex:toIndexPath.row];
     
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
    
    NSString *selectedCompany = [self.trueCompanyList objectAtIndex:[indexPath row]];
    
    self.productViewController = [[ProductVC alloc]init];
     if ([selectedCompany isEqualToString: @"Apple mobile devices"]){
        self.productViewController.title = @"Apple mobile devices";
         self.productViewController.products = self.appleProds;
          self.productViewController.productPhotos = self.appleProdPhotos;
         
} else if ([selectedCompany isEqualToString:@"Samsung mobile devices"]){
         self.productViewController.title = @"Samsung mobile devices";
          self.productViewController.products = self.samsungProds;
           self.productViewController.productPhotos = self.samsungProdPhotos;

    }
    
         else if ([selectedCompany isEqualToString:@"Black Berry mobile devices"]){
             self.productViewController.title = @"Black Berry mobile devices";
              self.productViewController.products = self.blackBerryProds;
               self.productViewController.productPhotos = self.blackBerryProdPhotos;

         }
    
             else if ([selectedCompany isEqualToString:@"Motorola Moto mobile devices"]){
                 self.productViewController.title = @"Motorola Moto mobile devices";
                  self.productViewController.products = self.motorolaProds;
                   self.productViewController.productPhotos = self.motoProdPhotos;

             }
    
         
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
    
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
