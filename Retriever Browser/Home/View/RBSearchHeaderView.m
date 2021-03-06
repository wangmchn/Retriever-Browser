//
//  RBSearchHeaderView.m
//  Retriever Browser
//
//  Created by Mark on 15/11/27.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBSearchHeaderView.h"
#import "RBWebViewController.h"
#import "RBScannerController.h"

@implementation RBSearchHeaderView

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
    self.searchBar.placeholder = @"请输入网址";
    self.searchBar.delegate = self;
    [self addSubview:self.searchBar];
    
    self.QRScanner = [[UIButton alloc] init];
    [self.QRScanner addTarget:self action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
    [self.QRScanner setImage:[UIImage imageNamed:@"icon_scanner"] forState:UIControlStateNormal];
    [self addSubview:self.QRScanner];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 50));
    }];
    
    [self.QRScanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self jumpToWebsite];
    return YES;
}

- (void)jumpToWebsite {
    NSString *strURL = self.searchBar.text;
    RBWebViewController *webViewController = [[RBWebViewController alloc] initWithStrURL:strURL];
    [self.viewController.navigationController pushViewController:webViewController animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)scan:(UIButton *)sender {
    RBScannerController *scanner = [[RBScannerController alloc] init];
    [self.viewController.navigationController pushViewController:scanner animated:YES];
}

@end
