//
//  RBWebViewController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBWebViewController.h"

static CGFloat const RBWebViewOriginY = 64.0;

@interface RBWebViewController ()
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation RBWebViewController

- (void)reloadWebView {
    [self startRequest];
}

- (instancetype)initWithStrURL:(NSString *)strURL {
    if (self = [super init]) {
        self.strURL = strURL;
        self.automaticallyAdjustsScrollViewInsets = NO;
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
    [self createSearchBar];
    [self loadWebView];
    [self startRequest];
}

#pragma mark - Private

- (void)createSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 15, UI_SCREEN_WIDTH, 44)];
    self.searchBar.placeholder = self.strURL;
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:self.searchBar];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 63, UI_SCREEN_WIDTH, 0.5)];
    line.backgroundColor = RGBCOLOR(191, 191, 191);
    [self.view addSubview:line];
}

- (void)loadWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, RBWebViewOriginY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - RBWebViewOriginY - UI_TABBAR_HEIGHT)];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.0f;
    CGRect barFrame = CGRectMake(0, UI_SCREEN_HEIGHT - UI_TABBAR_HEIGHT - progressBarHeight, UI_SCREEN_WIDTH, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.progressView];
    
    UIScrollView *scrollView = (UIScrollView *)self.webView.subviews[0];
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        scrollView.delegate = self;
    }
}

- (void)startRequest {
    NSURL *url = [NSURL URLWithString:self.strURL];
    NSLog(@"%@", self.strURL);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [self.webView loadRequest:request];
}

- (void)searchBarResignFirstResponderIfNeeded {
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - <UISearchBarDelegate>
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.placeholder = @"请输入网址";
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.placeholder = self.title;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.strURL = searchBar.text;
    [self reloadWebView];
}

#pragma mark - <UISrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self searchBarResignFirstResponderIfNeeded];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - <NJKWebViewProgressDelegate>
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    self.progressView.progress = progress;
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.searchBar.placeholder = self.title;
    self.searchBar.text = @"";
}

@end
