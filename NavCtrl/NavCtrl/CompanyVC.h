//
//  CompanyVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "DAO.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) DAO *dao;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,retain) NSMutableArray *companies;
@property (nonatomic, retain) NSArray *companyList;
@property (nonatomic, retain) ProductVC *productViewController;
@property (nonatomic, retain) AddButtonDataViewController *addButtonVC;
@property (nonatomic, retain) NSMutableArray *trueCompanyList;
@property (nonatomic, retain) NSMutableArray *trueImageList;
@property (nonatomic, retain) NSMutableArray *appleProds;
@property (nonatomic, retain) NSMutableArray *blackBerryProds;
@property (nonatomic, retain) NSMutableArray *samsungProds;
@property (nonatomic, retain) NSMutableArray *motorolaProds;
@property (nonatomic, retain) NSMutableArray *appleProdPhotos;
@property (nonatomic, retain) NSMutableArray *blackBerryProdPhotos;
@property (nonatomic, retain) NSMutableArray *motoProdPhotos;
@property (nonatomic, retain) NSMutableArray *samsungProdPhotos;
@property (nonatomic, retain) NSMutableArray *productsArray;


-(void)addButtonScreen;
-(void)saveButton;
@end
