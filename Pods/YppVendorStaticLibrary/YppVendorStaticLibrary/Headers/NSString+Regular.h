//
// Created by LiMengyu on 15/12/14.
// Copyright (c) 2015 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

- (BOOL)isAlphabet;

/// a-z A-Z 0-9 _
- (BOOL)isPassword;

/// 以1开头的十一位数字
- (BOOL)isMobileNumber;

/// 身份证号码
- (BOOL)isIndentityCard;

@end
