//
//  DAO.m
//  NavCtrl
//
//  Created by Avery Barrantes on 3/28/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "CompanyVC.h"
#import "NavControllerAppDelegate.h"


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
        
        NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
        self.context = appDelegate.persistentContainer.viewContext;
        self.context.undoManager = [[NSUndoManager alloc] init];
        
         self.managedCompanies = [[NSMutableArray alloc]init];
        BOOL appHasRan = [[NSUserDefaults standardUserDefaults]boolForKey:@"appHasRan"];
        if (appHasRan == NO) {
            [self createStockCompanies];
//            [self fetchFromCoreData];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"appHasRan"];
        } else {
            //fetch from core data
            [self fetchFromCoreData];
            
            
        }
    }
    return self;
}

-(void)fetchFromCoreData {
      self.companies = [[NSMutableArray alloc] init];
   
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    self.managedCompanies = [results mutableCopy];
        NSLog(@"%lu", (unsigned long)results.count);
    
    //self.managedCompanies = [results mutableCopy];

//    if (results.count == 0) {
//        [self createStockCompanies];
        for (ManagedCompany *companyResult in results) {
            Company *thisCompany = [[Company alloc] init];
            //set all thisCompany properties
            thisCompany.companyName = companyResult.name;
            thisCompany.logos = companyResult.logo;
            thisCompany.ticker = companyResult.ticker;
            NSLog(@"%@",thisCompany);
            
            thisCompany.products = [[NSMutableArray alloc] init];
            
            for (ManagedProduct *productResult in companyResult.products) {
                Product *thisProduct = [[ Product alloc]init];
                //create Product objects and add them to thisCompany
                thisProduct.productNames = productResult.name;
                thisProduct.productPhotos = productResult.photo;
                thisProduct.urlString = productResult.url;
                
                [thisCompany.products addObject:thisProduct];
                NSLog(@"%@",thisProduct);
                [thisProduct release];

                
            }
            [self.companies addObject:thisCompany];

         //
            [thisCompany release];

        }
    
   // [results release];
//    }
    //add company to self.companies array
   // [self saveCoreDataStuff];
    
}



-(void)createStockCompanies {
    
    
   
    
    Product *iphone = [[Product alloc]initWithProductNames:@"iphone" productPhotos:@"iPhone.jpeg" url:@"https://www.google.com/"];
    
    Product *iPodTouch = [[Product alloc]initWithProductNames:@"iPod Touch" productPhotos:@"iPodTouch.png" url:@"http://www.apple.com/iphone/"];
    
    Product *iPadPro = [[Product alloc]initWithProductNames:@"iPad Pro" productPhotos:@"iPadPro.jpeg" url:@"http://www.apple.com/iphone/"];

    
    
    NSMutableArray *appleProducts = [[NSMutableArray alloc]initWithObjects:iphone, iPodTouch, iPadPro, nil];
    
    [iphone release];
    [iPodTouch release];
    [iPadPro release];
    
    ///////////
    //ADD TICKER
    ////////////
    Company *apple = [[Company alloc]initWithCompanyName:@"Apple mobile devices" logos:@"navConApple.jpeg" products:appleProducts ticker:@"AAPL"];
    
    [appleProducts release];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    Product *galaxyS7 = [[Product alloc]initWithProductNames:@"Galaxy S7" productPhotos:@"GalaxyS7.jpeg" url:@"http://www.apple.com/iphone/"];
    
    Product *galaxyNote = [[Product alloc]initWithProductNames:@"Galaxy Note" productPhotos:@"GalaxyNote7.jpeg" url:@"http://www.apple.com/iphone/"];
    
    Product *galaxyTab = [[Product alloc]initWithProductNames:@"Galaxy Tab" productPhotos:@"GalaxyTab.jpeg" url:@"http://www.apple.com/iphone/"];
    
    NSMutableArray *samsungProducts = [[NSMutableArray alloc]initWithObjects:galaxyS7, galaxyNote, galaxyTab, nil];
    
    [galaxyS7 release];
    [galaxyNote release];
    [galaxyTab release];
    
    
    Company *samsung = [[Company alloc]initWithCompanyName:@"Samsung mobile devices" logos:@"navConSamsung.png" products:samsungProducts ticker:@"SSNNF"];
    
    [samsungProducts release];
    
    
    Product *passport = [[Product alloc]initWithProductNames:@"Passport" productPhotos:@"iPhone.jpeg" url:@"http://www.apple.com/iphone/"];
    
    Product *leap = [[Product alloc]initWithProductNames:@"Leap" productPhotos:@"leap.jpeg" url:@"http://www.apple.com/iphone/"];
    
    Product *priv = [[Product alloc]initWithProductNames:@"Priv" productPhotos:@"priv.jpeg" url:@"http://www.apple.com/iphone/"];
    
    NSMutableArray *blackBerryProducts = [[NSMutableArray alloc]initWithObjects:passport, leap, priv, nil];
    
    [passport release];
    [leap release];
    [priv release];
    
    Company *blackBerry = [[Company alloc]initWithCompanyName:@"Black Berry mobile devices" logos:@"navConBlackBerry.jpeg" products:blackBerryProducts ticker:@"BBRY"];
    
    [blackBerryProducts release];
    
    
    Product *motoZPlay = [[Product alloc]initWithProductNames:@"Moto Z Play" productPhotos:@"MotoZPlay.jpeg" url:@"http://www.apple.com/iphone/"];
    
    Product *motoG4Plus = [[Product alloc]initWithProductNames:@"Moto G4 Plus" productPhotos:@"MotoG4Plus.jpeg" url:@"http://www.apple.com/iphone/"];
    
    Product *motoZForceDroid = [[Product alloc]initWithProductNames:@"Moto Z Force Droid" productPhotos:@"MotoG4Plus.jpeg" url:@"http://www.apple.com/iphone/"];
    
    NSMutableArray *motoProducts = [[NSMutableArray alloc]initWithObjects:motoZPlay, motoG4Plus, motoZForceDroid, nil];
    
    [motoZPlay release];
    [motoG4Plus release];
    [motoZForceDroid release];
    
    Company *moto = [[Company alloc]initWithCompanyName:@"Motorola Moto mobile devices" logos:@"navConMotorola.png" products:motoProducts ticker:@"MSI"];
    [motoProducts release];
    
    
    self.companies = [[NSMutableArray alloc]initWithObjects:apple, samsung, blackBerry, moto, nil];
    
    [apple release];
    [samsung release];
    [blackBerry release];
    [moto release];
    
    
    for (Company *company in self.companies) {
        ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.context];
        mC.name = company.companyName;
        mC.logo = company.logos;
        mC.ticker = company.ticker;
        for (Product *product in company.products) {
            //create managed products and assign them to mC
            ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.context];
            mP.name = product.productNames;
            mP.photo = product.productPhotos;
            mP.url = product.urlString;
            mP.company = mC;
            [mC addProductsObject:mP];
        }
        [self.managedCompanies addObject:mC];
    }
    [self saveCoreDataStuff];

}

- (void) addCompanyToDB:(Company *)company{
    ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.context];
    mC.name = company.companyName;
    mC.logo = company.logos;
    mC.ticker = company.ticker;
    
    [self.managedCompanies addObject:mC];
    
    [self saveCoreDataStuff];
}



-(void) addProductToDB:(Product *)product forCompany: (Company*) company{
    ManagedProduct *mP = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.context];
    mP.name = product.productNames;
    mP.photo = product.productPhotos;
    mP.url = product.urlString;
    
    //find managedCompany that corresponds to company
    
    NSUInteger index = [self.companies indexOfObject:company];
    NSLog(@"%lu index", (unsigned long)index);
    NSLog(@"%@ companies", _companies);
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:index];
    NSLog(@"%lu managed companies", (unsigned long)[self.managedCompanies count]);
    NSLog(@"... %@ adding to %@", mP.name, mC.name);

    [mC.products setByAddingObject:mP];
    mP.company = mC;

    [self saveCoreDataStuff];
    NSLog(@"%@", mC);
    NSLog(@"%@", mP);

}

- (void)deleteCompanyFromDB:(Company*)deleteCompany{
    //NSUInteger index = [self.companies indexOfObject:deleteCompany];
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:deleteCompany]];
    
    [self.companies removeObject:deleteCompany];
    [self.context deleteObject:mC];
    [self.managedCompanies removeObject:mC];
    //[self saveCoreDataStuff];
}


- (void)deleteProductFromDB:(Product*)deleteProduct fromCompany: (Company*)company{
    //line below gets the company of the selected product to be deleted
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:company]];
    //209 - 213 get the product selected to be deleted
    ManagedProduct *managedProductToDelete;
    for (ManagedProduct *mP in mC.products) {
        if ([mP.name isEqualToString:deleteProduct.productNames]) {
            managedProductToDelete = mP;
        }
    }
    //2 lines  below delete the product and save the change
    [mC removeProductsObject:managedProductToDelete];
    [self.context deleteObject:managedProductToDelete];
    //[self saveCoreDataStuff];
}

- (void)editCompanyInDB:(Company *)editCompany{

    
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:editCompany]];
    mC.name = editCompany.companyName;
    mC.logo = editCompany.logos;
    mC.ticker = editCompany.ticker;
    
    
    //[self saveCoreDataStuff];

}



- (void)editProductInDB:(Product *)editedProduct
       fromProductNamed:(NSString*) oldProductName
            fromCompany:(Company *)company{
    
    ManagedCompany *mC = [self.managedCompanies objectAtIndex:[self.companies indexOfObject:company]];
    
    ManagedProduct *managedProductToEdit;
    for (ManagedProduct *mP in mC.products) {
        if ([mP.name isEqualToString:oldProductName]) {
            mP.name = editedProduct.productNames;
            mP.photo = editedProduct.productPhotos;
            mP.url = editedProduct.urlString;
            managedProductToEdit = mP;
        }

    
    
    
    }
    [self saveCoreDataStuff];

}


-(NSString*)generateStockSymbolUrl {
    _tickerData = [[NSMutableArray alloc] init];
    
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
    NSURLSession *session = [[NSURLSession sessionWithConfiguration:config] autorelease];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    request.HTTPMethod = @"GET";
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *error)//the code within the following brackets will run after the code above regaurdless of weather or not the code above works or not.
      {
          
          //turns json info into a dictionary
          NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          
          
          NSMutableArray *resultsArray = [[dataString componentsSeparatedByString:@"\n"] mutableCopy];
          [resultsArray removeLastObject];
          [dataString release];
          
          
          if(resultsArray.count!=self.companies.count){
              NSLog(@"Stock Array count [%lu] & Companies count [%lu] Not Matching", (unsigned long)resultsArray.count, (unsigned long)self.companies.count);
              [resultsArray release];
              return;
          }
          
          
          
          //NSLog(@"RESULTS String: %@", dataString);
          //NSLog(@"RESULTS Array: %@", resultsArray);
          
          int i = 0;
          for (Company *comp in self.companies) {
              comp.tickerPrice = resultsArray[i];
              i++;
              NSLog(@"comp.TickerPrice: %@", comp.tickerPrice);
          }
          
          
           [resultsArray release];
          
          
          
          dispatch_async(dispatch_get_main_queue(), ^{
              //
              [self.delegate reloadTableView];
          });
          
          
          
      }]resume];
}

-(void)undoLastCDChange {
    [self.context undo];
    // refetch from core data
    [self fetchFromCoreData];
}


-(void)saveCoreDataStuff {
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate saveContext];
    
}


- (void)dealloc
{
    
    [_context release];
    [_managedCompanies release];
    [_companies release];
    [_delegate release];
    [super dealloc];
}









@end
