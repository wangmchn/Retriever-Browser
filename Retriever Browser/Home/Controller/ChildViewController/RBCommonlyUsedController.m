//
//  RBCommonlyUsedController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/27.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBCommonlyUsedController.h"
#import "RBBaiduSearchView.h"

@interface RBCommonlyUsedController ()

@end

@implementation RBCommonlyUsedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBaiduSearchView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)createBaiduSearchView {
    CGFloat searchViewX = 40;
    CGFloat searchViewY = 20;
    CGRect frame = CGRectMake(searchViewX, searchViewY, UI_SCREEN_WIDTH - searchViewX * 2, 35);
    RBBaiduSearchView *searchView = [[RBBaiduSearchView alloc] initWithFrame:frame];
    [self.view addSubview:searchView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
