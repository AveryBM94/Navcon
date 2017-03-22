//
//  WebViewCon.m
//  NavCtrl
//
//  Created by Avery Barrantes on 3/1/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "WebViewCon.h"


@interface WebViewCon ()

@end

@implementation WebViewCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:self.urlToLoad];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
