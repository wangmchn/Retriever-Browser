//
//  RBFooterControl.m
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBFooterControl.h"
#import "RBWebViewController.h"

static NSInteger const RBFooterButtonTagOffset = 6250;
@implementation RBFooterControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createDividingLine];
        [self createButtons];
        [self createBottomView];
    }
    return self;
}

- (void)createDividingLine {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 0.5)];
    line.backgroundColor = RGBCOLOR(191, 191, 191);
    [self addSubview:line];
}

- (void)createBottomView {
    
}

- (void)createButtons {
    const CGFloat buttonWidth = UI_SCREEN_WIDTH / 5;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, UI_TABBAR_HEIGHT)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_footer_%d", i]];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = RBFooterButtonTagOffset + i;
        
        [self addSubview:button];
    }
}

- (void)buttonClicked:(UIButton *)sender {
    
    UINavigationController *nav = (UINavigationController *)[self.viewController.childViewControllers lastObject];
    UIViewController *viewController = [nav.viewControllers lastObject];
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(footerControl:didPressButtonAtIndex:)]) {
        [self.delegate footerControl:self didPressButtonAtIndex:sender.tag - RBFooterButtonTagOffset];
    }
    
    if (sender.tag == RBFooterButtonTagOffset + 4) { // 书签
        
        return;
    }
    
    if (![viewController isKindOfClass:[RBWebViewController class]]) { return; }
    
    RBWebViewController *webViewController = (RBWebViewController *)viewController;
    if (sender.tag == RBFooterButtonTagOffset + 0) {
        if (webViewController.webView.canGoBack) {
            [webViewController.webView goBack];
            return;
        }
        [nav popViewControllerAnimated:YES];
    }
    
    if (sender.tag == RBFooterButtonTagOffset + 1) {
        if (webViewController.webView.canGoForward) {
            [webViewController.webView goForward];
            return;
        }
    }
}

@end
