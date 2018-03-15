//
//  BaseNetworkRequest.m
//  AFNetworking
//
//  Created by zhz on 21/06/2017.
//

#import "BaseNetworkRequest.h"
#import "YppNetworkConfig.h"
#import "YppNetworkCache.h"

@interface BaseNetworkRequest()

@property (nonatomic, assign) BOOL           needCacheData;
@property (nonatomic, assign) BOOL           needNetRequest;

@property (nonatomic, strong) id responseJSONObject;
@end
@implementation BaseNetworkRequest

- (instancetype)init {
    if (self = [super init]) {
        self.requestMethod = YTKRequestMethodPOST;
    }
    return self;
}

- (void)requestCompleteFilter {
    _isDataFromCache = NO;
    if (self.netWorkCacheType == BaseNetWorkCacheOnlyCacheThanNet
        && ([self getDataFromCache]  && self.successCompletionBlock)) {
        _isDataFromCache = YES;
        self.successCompletionBlock = nil;
    } else {
        [super requestCompleteFilter];
    }
}

- (void)requestFailedFilter {
    _isDataFromCache = NO;
    if (self.netWorkCacheType == BaseNetWorkCacheFirstNetThanCacheWhenError && !self.needNetRequest) {
        [self requestCompleteFilter];
        if (self.successCompletionBlock) {
            _isDataFromCache = YES;
            self.successCompletionBlock(self);
        }
        self.failureCompletionBlock = nil;
    } else {
        [super requestFailedFilter];
    }
}

- (void)start {
    switch (self.netWorkCacheType) {
        case BaseNetWorkCacheOnlyUseNet:
        case BaseNetWorkCacheFirstNetThanCacheWhenError:
            [super start];
            break;
        case BaseNetWorkCacheFirstCacheThanNet:
            if (!self.needNetRequest) {
                if (self.successCompletionBlock) {
                    _isDataFromCache = YES;
                    self.successCompletionBlock(self);
                }
            }
            [super start];
            break;
        case BaseNetWorkCacheOnlyUseCache:
            if (self.needNetRequest) {
                [super start];
            } else {
                if (self.successCompletionBlock) {
                    _isDataFromCache = YES;
                    self.successCompletionBlock(self);
                }
            }
            break;
        case BaseNetWorkCacheOnlyCacheThanNet:
            if (!self.needNetRequest && self.successCompletionBlock) {
                _isDataFromCache = YES;
                self.successCompletionBlock(self);
            }
            [super start];
            break;
    }
}

- (void)stop {
    if (self.netWorkCacheType == BaseNetWorkCacheOnlyCacheThanNet
        && ([self getDataFromCache] && self.successCompletionBlock)) {
        return;
    }
    [super stop];

}

#pragma mark - 缓存处理
/* 是否需要网络请求 */
- (BOOL)needNetRequest {
    switch (self.netWorkCacheType) {
        case BaseNetWorkCacheOnlyUseNet:
            return YES;
        case BaseNetWorkCacheOnlyCacheThanNet:
        case BaseNetWorkCacheFirstCacheThanNet:
        case BaseNetWorkCacheOnlyUseCache:
        case BaseNetWorkCacheFirstNetThanCacheWhenError:
            self.responseJSONObject = [self getDataFromCache];
            return self.responseJSONObject == nil;
    }
}

/* 请求的数据是否需要缓存 */
- (BOOL)needCacheData {
    return self.netWorkCacheType != BaseNetWorkCacheOnlyUseNet;
}

/* 缓存数据 */
- (void)cacheDataFromResponse:(NSData *)responseData {
    if (![self needCacheData]) {
        return;
    }
    [[YppNetworkConfig sharedConfig].networkCache cacheDataWithFileName:[self cacheFileName] responseData:responseData];
}

/* 获取缓存数据 */
- (id)getDataFromCache {
    switch (self.responseSerializerType) {
        case YTKResponseSerializerTypeXMLParser:
        case YTKResponseSerializerTypeHTTP:
            NSLog(@"解析类型错误");
            return nil;
        case YTKResponseSerializerTypeJSON: {
            return [[YppNetworkConfig sharedConfig].networkCache getDataFromCacheWithFileName:[self cacheFileName]];
        }
    }
}

/* 缓存名字 */
- (NSString *)cacheFileName {
    // 子类重写
    return @"";
}

@end
