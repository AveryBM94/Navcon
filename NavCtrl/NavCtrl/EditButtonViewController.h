//
//  EditButtonViewController.h
//  NavCtrl
//
//  Created by Avery Barrantes on 4/13/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface EditButtonViewController : UIViewController
@property (retain, nonatomic) DAO *DAO;
@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *tickerTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyPhotoTextField;
@property BOOL isEditingCompany;
@property (retain, nonatomic) Company *selectedCompany;
@property (retain, nonatomic) Product *selectedProduct;


@end
