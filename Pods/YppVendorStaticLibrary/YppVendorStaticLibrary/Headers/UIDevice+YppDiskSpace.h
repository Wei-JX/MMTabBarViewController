//
// Created by LiMengyu on 16/9/1.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (YppDiskSpace)
/// Total disk space in byte. (-1 when error occurs)
@property(nonatomic, readonly) int64_t diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property(nonatomic, readonly) int64_t diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property(nonatomic, readonly) int64_t diskSpaceUsed;
@end