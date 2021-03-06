//
//  RBNavigationController.m
//  Retriever Browser
//
//  Created by Mark on 15/11/27.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBNavigationController.h"
#import "RBFooterControl.h"

@interface RBNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation RBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)createFooterControl {
    RBFooterControl *footer = [[RBFooterControl alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - UI_TABBAR_HEIGHT, UI_SCREEN_WIDTH, UI_TABBAR_HEIGHT)];
    [self.view addSubview:footer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

@end
