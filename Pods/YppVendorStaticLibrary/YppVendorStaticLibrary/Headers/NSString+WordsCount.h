//
// Created by LiMengyu on 16/1/12.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WordsCount)
/**
@method
@description 计算字符数规则
一个汉字算一个字符
一个字母数字和两个字母都算一个字符
一个普通emoji算一个字符 复杂emoji(国旗..)算两个字符
@return 字符数
*/
- (NSUInteger)wordsCount;

/**
@method
@description 计算字符数规则
            一个汉字算两个字符
            一个字母数字算一个字符
            一个普通emoji算四个字符 复杂emoji(国旗..)算八个字符
@return 字符数
 */
- (NSUInteger)wordsCountForHans;
@end
