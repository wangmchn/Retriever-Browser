//
//  RBBaiduSearchView.m
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBBaiduSearchView.h"
#import "RBWebViewController.h"

@implementation RBBaiduSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = RGBCOLOR(191, 191, 191).CGColor;
    self.layer.borderWidth = 0.5;
    
    self.searchBar = [[UITextField alloc] init];
    self.searchBar.font = [UIFont systemFontOfSize:14];
    self.searchBar.textColor = RGBCOLOR(22, 22, 22);
    self.searchBar.placeholder = @"百度一下, 你就知道";
    self.searchBar.delegate = self;
    [self addSubview:self.searchBar];
    
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchButton setTitleColor:RGBCOLOR(51, 136, 255) forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchButton];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_baidu"]];
    [self addSubview:icon];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 40, 0, 60));
    }];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@5);
        make.bottom.equalTo(@-5);
        make.width.equalTo(icon.mas_height);
    }];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.equalTo(@50);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self search:nil];
    return YES;
}

- (void)search:(UIButton *)sender {
    if (self.searchBar.text.length <= 0) { return; }
    [self.searchBar resignFirstResponder];
    NSString *strURL = [NSString stringWithFormat:@"http://m.baidu.com/ssid=37e2c4e3bbb9d4dab7b3c4d5cab2c3b4551c/s?word=%@&sa=tb&ts=7338631&t_kt=0&ss=100&t_it=1&rsv_sug4=2414&oq=111", [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    RBWebViewController *webViewController = [[RBWebViewController alloc] initWithStrURL:strURL];
    [self.viewController.navigationController pushViewController:webViewController animated:YES];
}

@end
