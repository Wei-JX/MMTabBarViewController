//
//  BaseBatchRequest.m
//  Pods
//
//  Created by zhz on 31/08/2017.
//
//

#import "BaseBatchRequest.h"
#import "BaseNetworkRequest.h"

@interface BaseBatchRequest()

@end
@implementation BaseBatchRequest

- (instancetype)initWithRequestArray:(NSArray<BaseNetworkRequest *> *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _shouldContinueFinish = YES;
        _successArray = [NSMutableArray array];
        _failArray = [NSMutableArray array];
        for (YTKRequest * req in _requestArray) {
            if (![req isKindOfClass:[BaseNetworkRequest class]]) {
                NSAssert(NO, @"Error, request item must be YTKRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_successArray.count > 0 || _failArray.count > 0) {
        NSLog(@"Error! Batch request has already started.");
        return;
    }
    [_successArray removeAllObjects];
    [_failArray removeAllObjects];
    [[YTKBatchRequestAgent sharedAgent] addBatchRequest:self];
    
    for (YTKRequest * req in _requestArray) {
        req.delegate = self;
        [req clearCompletionBlock];
        [req start];
    }
}

- (void)stop {
    [self clearRequest];
}

- (void)startWithCompletionBlockWithCompletion:(nullable void (^)(BaseBatchRequest * _Nullable batchRequest))completion {
    self.completionBlock = completion;
    [self start];
}

- (void)clearCompletionBlock {
    self.completionBlock = nil;
}

- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate
- (void)requestFinished:(YTKRequest *)request {
    if (self.singleCompletionBlock) {
        self.singleCompletionBlock(request);
    }
    [_successArray addObject:request];
    [self handleCallBack:YES];
}

- (void)requestFailed:(YTKRequest *)request {
    if (self.singleCompletionBlock) {
        self.singleCompletionBlock(request);
    }
    [_failArray addObject:request];
    //1. 失败后直接返回, 剩下的也不请求了
    if (!self.shouldContinueFinish) {
        if (_completionBlock) {
            _completionBlock(self);
        }
        [self clearRequest];
        return;
    }
    //2. 其中一个失败了, 没关系, 继续请求, 直到所有的都完成
    [self handleCallBack:NO];
}

- (void)handleCallBack:(BOOL)isSuccess {
    if (_failArray.count + _successArray.count == _requestArray.count) {
        if (isSuccess) {
            _isAllRequestsSuccess = YES;
        }
        if (_completionBlock) {
            _completionBlock(self);
        }
        [self clearCompletionBlock];
        [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
    }
}

- (void)clearRequest {
    for (YTKRequest * req in _requestArray) {
        [req stop];
    }
    [_successArray removeAllObjects];
    [_failArray removeAllObjects];
    [self clearCompletionBlock];
}

@end
