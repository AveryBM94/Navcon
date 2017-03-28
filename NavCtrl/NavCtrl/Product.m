//
//  Product.m
//  NavCtrl
//
//  Created by Avery Barrantes on 3/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithProductNames:(NSString *)productName
                       productPhotos:(NSString *)productPhotos
                                 url:(NSString *)url{

    self = [super init];
    if (self) {
        
        self.productNames = productName;
        self.productPhotos = productPhotos;
        self.urlString = url;
        
        
    }
    return self;

}

@end
