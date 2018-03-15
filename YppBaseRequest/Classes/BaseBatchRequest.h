//
//  BaseBatchRequest.h
//  Pods
//
//  Created by zhz on 31/08/2017.
//
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class BaseNetworkRequest;
@interface BaseBatchRequest : NSObject

/// 当其中一个接口失败, 是否继续其他未完成的请求: 默认YES: 继续请求, NO: 不再请求
@property (nonatomic, assign) BOOL shouldContinueFinish;

/// 网络请求数组
@property (nonatomic, strong, readonly) NSArray<BaseNetworkRequest *> *requestArray;

/// 成功的数组
@property (nonatomic, copy, readonly) NSMutableArray<BaseNetworkRequest *> *successArray;
/// 失败的数组
@property (nonatomic, copy, readonly) NSMutableArray<BaseNetworkRequest *> *failArray;

/// 最后一个失败的请求
@property (nonatomic, copy, readonly) BaseNetworkRequest *lastFailRequest;

/// 所有网络请求成功
@property (nonatomic, assign, readonly) BOOL isAllRequestsSuccess;

/// 所有网络请求 完成后的回调
@property (nonatomic, copy, nullable) void (^completionBlock)(__kindof BaseBatchRequest *);

/// 单次请求的回调
@property (nonatomic, copy, nullable) void (^singleCompletionBlock)(__kindof BaseNetworkRequest *);

- (instancetype)initWithRequestArray:(NSArray<BaseNetworkRequest *> *)requestArray;

- (void)startWithCompletionBlockWithCompletion:(nullable void (^)(BaseBatchRequest * _Nullable batchRequest))completion;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
