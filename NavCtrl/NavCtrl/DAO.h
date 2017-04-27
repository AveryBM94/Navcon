//
//  DAO.h
//  NavCtrl
//
//  Created by Avery Barrantes on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
//#import "AddButtonDataViewController.h"

@protocol reloadDelegate <NSObject>

-(void) reloadTableView;

@end


@interface DAO : NSObject
//@property (retain,nonatomic)AddButtonDataViewController * addStuff;
@property BOOL isCompanyAddMode;
@property BOOL isCompanyEditMode;
@property BOOL isProductAddMode;
@property BOOL isProductEditMode;
@property (retain, nonatomic) NSMutableArray *tickerData;
@property (retain, nonatomic) id <reloadDelegate> delegate;

@property (retain, nonatomic) NSMutableArray<Company*> *companies;

+ (id)sharedManager;

- (void)httpGetRequest;

@end
