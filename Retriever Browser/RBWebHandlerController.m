//
//  RBWebHandlerController.m
//  Retriever Browser
//
//  Created by Mark on 15/12/3.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "RBWebHandlerController.h"
#import "UIImage+viewToImage.h"
#import "RBFooterControl.h"
#import "RBHomePageController.h"
#import "RBNavigationController.h"

@interface RBWebHandlerController () <iCarouselDataSource, iCarouselDelegate, RBFooterDelegate>
@property (nonatomic, strong) RBFooterControl *footer;
@property (nonatomic, assign) NSInteger viewCount;
@end

@implementation RBWebHandlerController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = RGBCOLOR(33, 33, 33);
    
    [self addChildViewController:self.rootViewController];
    [self.rootViewController didMoveToParentViewController:self];
    
    //create carousel
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.bounces = NO;
    _carousel.type = iCarouselTypeLinear;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    //add carousel to view
    [self.view addSubview:_carousel];
    [self.view addSubview:self.rootViewController.view];
    self.currentViewController = self.rootViewController;
    [self createFooterControl];
    
    self.showCarousel = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter 
- (void)setShowCarousel:(BOOL)showCarousel {
    _showCarousel = showCarousel;
    self.carousel.hidden = !showCarousel;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    if (_showCarousel) {
        self.viewCount = 0;
        return self.childViewControllers.count;
    }
    return 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    CGRect viewFrame = CGRectMake(0, 0, self.view.width * 0.8, self.view.height * 0.8);
    self.viewCount++;
    if (self.viewCount > self.childViewControllers.count) {
        viewFrame = CGRectZero;
    }
    if (!view) {
        view = [[UIImageView alloc] initWithFrame:viewFrame];
    }
    UIViewController *vc = self.childViewControllers[index];
    ((UIImageView *)view).image = [UIImage createImageFromView:vc.view];
    return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    //customize carousel display
    switch (option) {
        case iCarouselOptionWrap: {
            //normally you would hard-code this to YES or NO
            return value;
        }
        case iCarouselOptionSpacing: {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax: {
            if (carousel.type == iCarouselTypeCustom) {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default: {
            return value;
        }
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    UIImageView *view = (UIImageView *)[carousel itemViewAtIndex:index];
    UIImageView *fakeImageView = [[UIImageView alloc] initWithFrame:view.frame];
    fakeImageView.image = view.image;
    fakeImageView.center = self.view.center;
    [self.view addSubview:fakeImageView];
    [self.view bringSubviewToFront:self.footer];
    
    [UIView animateWithDuration:0.3 animations:^{
        fakeImageView.frame = self.view.bounds;
        _carousel.hidden = YES;
    } completion:^(BOOL finished) {
        UIViewController *vc = self.childViewControllers[index];
        self.currentViewController = vc;
        [self.view addSubview:vc.view];
        [self.view bringSubviewToFront:self.footer];
        [fakeImageView removeFromSuperview];
        self.showCarousel = NO;
    }];
}

#pragma mark - Footer
- (void)createFooterControl {
    self.footer = [[RBFooterControl alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - UI_TABBAR_HEIGHT, UI_SCREEN_WIDTH, UI_TABBAR_HEIGHT)];
    self.footer.delegate = self;
    [self.view addSubview:self.footer];
}

- (void)footerControl:(RBFooterControl *)footerControl didPressButtonAtIndex:(NSInteger)index {
    if (index == 2) {
        [self addNewWebViewController];
    }
    
    if (index == 3) {
        [self handleChildControllers];
    }
}

- (void)handleChildControllers {
    self.showCarousel = YES;
    [self.carousel reloadData];
    
    [self.currentViewController.view removeFromSuperview];
    NSInteger index = [self.childViewControllers indexOfObject:self.currentViewController];
    [self.carousel scrollToItemAtIndex:index animated:NO];
}

- (void)addNewWebViewController {
    RBHomePageController *pageController = [[RBHomePageController alloc] init];
    RBNavigationController *nav = [[RBNavigationController alloc] initWithRootViewController:pageController];
    [self addChildViewController:nav];
    
    CATransition *moveIn = [CATransition animation];
    moveIn.type = @"cube";
    moveIn.subtype = @"fromRight";
    moveIn.duration = 0.5;
    [self.view.layer addAnimation:moveIn forKey:@"ChildControllerMoveIn"];
    
    [self.currentViewController.view removeFromSuperview];
    [self.view addSubview:nav.view];
    
    [self.view bringSubviewToFront:self.footer];
    
    self.currentViewController = nav;
}

@end
