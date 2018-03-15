//
//  YppNetworkCache.m
//  AFNetworking
//
//  Created by zhz on 21/06/2017.
//

#import "YppNetworkCache.h"
#import "YppNetworkConfig.h"

void YppLog(NSString *format, ...) {
#ifdef DEBUG
    if (![YppNetworkConfig sharedConfig].debugLogEnabled) {
        return;
    }
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}

@implementation YppNetworkCache

/* 获取缓存 */
- (id)getDataFromCacheWithFileName:(NSString *)fileName {
    return [self getDataFromCacheWithFileName:fileName expirationTime:[self cacheCustomTime]];
}

- (id)getDataFromCacheWithFileName:(NSString *)fileName expirationTime:(double)expirationTime {
    NSString *time = [NSString stringWithContentsOfFile:[self cacheFileMetadataPath:fileName] encoding:NSUTF8StringEncoding error:nil];
    NSTimeInterval cacheTimeInterval = [time doubleValue];
    NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
    if (nowTimeInterval - cacheTimeInterval > expirationTime) {
        [self removeCacheData:fileName];
        return nil;
    }
    NSString *path = [self cacheFilePath:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        id cacheJSON = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)0 error:&error];
        return error != nil ? nil : cacheJSON;
    }
    return nil;
}

/* 缓存 */
- (void)cacheDataWithFileName:(NSString *)fileName responseData:(id)responseData {
    if (responseData == nil) {
        return;
    }
    @try {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL isScusse = [responseData writeToFile:[self cacheFilePath:fileName] atomically:YES];
            if (isScusse) {
                NSString *time = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
                [time writeToFile:[self cacheFileMetadataPath:fileName] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            } else {
                YppLog(@"%@--缓存网络请求数据失败", self);
            }
        });
    } @catch (NSException *exception) {
        YppLog(@"%@--缓存网络请求数据失败, reason = %@", self, exception.reason);
    }
}

/* 缓存数据路径 */
- (NSString *)cacheFilePath:(NSString *)fileName {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileDirectory = [documentDirectory stringByAppendingPathComponent:self.netCacheDir];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [fileDirectory stringByAppendingPathComponent:fileName];
    return filePath;
}

/* 缓存数据路径 */
- (NSString *)cacheFileMetadataPath:(NSString *)fileName {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileDirectory = [documentDirectory stringByAppendingPathComponent:self.netMetadataDir];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [fileDirectory stringByAppendingPathComponent:fileName];
    return filePath;
}

/* 清除缓存 */
- (void)removeCacheData:(NSString *)fileName {
    NSString *path = [self cacheFilePath:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
        [fileManager removeItemAtPath:path error:nil];
    }
    NSString *metadataPath = [self cacheFileMetadataPath:fileName];
    if ([fileManager fileExistsAtPath:metadataPath isDirectory:nil]) {
        [fileManager removeItemAtPath:metadataPath error:nil];
    }
}

/* 缓存时间 */
- (NSInteger)cacheCustomTime {
    return 60 * 60 * 24 * 7; // 一周
}

/* 清除所有缓存 */
- (void)clearAllNetWorkCache {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *netCacheDirectory = [documentDirectory stringByAppendingPathComponent:self.netCacheDir];
    NSString *netMetadataDirectory = [documentDirectory stringByAppendingPathComponent:self.netMetadataDir];
    if ([[NSFileManager defaultManager] fileExistsAtPath:netCacheDirectory]) {
        [[NSFileManager defaultManager] removeItemAtPath:netCacheDirectory error:nil];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:netMetadataDirectory]) {
        [[NSFileManager defaultManager] removeItemAtPath:netMetadataDirectory error:nil];
    }
}

- (NSString *)netMetadataDir {
    return [YppNetworkConfig sharedConfig].netMetadataDir ? : @"netMetadata";
}

- (NSString *)netCacheDir {
    return [YppNetworkConfig sharedConfig].netCacheDir ? : @"netCache";
}

@end
