//
// Created by LiMengyu on 15/8/26.
// Copyright (c) 2015 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Compress)
- (UIImage *)compressedImage;
- (CGFloat)compressionQuality;
- (NSData *)yppCompressImageIsOrign:(BOOL)isOrign;
- (NSData *)compressedData;
- (NSData *)compressedData:(CGFloat)compressionQuality;
- (UIImage *)reSizeImagetoSize:(CGSize)reSize;
- (NSData *)yppCompressImage;
@end