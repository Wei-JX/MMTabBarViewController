//
// Created by LiMengyu on 15/8/27.
// Copyright (c) 2015 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Blur)
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;

+ (UIImage *)accelerateBlurWithImage:(UIImage *)image;
@end