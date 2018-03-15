//
// Created by LiMengyu on 15/11/17.
// Copyright (c) 2015 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YppTimeFormat)
- (NSString *)convertToCompeteOrderFormat;

- (BOOL)isInThreeMinutes:(NSString *)lastDateString;

- (NSString *)convertToPublicOrderBeginTimeFormat;
@end