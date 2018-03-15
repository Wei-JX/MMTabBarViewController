//
//  YppSwitch.h
//  YppLife
//
//  Created by wywk on 16/1/20.
//  Copyright © 2016年 WYWK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YppSwitch : UIControl

typedef void(^switchChangedBlock)(BOOL on);

@property(nonatomic, assign, getter = isOn) BOOL on;
@property(nonatomic, strong) UIColor *onTintColor;
@property(nonatomic, strong) UIColor *tintColor;
@property(nonatomic, strong) UIColor *thumbTintColor;
@property(nonatomic, assign) NSInteger switchKnobSize;
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) NSString *onText;
@property(nonatomic, strong) NSString *offText;
@property(nonatomic, copy) switchChangedBlock switchBlock;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

- (id)initWithFrame:(CGRect)frame onColor:(UIColor *)onColor offColor:(UIColor *)offColor font:(UIFont *)font ballSize:(NSInteger)ballSize;

@end
