//
//  RBWebHandlerController.h
//  Retriever Browser
//
//  Created by Mark on 15/12/3.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface RBWebHandlerController : UIViewController
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, assign) BOOL showCarousel;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

@end
