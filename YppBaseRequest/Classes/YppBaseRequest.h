//
//  YppBaseRequest.h
//  Pods
//
//  Created by admin on 2018/3/14.
//

#import "BaseNetworkRequest.h"
@interface YppJavaResponse : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, readonly) BOOL isSuccess;

- (instancetype)initWithResponseJSONObject:(id)responseJSONObject;

@end

typedef NS_ENUM(NSUInteger, YppJavaRequestType) {
    YppJavaTraderRequest,  // 交易api
    YppJavaContentRequest, // 内容api
};


@interface YppBaseRequest : BaseNetworkRequest

@property (nonatomic, assign) YppJavaRequestType javaRequestType;

- (void)yppStartWithCompletionBlock:(void (^)(BOOL success, YppJavaResponse *response))completion
                            failure:(void (^)())failure;

@end
