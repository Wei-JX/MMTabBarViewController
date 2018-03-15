//
// Created by LiMengyu on 16/1/17.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationBar (Awesome)

@property (nonatomic, readonly) UIView *overlay;

- (void)lt_clearBackgroundColor;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;

@end
