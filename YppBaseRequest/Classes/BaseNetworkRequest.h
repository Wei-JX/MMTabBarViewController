//
//  BaseNetworkRequest.h
//  AFNetworking
//
//  Created by zhz on 21/06/2017.
//

#import <YTKNetwork/YTKNetwork.h>

typedef NS_ENUM(NSInteger, BaseNetWorkCache) {
    BaseNetWorkCacheOnlyUseNet,          // 不使用缓存, 仅使用网络请求
    BaseNetWorkCacheFirstCacheThanNet,   // 先使用缓存再使用网络请求
    BaseNetWorkCacheFirstNetThanCacheWhenError,// 优先使用网络请求, 当网络请求失败再使用缓存
    BaseNetWorkCacheOnlyCacheThanNet,    // 仅使用缓存, 但是每次都会网络请求(留作下次使用)
    BaseNetWorkCacheOnlyUseCache,        // 只是用缓存, 缓存过期再使用网络请求
};

@interface BaseNetworkRequest : YTKRequest

/* 请求参数 */
@property (nonatomic, strong) NSDictionary              *parameters;

/* 请求方法 */
@property (nonatomic, strong) NSString                  *methodName;

/* 请求方式: POST, GET, 默认POST */
@property (nonatomic, assign) YTKRequestMethod          requestMethod;

/* 缓存类型: 默认仅使用网络请求 */
@property (nonatomic, assign) BaseNetWorkCache   netWorkCacheType;

/* 缓存来源 */
@property (nonatomic, readonly, assign) BOOL isDataFromCache;

- (void)cacheDataFromResponse:(NSData *)responseData;

@end
