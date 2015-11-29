//
//  RBWebViewController.h
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

@interface RBWebViewController : UIViewController<NJKWebViewProgressDelegate, UIWebViewDelegate, UIScrollViewDelegate, UISearchBarDelegate>
@property (nonatomic, copy) NSString *strURL;
@property (nonatomic, strong) UIWebView *webView;

- (instancetype)initWithStrURL:(NSString *)strURL;
- (void)reloadWebView;
@end
