//
//  DAO.m
//  NavCtrl
//
//  Created by Avery Barrantes on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "CompanyVC.h"

@implementation DAO

+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        Product *iphone = [[Product alloc]initWithProductNames:@"iphone" productPhotos:@"iPhone.jpeg" url:@"https://www.google.com/"];
        
        Product *iPodTouch = [[Product alloc]initWithProductNames:@"iPod Touch" productPhotos:@"iPodTouch.png" url:@"http://www.apple.com/iphone/"];
        
        Product *iPadPro = [[Product alloc]initWithProductNames:@"iPad Pro" productPhotos:@"iPadPro.jpeg" url:@"http://www.apple.com/iphone/"];
        
        NSMutableArray *appleProducts = [[NSMutableArray alloc]initWithObjects:iphone, iPodTouch, iPadPro, nil];
        ///////////
        //ADD TICKER
        ////////////
        Company *apple = [[Company alloc]initWithCompanyName:@"Apple mobile devices" logos:@"navConApple.jpeg" products:appleProducts ticker:@"AAPL"];
        
       ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        Product *galaxyS7 = [[Product alloc]initWithProductNames:@"Galaxy S7" productPhotos:@"GalaxyS7.jpeg" url:@"http://www.apple.com/iphone/"];
        
        Product *galaxyNote = [[Product alloc]initWithProductNames:@"Galaxy Note" productPhotos:@"GalaxyNote7.jpeg" url:@"http://www.apple.com/iphone/"];
        
        Product *galaxyTab = [[Product alloc]initWithProductNames:@"Galaxy Tab" productPhotos:@"GalaxyTab.jpeg" url:@"http://www.apple.com/iphone/"];
        
        NSMutableArray *samsungProducts = [[NSMutableArray alloc]initWithObjects:galaxyS7, galaxyNote, galaxyTab, nil];
        
        Company *samsung = [[Company alloc]initWithCompanyName:@"Samsung mobile devices" logos:@"navConSamsung.png" products:samsungProducts ticker:@"SSNNF"];
        
        
        
        Product *passport = [[Product alloc]initWithProductNames:@"Passport" productPhotos:@"iPhone.jpeg" url:@"http://www.apple.com/iphone/"];
        
        Product *leap = [[Product alloc]initWithProductNames:@"Leap" productPhotos:@"leap.jpeg" url:@"http://www.apple.com/iphone/"];
        
        Product *priv = [[Product alloc]initWithProductNames:@"Priv" productPhotos:@"priv.jpeg" url:@"http://www.apple.com/iphone/"];
        
        NSMutableArray *blackBerryProducts = [[NSMutableArray alloc]initWithObjects:passport, leap, priv, nil];
        
        Company *blackBerry = [[Company alloc]initWithCompanyName:@"Black Berry mobile devices" logos:@"navConBlackBerry.jpeg" products:blackBerryProducts ticker:@"BBRY"];
        
        
        
        Product *motoZPlay = [[Product alloc]initWithProductNames:@"Moto Z Play" productPhotos:@"MotoZPlay.jpeg" url:@"http://www.apple.com/iphone/"];
        
        Product *motoG4Plus = [[Product alloc]initWithProductNames:@"Moto G4 Plus" productPhotos:@"MotoG4Plus.jpeg" url:@"http://www.apple.com/iphone/"];
        
        Product *motoZForceDroid = [[Product alloc]initWithProductNames:@"Moto Z Force Droid" productPhotos:@"MotoG4Plus.jpeg" url:@"http://www.apple.com/iphone/"];
        
        NSMutableArray *motoProducts = [[NSMutableArray alloc]initWithObjects:motoZPlay, motoG4Plus, motoZForceDroid, nil];
        
        Company *moto = [[Company alloc]initWithCompanyName:@"Motorola Moto mobile devices" logos:@"navConMotorola.png" products:motoProducts ticker:@"MSI"];
        
        
        
        self.companies = [[NSMutableArray alloc]initWithObjects:apple, samsung, blackBerry, moto, nil];

        
    }
    return self;
}

-(NSString*)generateStockSymbolUrl {
    self.tickerData = [[NSMutableArray alloc] init];
    
    for (Company *comp in self.companies) {
        [self.tickerData addObject:comp.ticker];
        //Take the tickerData array, addObject the comp.ticker;
        NSLog(@"%@",_tickerData);
    }
    
    NSString *tickers = [self.tickerData componentsJoinedByString:@"+"];
    NSLog(@"%@",tickers);
    
    NSString *baseUrl = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a", tickers];
    NSLog(@"%@",baseUrl);
    
       return baseUrl;
}

- (void)httpGetRequest{
    
    //code challange 2 parse through data to get the prices in the right order according to company
    NSString *urlEndpoint = [self generateStockSymbolUrl];
    NSLog(@"endpoint: %@", urlEndpoint);
    NSURL *url = [NSURL URLWithString:urlEndpoint];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *error)//the code within the following brackets will run after the code above regaurdless of weather or not the code above works or not.
      {
          
          //turns json info into a dictionary
          NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          
          
          NSArray *resultsArray = [dataString componentsSeparatedByString:@"\n"];
          
          //NSLog(@"RESULTS String: %@", dataString);
          //NSLog(@"RESULTS Array: %@", resultsArray);
          
          int i = 0;
          for (Company *comp in self.companies) {
              comp.tickerPrice = resultsArray[i];
              i++;
              NSLog(@"comp.TickerPrice: %@", comp.tickerPrice);
          }
          
          dispatch_async(dispatch_get_main_queue(), ^{
              //
              //turns the dictionary value's into double's
              [self.delegate reloadTableView];
          });
          
      }]resume];
    
}



@end
