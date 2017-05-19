//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewCon.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import "AddButtonDataViewController.h"
#import "EditButtonViewController.h"

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UILabel *companyInfoLabel;
@property (retain, nonatomic) IBOutlet UIImageView *hideOrNot;
@property (retain, nonatomic) IBOutlet UIButton *secondAddButton;
- (IBAction)secondAddButton:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UILabel *addProductLabel;

@property (retain, nonatomic) IBOutlet UIImageView *companyLogoView;
@property (nonatomic, retain) AddButtonDataViewController *addButtonVC;
@property (nonatomic, retain) EditButtonViewController *editButtonVC;
@property (nonatomic, retain) DAO *dao;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Company *currentCompany;
//@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *productPhotos;
@property (nonatomic, retain) WebViewCon *webViewControler;
-(void)hideOrShow;
@end
