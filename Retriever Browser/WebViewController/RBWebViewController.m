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

- (instancetype)initWithStrURL:(NSString *)strURL {
    if (self = [super init]) {
        self.strURL = strURL;
    }
    return self;
}

- (void)setStrURL:(NSString *)strURL {
    if (![strURL containsString:@"http://"] && ![strURL containsString:@"https://"]) {
        _strURL = [NSString stringWithFormat:@"http://%s",[strURL UTF8String]];
        return;
    }
    _strURL = strURL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadWebView];
}

- (void)loadWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, RBWebViewOriginY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - RBWebViewOriginY - UI_TABBAR_HEIGHT)];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self startRequest];
}

- (void)startRequest {
    NSURL *url = [NSURL URLWithString:self.strURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
