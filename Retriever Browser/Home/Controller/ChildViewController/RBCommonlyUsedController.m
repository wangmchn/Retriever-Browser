//
//  RBCommonlyUsedController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/27.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBCommonlyUsedController.h"
#import "RBBaiduSearchView.h"
#import "RBWebViewController.h"

@interface RBCommonlyUsedController ()
@property (nonatomic, strong) NSDictionary *commonWebsites;
@end

static NSInteger const RBWebsiteButtonTagOffset = 6250;
static CGFloat   const RBBaiduSearchViewHeight = 35.0;
@implementation RBCommonlyUsedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBaiduSearchView];
    [self createWebsiteButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Load
- (NSDictionary *)commonWebsites {
    if (!_commonWebsites) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Website" ofType:@"plist"];
        _commonWebsites = [NSDictionary dictionaryWithContentsOfFile:filePath][@"Main"];
    }
    return _commonWebsites;
}

#pragma mark - Private Methods
- (void)createWebsiteButtons {
    CGFloat buttonWidth = (UI_SCREEN_WIDTH - 40) / 4;
    CGFloat buttonHeight = 44;
    NSArray *keys = self.commonWebsites.allKeys;
    for (int i = 0; i < keys.count; i++) {
        CGFloat x = i % 4 * buttonWidth + 20;
        CGFloat y = i / 4 * buttonHeight + 100;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
        button.tag = i + RBWebsiteButtonTagOffset;
        [button setTitle:keys[i] forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(22, 22, 22) forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(websiteClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:button];
    }
}

- (void)createBaiduSearchView {
    CGFloat searchViewX = 40;
    CGFloat searchViewY = 20;
    CGRect frame = CGRectMake(searchViewX, searchViewY, UI_SCREEN_WIDTH - searchViewX * 2, RBBaiduSearchViewHeight);
    RBBaiduSearchView *searchView = [[RBBaiduSearchView alloc] initWithFrame:frame];
    [self.view addSubview:searchView];
}

- (void)websiteClicked:(UIButton *)sender {
    NSString *strURL = self.commonWebsites[sender.titleLabel.text];
    RBWebViewController *webViewController = [[RBWebViewController alloc] initWithStrURL:strURL];
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
