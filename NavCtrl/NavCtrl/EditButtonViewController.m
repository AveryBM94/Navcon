//
//  EditButtonViewController.m
//  NavCtrl
//
//  Created by Avery Barrantes on 4/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "EditButtonViewController.h"

@interface EditButtonViewController ()

@end

@implementation EditButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DAO = [DAO sharedManager];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    if(self.isEditingCompany == TRUE){
        
        self.productName.text = self.selectedCompany.companyName;
        self.tickerTextField.text = self.selectedCompany.ticker;
        self.companyPhotoTextField.text = self.selectedCompany.logos;
        
    } else {
        
        self.productName.text = self.selectedProduct.productNames;
        
    }
    
    
}


- (void)save {
    
    if(self.isEditingCompany == TRUE){
    self.selectedCompany.companyName = self.productName.text;
    self.selectedCompany.ticker = self.tickerTextField.text;
    self.selectedCompany.logos  = self.companyPhotoTextField.text;
    } else {
        
    }
    [self.navigationController popViewControllerAnimated:TRUE];
    
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
    [_productName release];
    [_tickerTextField release];
    [_companyPhotoTextField release];
    [super dealloc];
}
@end
