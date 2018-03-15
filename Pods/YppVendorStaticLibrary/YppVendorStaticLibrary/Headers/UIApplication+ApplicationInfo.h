//
// Created by LiMengyu on 16/3/31.
// Copyright (c) 2016 WYWK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIApplication (ApplicationInfo)
- (NSString *)ypp_version;

- (NSInteger)ypp_build;

- (NSString *)ypp_identifier;

- (NSString *)ypp_currentLanguage;

- (NSString *)ypp_deviceModel;//x86_64 etc.
@end