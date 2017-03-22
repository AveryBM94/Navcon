//
//  WebViewCon.h
//  NavCtrl
//
//  Created by Avery Barrantes on 3/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewCon : UIViewController <WKNavigationDelegate>

@property (strong, nonatomic) NSURL *urlToLoad;

@end
