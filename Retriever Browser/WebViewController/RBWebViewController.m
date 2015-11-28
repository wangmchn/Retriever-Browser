//
//  RBWebViewController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBWebViewController.h"

static CGFloat const RBWebViewOriginY = 20.0;
@interface RBWebViewController ()

@end

@implementation RBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, RBWebViewOriginY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - RBWebViewOriginY - UI_TABBAR_HEIGHT)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
