//
//  Company.m
//  NavCtrl
//
//  Created by Avery Barrantes on 3/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company


//custom initializer

    
    

    
- (instancetype)initWithCompanyName:(NSString *)companyName
                              logos:(NSString *)logos
                              products:(NSMutableArray *)products{
    
    if (self = [super init]) {
        self.companyName = companyName;
        self.logos = logos;
        self.products = products;
        
        
    }
    return self;
}


@end
