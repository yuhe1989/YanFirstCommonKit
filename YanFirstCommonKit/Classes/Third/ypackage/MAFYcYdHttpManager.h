//
//  MAFYcYdHttpManager.h
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAFYcYdHttpManager : NSObject
/**
 请求URL
 */
@property (nonatomic, strong) NSString *requestUrl;
/**
 请求参数
 */
@property (nonatomic, strong, nullable) id requestArgument;

typedef void(^AFConstructingBlock)(id<AFMultipartFormData> formData);

typedef void(^YcYdReqCompletionBlock)(__kindof MAFYcYdHttpManager *manager, id responseObject);

@property (nonatomic, copy, nullable) YcYdReqCompletionBlock successCompletionBlock;

@property (nonatomic, copy, nullable) YcYdReqCompletionBlock failureCompletionBlock;

@property (nonatomic, copy, nullable) AFConstructingBlock constructingBodyBlock;

- (instancetype)initWithCommonUrl:(NSString *)commonUrl
                         argument:(nullable id)requestArgument;

- (instancetype)initWithRequestAnimalUrl:(NSString *)commonUrl
                        argument:(nullable id)requestArgument;

- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                          argument:(nullable id)requestArgument;
/**
 需要加密数组参数时调用此方法
 */
- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                       arrArgument:(nullable id)requestArgument;
/**
 需要加密字典参数时调用此方法
 */
- (instancetype)initWithRequestUrl:(NSString *)requestUrl
                       DicArgument:(id)requestArgument;

- (void)startWithCompletionBlockWithSuccess:(nullable YcYdReqCompletionBlock)success
                                    failure:(nullable YcYdReqCompletionBlock)failure;
- (NSURLSessionDataTask *)startSearchWithCompletionBlockWithSuccess:(nullable YcYdReqCompletionBlock)success failure:(nullable YcYdReqCompletionBlock)failure;


- (void)setCompletionBlockWithSuccess:(nullable YcYdReqCompletionBlock)success
                              failure:(nullable YcYdReqCompletionBlock)failure;

- (void)cancel;

NS_ASSUME_NONNULL_END

@end
