//
//  UIImage+UIImageEffects.h
//  YppLife
//
//  Created by ypp_ios001 on 16/5/18.
//  Copyright © 2016年 WYWK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageEffects)
- (UIImage*)imageByApplyingLightEffectToImage;
- (UIImage*)imageByApplyingExtraLightEffectToImage;
- (UIImage*)imageByApplyingDarkEffectToImage;
- (UIImage*)imageByApplyingTintEffectWithColor:(UIColor *)tintColor;

//| ----------------------------------------------------------------------------
//! Applies a blur, tint color, and saturation adjustment to @a inputImage,
//! optionally within the area specified by @a maskImage.
//!
//! @param  inputImage
//!         The source image.  A modified copy of this image will be returned.
//! @param  blurRadius
//!         The radius of the blur in points.
//! @param  tintColor
//!         An optional UIColor object that is uniformly blended with the
//!         result of the blur and saturation operations.  The alpha channel
//!         of this color determines how strong the tint is.
//! @param  saturationDeltaFactor
//!         A value of 1.0 produces no change in the resulting image.  Values
//!         less than 1.0 will desaturation the resulting image while values
//!         greater than 1.0 will have the opposite effect.
//! @param  maskImage
//!         If specified, @a inputImage is only modified in the area(s) defined
//!         by this mask.  This must be an image mask or it must meet the
//!         requirements of the mask parameter of CGContextClipToMask.
- (UIImage*)imageByApplyingBlurToImageWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
