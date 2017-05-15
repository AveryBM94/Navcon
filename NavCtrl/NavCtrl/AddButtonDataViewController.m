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
    self.DAO = [DAO sharedManager];

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.companyNameTextField.delegate = self;
    self.companyLogoTextField.delegate = self;
    self.companyTickerTextField.delegate = self;
  
        
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height+200;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    //the next 2 if statements handel the grey text within the text field.
    
    if (self.DAO.isCompanyAddMode == YES){
        self.companyNameTextField.placeholder = @"Company Name ";
        [self.companyLogoTextField setPlaceholder:@"Company Photo"];
        [self.companyTickerTextField setPlaceholder:@"Company Ticker"];

    }
    
    if (self.DAO.isProductAddMode == YES){
        [self.companyNameTextField setPlaceholder:@"Product Name "];
        [self.companyLogoTextField setPlaceholder:@"Product Photo"];
        [self.companyTickerTextField setPlaceholder:@"Product Ticker"];
        
    }
    
    
}

- (void)save {
    
    if(self.DAO.isCompanyAddMode == YES){
    Company *newCompany = [[Company alloc]init];
    newCompany.companyName = self.companyNameTextField.text;
    newCompany.ticker = self.companyTickerTextField.text;
    newCompany.logos = self.companyLogoTextField.text;
    [self.DAO.companies addObject:newCompany];
        [self.DAO addCompanyToDB:newCompany];
    [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    else if (self.DAO.isProductAddMode == YES){
    Product *newProduct =  [[Product alloc]init];
    newProduct.productNames = self.companyNameTextField.text;
    newProduct.productPhotos = self.companyLogoTextField.text;
    newProduct.urlString = self.companyTickerTextField.text;
        [self.currentCompany.products addObject:newProduct];
        //[[self.currentCompay.products addObject: newProduct]]
       
        [self.DAO addProductToDB:newProduct forCompany:self.currentCompany];
        [self.navigationController popViewControllerAnimated:YES];

    }
    
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

- (void)greyCompanyText{
    //The three lines below set greyed out default text in the textfields in the addButtonViewController.xib
    /*[self.companyNameTextField setPlaceholder:@"Company Name "];
    [self.companyLogoTextField setPlaceholder:@"Company Photo"];
    [self.companyTickerTextField setPlaceholder:@"Company Ticker"];*/
}

- (void)greyProductText{
    //The three lines below set greyed out default text in the textfields in the addButtonViewController.xib
    /*[self.companyNameTextField setPlaceholder:@"Product Name "];
    [self.companyLogoTextField setPlaceholder:@"Product Photo"];
    [self.companyTickerTextField setPlaceholder:@"Product Ticker"];
    */
}
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
