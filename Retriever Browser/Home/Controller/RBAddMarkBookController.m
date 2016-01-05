//
//  RBAddMarkBookController.m
//  Retriever Browser
//
//  Created by Martin on 16/1/5.
//  Copyright © 2016年 Wecan Studio. All rights reserved.
//

#import "RBAddMarkBookController.h"

@implementation RBAddMarkBookController

- (void)addBookMarkWithMarkName:(NSString *)name URL:(NSString *)url{
    NSDictionary *bm = [[NSDictionary alloc]init];
    [bm setValue:name forKey:url];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *plistPath;
    plistPath = [filePath stringByAppendingPathComponent:@"bookMark.plist"];
    [fm createFileAtPath:plistPath contents:nil attributes:nil];
    [bm writeToFile:plistPath atomically:YES];
}

- (void)cancel{
    
}

@end
