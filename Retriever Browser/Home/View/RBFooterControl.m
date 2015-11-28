//
//  RBFooterControl.m
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBFooterControl.h"

@implementation RBFooterControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createDividingLine];
        [self createButtons];
    }
    return self;
}

- (void)createDividingLine {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 0.5)];
    line.backgroundColor = RGBCOLOR(191, 191, 191);
    [self addSubview:line];
}

- (void)createButtons {
    const CGFloat buttonWidth = UI_SCREEN_WIDTH / 4;
    for (int i = 0; i < 4; i++) {
        if (i == 2) {
            continue;
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, UI_TABBAR_HEIGHT)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_footer_%d", i]];
        [button setImage:image forState:UIControlStateNormal];
        [self addSubview:button];
    }
}

@end
