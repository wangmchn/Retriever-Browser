//
//  RBAddMarkBookController.h
//  Retriever Browser
//
//  Created by Martin on 16/1/5.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBAddMarkBookController : UIView

- (void) addBookMarkWithMarkName:(NSString *)name URL:(NSString *)url;
- (void) cancel;

@end
