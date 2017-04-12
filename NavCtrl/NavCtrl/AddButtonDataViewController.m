//
//  AddButtonDataViewController.m
//  NavCtrl
//
//  Created by Avery Barrantes on 3/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "AddButtonDataViewController.h"

@interface AddButtonDataViewController ()

@end

@implementation AddButtonDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    /*[self.companyTextField setPlaceholder:@"Enter Company Name"];
    [self.companyTextField2 setPlaceholder:@"Enter Text"];
    [self.companyTextField3 setPlaceholder:@"Enter Text"];*/
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

-(void)save{
    
    //if company mode
    Company *newCompany = [[Company alloc]init];
    newCompany.companyName = self.companyNameTextField.text;
    newCompany.ticker = self.companyTickerTextField.text;
    
    //if product
    Product *newProduct =  [[Product alloc]init];
    newProduct.productNames = self.companyNameTextField.text;
    newProduct.productPhotos =self.companyLogoTextField.text;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
   // [_addCompany release];
   // [_companyLabel release];
    [_companyNameTextField release];
    [_productNameTextField release];
    [_companyTickerTextField release];
    [_productURLTextField release];
    [_companyLogoTextField release];
    [_productImageTextField release];
    [super dealloc];
}
@end
