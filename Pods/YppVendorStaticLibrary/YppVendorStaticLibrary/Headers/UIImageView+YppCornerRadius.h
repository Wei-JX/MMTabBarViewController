//
// Created by LiMengyu on 16/3/24.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView (YppCornerRadius)
@property(nonatomic, assign) CGFloat yppCornerRadius;
@end

@interface HJImageObserver : NSObject

@property(nonatomic, assign) UIImageView *originImageView;
@property(nonatomic, strong) UIImage *originImage;
@property(nonatomic, assign) CGFloat cornerRadius;

- (instancetype)initWithImageView:(UIImageView *)imageView;

@end