//
// Created by LiMengyu on 16/6/16.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (YppBlock)
typedef void (^YppGestureActionBlock)(UIGestureRecognizer *gestureRecognizer);

- (void)ypp_addTapActionWithBlock:(YppGestureActionBlock)block;

- (void)ypp_addLongPressActionWithBlock:(YppGestureActionBlock)block;
@end