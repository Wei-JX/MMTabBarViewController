//
//  YppNetworkConfig.m
//  AFNetworking
//
//  Created by zhz on 21/06/2017.
//

#import "YppNetworkConfig.h"
#import "YTKNetworkConfig.h"
#import "YppNetworkCache.h"

@interface YppNetworkConfig()

@end;
@implementation YppNetworkConfig

+ (instancetype)sharedConfig {
    static YppNetworkConfig *networkConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkConfig = [[self alloc] init];
    });
    return networkConfig;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkCache = [[YppNetworkCache alloc] init];
    }
    return self;
}

#pragma mark - Public Method

#pragma mark - getter && setter
- (void)setBaseUrl:(NSString *)baseUrl {
    if (![_baseUrl isEqualToString:baseUrl] ) {
        _baseUrl = baseUrl;
        [[YTKNetworkConfig sharedConfig] setBaseUrl:baseUrl];
    }
}

- (void)setDebugLogEnabled:(BOOL)debugLogEnabled {
    if (_debugLogEnabled != debugLogEnabled) {
        _debugLogEnabled = debugLogEnabled;
        [[YTKNetworkConfig sharedConfig] setDebugLogEnabled:debugLogEnabled];
    }
}
@end

