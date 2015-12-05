//
//  UIImage+viewToImage.m
//  Retriever Browser
//
//  Created by Mark on 15/12/3.
//  Copyright © 2015年 Wecan Studio. All rights reserved.
//

#import "UIImage+viewToImage.h"

@implementation UIImage (viewToImage)
+ (UIImage*)createImageFromView:(UIView*)view {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), NO, scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
