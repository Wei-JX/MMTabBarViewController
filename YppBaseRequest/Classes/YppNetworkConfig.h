//
//  YppNetworkConfig.h
//  AFNetworking
//
//  Created by zhz on 21/06/2017.
//

#import <Foundation/Foundation.h>

@class YppNetworkCache;
@class YTKRequest;

@protocol YppNetworkConfigProtocol <NSObject>

@optional
+ (NSDictionary *)requestArgumentWithBody:(NSDictionary *)parameters methodName:(NSString *)methodName;

+ (NSDictionary *)requestHeaderField;
@end

@interface YppNetworkConfig : NSObject

///  创建cofig单例
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)sharedConfig;

/// delegate
@property (nonatomic, assign) id<YppNetworkConfigProtocol> delegate;


///  网络请求的 baseUrl
@property (nonatomic, strong) NSString *baseUrl;

///  是否网络请求调试状态, 默认NO
@property (nonatomic) BOOL debugLogEnabled;

/*-----------------------------网络缓存----------------------------------*/
/// 缓存实体文件夹名: 返回数据, 非必填
@property (nonatomic, strong) NSString *netCacheDir;
/// 缓存配置文件夹名: time等, 非必填
@property (nonatomic, strong) NSString *netMetadataDir;
/// 网络缓存工具类
@property (nonatomic, strong) YppNetworkCache *networkCache;

@end
