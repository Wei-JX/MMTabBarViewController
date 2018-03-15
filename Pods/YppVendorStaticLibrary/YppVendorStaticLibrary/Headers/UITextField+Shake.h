//
//  UITextField+Shake.h
//  YppLife
//
//  Created by wywk on 15/12/9.
//  Copyright © 2015年 WYWK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Shake)

/**
 *  使用时只要调用此方法，加上一个长度(int)，就可以实现了字数限制,汉字不可以
 *
 *  @param length
 */
- (void)limitTextLength:(NSUInteger)length;
/**
 *  uitextField 抖动效果
 */
- (void)shake;

@end
