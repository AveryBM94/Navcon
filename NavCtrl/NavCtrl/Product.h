//
//  Product.h
//  NavCtrl
//
//  Created by Avery Barrantes on 3/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(nonatomic,retain) NSString *productNames;
@property(nonatomic,retain) NSString *productPhotos;
@property(nonatomic,retain) NSString *urlString;

- (instancetype)initWithProductNames:(NSString*)productName
                       productPhotos:(NSString*)productPhotos
                                 url:(NSString*)url;
@end
