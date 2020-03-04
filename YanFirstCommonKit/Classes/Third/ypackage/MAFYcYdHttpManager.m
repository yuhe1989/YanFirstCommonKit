//
//  MAFYcYdHttpManager.m
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdHttpManager.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"
#import "MAFMySecurity.h"

#define REQUESTADDRESS_R @"http://12316yun.net/AFMIS/"
#define version6 @"?v=6"

@interface MAFYcYdHttpManager ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation MAFYcYdHttpManager

- (instancetype)initWithCommonUrl:(NSString *)commonUrl
                         argument:(nullable id)requestArgument {
    self = [super init];
    if (self) {
        _requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"app/common/v1.2/"] stringByAppendingString:commonUrl];
        _requestUrl = [_requestUrl stringByAppendingString:version6];
        _requestArgument = [MAFMySecurity dictToStringEncryption:requestArgument];;
    }
    return self;
}

- (instancetype)initWithRequestAnimalUrl:(NSString *)commonUrl argument:(nullable id)requestArgument{
    self = [super init];
    if (self) {
        _requestUrl = [REQUESTADDRESS_R stringByAppendingString:commonUrl];
        _requestUrl = [_requestUrl stringByAppendingString:version6];
        _requestArgument = [MAFMySecurity dictToStringEncryption:requestArgument];;
    }
    return self;
}


- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                          argument:(nullable id)requestArgument {
    self = [super init];
    if (self) {
        _requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"farmcheck/"] stringByAppendingString:requestUrl];
        _requestUrl = [_requestUrl stringByAppendingString:version6];
        _requestArgument = [MAFMySecurity dictToStringEncryption:requestArgument];;
    }
    return self;
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                       arrArgument:(nullable id)requestArgument {
    self = [super init];
    if (self) {
        _requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"farmcheck/"] stringByAppendingString:requestUrl];
        _requestUrl = [_requestUrl stringByAppendingString:version6];
        _requestArgument = [MAFMySecurity dictWithArrToStringNoSpaceEncryption:requestArgument];
    }
    return self;
}

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                       DicArgument:(id)requestArgument {
    self = [super init];
    if (self) {
        _requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"farmcheck/"] stringByAppendingString:requestUrl];
        _requestUrl = [_requestUrl stringByAppendingString:version6];
        _requestArgument = [MAFMySecurity dictWithDicToStringEncryption:requestArgument];
    }
    return self;
}
- (instancetype)initWithSearchUrl:(NSString *)requestUrl argument:(nullable id)requestArgument {
    self = [super init];
    if (self) {
        _requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"farmcheck/"] stringByAppendingString:requestUrl];
        _requestUrl = [_requestUrl stringByAppendingString:version6];
        _requestArgument = [MAFMySecurity dictToStringEncryption:requestArgument];;
    }
    return self;
}

- (void)startWithCompletionBlockWithSuccess:(nullable YcYdReqCompletionBlock)success
                                    failure:(nullable YcYdReqCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:_requestUrl
       parameters:_requestArgument
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              if (_successCompletionBlock) {
                  NSData *xmlData = responseObject;
                  xmlData = [GTMBase64 decodeData:xmlData];
                  NSString *s = [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
                  
                  NSData *xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
                  id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
                  NSDictionary *responseDic1 = myRequest;
                  NSString *str = responseDic1[@"pro_data"];
                  
                  NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
                  id myReques2 = nil;
                  if (xmlData2 != nil) {
                      myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
                  }
                  NSDictionary *responseDic = myReques2;
                  _successCompletionBlock(self, responseDic);
              }
          } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              if (_failureCompletionBlock) {
                  _failureCompletionBlock(self, error);
              }
          }];
}
- (NSURLSessionDataTask *)startSearchWithCompletionBlockWithSuccess:(nullable YcYdReqCompletionBlock)success
                                    failure:(nullable YcYdReqCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    NSURLSessionDataTask *task = [manager POST:_requestUrl
       parameters:_requestArgument
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              if (_successCompletionBlock) {
                  NSData *xmlData = responseObject;
                  xmlData = [GTMBase64 decodeData:xmlData];
                  NSString *s = [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
                  
                  NSData *xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
                  id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
                  NSDictionary *responseDic1 = myRequest;
                  NSString *str = responseDic1[@"pro_data"];
                  
                  NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
                  id myReques2 = nil;
                  if (xmlData2 != nil) {
                      myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
                  }
                  NSDictionary *responseDic = myReques2;
                  _successCompletionBlock(self, responseDic);
              }
          } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
              if (_failureCompletionBlock) {
                  _failureCompletionBlock(self, error);
              }
          }];
    return task;
}

- (void)setCompletionBlockWithSuccess:(nullable YcYdReqCompletionBlock)success
                              failure:(nullable YcYdReqCompletionBlock)failure {
    _successCompletionBlock = success;
    _failureCompletionBlock = failure;
}

- (void)cancel {
    [_task cancel];
}

@end
