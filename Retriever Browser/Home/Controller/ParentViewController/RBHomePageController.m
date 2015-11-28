//
//  RBHomePageController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/27.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBHomePageController.h"
#import "RBCommonlyUsedController.h"
#import "RBWebAddressController.h"
#import "RBSearchHeaderView.h"

@interface RBHomePageController ()
@property (nonatomic, strong) RBSearchHeaderView *headerView;
@end

static CGFloat const RBHomePageViewOriginY   = 75;
@implementation RBHomePageController

- (instancetype)init {
    NSArray *childViewControllerClasses = @[[RBCommonlyUsedController class], [RBWebAddressController class]];
    NSArray *titles = @[@"常用", @"网址"];
    self = [self initWithViewControllerClasses:childViewControllerClasses andTheirTitles:titles];
    if (self) {
        self.menuBGColor = [UIColor clearColor];
        self.menuItemWidth = 60;
        self.menuViewStyle = WMMenuViewStyleDefault;
        self.titleSizeSelected = 15;
        self.viewFrame = CGRectMake(0, RBHomePageViewOriginY, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - RBHomePageViewOriginY - UI_TABBAR_HEIGHT);
        self.titleColorSelected = RGBCOLOR(255, 102, 51);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)createHeaderView {
    self.headerView = [[RBSearchHeaderView alloc] init];
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.top.equalTo(@40);
        make.height.equalTo(@30);
    }];
}

@end
