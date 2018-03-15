//
// Created by LiMengyu on 15/8/27.
// Copyright (c) 2015 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Popup)

@property (nonatomic) UIViewController *popupViewController;
@property (nonatomic) BOOL useBlurForPopup;
@property (nonatomic) CGPoint popupViewOffset;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion needPlus:(BOOL)needPlus;
- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
- (void)setUseBlurForPopup:(BOOL)useBlurForPopup;
- (BOOL)useBlurForPopup;

@end