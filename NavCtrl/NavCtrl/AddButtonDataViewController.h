//
//  AddButtonDataViewController.h
//  NavCtrl
//
//  Created by Avery Barrantes on 3/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"

@interface AddButtonDataViewController : UIViewController

@property BOOL isCompanyMode;
@property (retain, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *productNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyTickerTextField;
@property (retain, nonatomic) IBOutlet UITextField *productURLTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyLogoTextField;
@property (retain, nonatomic) IBOutlet UITextField *productImageTextField;




@end
