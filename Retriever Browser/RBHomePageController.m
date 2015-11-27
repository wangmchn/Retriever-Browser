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

@interface RBHomePageController ()

@end

static CGFloat const RBHomePageToolBarHeight = 44.0;
@implementation RBHomePageController

- (instancetype)init {
    NSArray *childViewControllerClasses = @[[RBCommonlyUsedController class], [RBWebAddressController class]];
    NSArray *titles = @[@"常用", @"网址"];
    self = [self initWithViewControllerClasses:childViewControllerClasses andTheirTitles:titles];
    if (self) {
        
        self.viewFrame = CGRectMake(0, UI_NAVIGATIONBAR_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - UI_NAVIGATIONBAR_HEIGHT - RBHomePageToolBarHeight);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <WMMenuViewDelegate>
//- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index {
//    
//}
//
//- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
//    
//}

@end
