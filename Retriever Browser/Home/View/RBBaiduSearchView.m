//
//  RBBaiduSearchView.m
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBBaiduSearchView.h"

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
    self.searchBar.placeholder = @"请输入网址";
    [self addSubview:self.searchBar];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 40, 0, 50));
    }];
}

@end
