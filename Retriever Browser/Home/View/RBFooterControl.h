//
//  RBFooterControl.h
//  Retriever Browser
//
//  Created by Mark on 15/11/28.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBFooterControl;

@protocol RBFooterDelegate <NSObject>

- (void)footerControl:(RBFooterControl *)footerControl didPressButtonAtIndex:(NSInteger)index;

@end

static CGFloat RBFooterControlHeight = 144;
@interface RBFooterControl : UIView
@property (nonatomic, weak) id<RBFooterDelegate> delegate;
@end
