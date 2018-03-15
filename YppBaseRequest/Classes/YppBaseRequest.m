//
//  YppBaseRequest.m
//  Pods
//
//  Created by admin on 2018/3/14.
//

#import "YppBaseRequest.h"
#import "YTKNetworkPrivate.h"
#import "YppBaseRequest.h"
//#import "YppUserCenter.h"
//#import "YPPSynchronizeSerial.h"
//#import "YppNetMacros.h"
//#import "NSDictionary+YppJSONToString.h"
//#import "YppNetworkService.h"
#import "YppNetworkConfig.h"
#import "YppNetworkCache.h"

@implementation YppJavaResponse

- (instancetype)initWithResponseJSONObject:(id)responseJSONObject {
    if (self = [super init]) {
        self.code = responseJSONObject[@"code"];
        self.success = [responseJSONObject[@"success"] boolValue];
        self.data = responseJSONObject[@"result"];
        self.message = responseJSONObject[@"msg"];
    }
    return self;
}

- (BOOL)isSuccess {
    return self.success && [self.code isEqualToString:@"8000"];
}

@end

@interface YppBaseRequest()

@property (nonatomic, strong) NSString *javaUrl;

@property (nonatomic, strong) NSDictionary *headerDict;

@end

@implementation YppBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _javaRequestType = YppJavaTraderRequest;
    }
    return self;
}

- (void)requestCompleteFilter {
    [super requestCompleteFilter];
    if ([[self responseJSONObject][@"code"] isEqualToString:@"8000"]) {
        // 缓存
        [self cacheDataFromResponse:[self responseData]];
    }
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSDictionary *dict = [[YppNetworkConfig sharedConfig].delegate requestHeaderField];
    self.headerDict = dict;
    return dict;
}

- (NSString *)baseUrl { //todo
    return @"";
}

/* 构建请求的对象 */
- (NSURLRequest *)buildCustomUrlRequest {
    NSString *urlString = [self buildRequestUrl];
    self.javaUrl = urlString;
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    id param = self.parameters;
    
    NSString *body = @"";
    NSString *requsetMethod = @"GET";
    switch (self.requestMethod) {
            case YTKRequestMethodGET: {
                requsetMethod = @"GET";
            }
            break;
            case YTKRequestMethodPOST: {
                if (param && ![param isKindOfClass:[NSDictionary class]]) {
                    NSAssert(NO, @"POST 参数使用字典");
                    return nil;
                }
              //  body = [param yppJSONToString];
                requsetMethod = @"POST";
            }
            break;
        default:
            NSAssert(NO, @"不支持的请求类型");
            break;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.allHTTPHeaderFields = self.requestHeaderFieldValueDictionary;
    request.HTTPMethod = requsetMethod;
    
    if (body.length > 0) {
        NSError *error;
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            YTKLog(@"---%@", error);
        }
        request.HTTPBody = bodyData;
    }
    return request;
}

/* 构建请求的URL */
- (NSString *)buildRequestUrl {
    NSString *detailUrl = [self requestUrl];
    NSURL *temp = [NSURL URLWithString:detailUrl];
    // 如果requestUrl 是完整的url, 直接返回
    if (temp && temp.host && temp.scheme) {
        return detailUrl;
    }
    
    // 过滤URL
    NSArray *filters = [[YTKNetworkConfig sharedConfig] urlFilters];
    for (id<YTKUrlFilterProtocol> f in filters) {
        detailUrl = [f filterUrl:detailUrl withRequest:self];
    }
    
    NSString *tempBaseUrl = [self baseUrl];
    
    // 是否使用cdn
    NSString *baseUrl;
    if ([self useCDN]) {
        if ([self cdnUrl].length > 0) {
            baseUrl = [self cdnUrl];
        } else {
            baseUrl = [[YTKNetworkConfig sharedConfig] cdnUrl];
        }
    } else {
        if (tempBaseUrl.length > 0) {
            baseUrl = tempBaseUrl;
        } else {
            baseUrl = [[YTKNetworkConfig sharedConfig] baseUrl];
        }
    }
    // URL 拼接处理
    NSURL *url = [NSURL URLWithString:baseUrl];
    if (baseUrl.length > 0 && ![baseUrl hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    return [url.absoluteString stringByAppendingPathComponent:detailUrl];
}

/* 缓存名字 */
- (NSString *)cacheFileName {
    NSString *body = @"";
    if (self.parameters.count > 0) {
        //body = [self.parameters yppJSONToString];
        if (body.length == 0) {
            body = @"";
        }
    }
    NSString *fileName = [NSString stringWithFormat:@"%@__%@", NSStringFromClass([self class])?:@"", body];
    NSString *cacheFileName = [YTKNetworkUtils md5StringFromString:fileName];
    return cacheFileName;
}

- (NSString *)debugDescription {
    NSString *parameters; //[self.parameters yppJSONToString];
    NSString *headers;// [self.headerDict yppJSONToString];
    NSString *requestMethod = self.requestMethod == YTKRequestMethodPOST ? @"POST" : @"GET";
    return [NSString stringWithFormat:@"\nurl: %@\nrequestMethod: %@\nparameters: %@\nheader: %@\n", self.javaUrl, requestMethod, parameters, headers];
}

#pragma mark -
- (void)yppStartWithCompletionBlock:(void (^)(BOOL success, YppJavaResponse *response))completion failure:(void (^)(void))failure {
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        YppJavaResponse *response = [[YppJavaResponse alloc] initWithResponseJSONObject:request.responseJSONObject];
        if (completion) {
            completion(response.isSuccess, response);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure();
        }
    }];
}

@end
