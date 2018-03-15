//
//  YppNetworkCache.h
//  AFNetworking
//
//  Created by zhz on 21/06/2017.
//

#import <Foundation/Foundation.h>

@interface YppNetworkCache : NSObject

/* 清除所有网络缓存数据
 */
- (void)clearAllNetWorkCache;

/* 获取缓存数据
 * cachePath        : 缓存路径
 */
- (id)getDataFromCacheWithFileName:(NSString *)fileName;

/* 缓存网络数据
 * cachePath        : 缓存路径
 * responseData     : 缓存数据
 */
- (void)cacheDataWithFileName:(NSString *)fileName responseData:(id)responseData;

@end
