//
// Created by LiMengyu on 16/7/25.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (YppString)

- (BOOL)isEqualToString:(NSString *)other;

@property(nonatomic, readonly) NSUInteger length;
@end