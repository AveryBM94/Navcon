//
//  Company.h
//  NavCtrl
//
//  Created by Avery Barrantes on 3/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *logos;
@property (nonatomic, retain) NSString *ticker;
@property (nonatomic, retain) NSMutableArray *products;

- (instancetype)initWithCompanyName:(NSString*)companyName
                          logos:(NSString*)logos
                   products:(NSMutableArray*)products
                            ticker:(NSString*)ticker;



//name
//image
//products


@end
