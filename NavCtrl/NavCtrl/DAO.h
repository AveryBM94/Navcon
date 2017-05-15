//
//  DAO.h
//  NavCtrl
//
//  Created by Avery Barrantes on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Company.h"
#import "Product.h"
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataProperties.h"
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
@property (retain, nonatomic) NSManagedObjectContext *context;
@property (retain, nonatomic) NSMutableArray<Company*> *companies;

@property (retain, nonatomic) NSMutableArray<ManagedCompany*> *managedCompanies;

+ (id)sharedManager;

- (void)httpGetRequest;
- (void)fetchFromCoreData;
- (void)addCompanyToDB:(Company *)company;
- (void) addProductToDB:(Product *)product forCompany: (Company*) company;

- (void)deleteCompanyFromDB:(Company*)deleteCompany;
- (void)deleteProductFromDB:(Product*)deleteProduct fromCompany: (Company*)company;

- (void)editCompanyInDB:(Company*)editCompany;

- (void)editProductInDB:(Product *)editedProduct
       fromProductNamed:(NSString*) oldProductName
            fromCompany:(Company *)company;



@end

