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

@interface DAO : NSObject

@property (retain, nonatomic) NSMutableArray<Company*> *companies;

+ (id)sharedManager;

@end
