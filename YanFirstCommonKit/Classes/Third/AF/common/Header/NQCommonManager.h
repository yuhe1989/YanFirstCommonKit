//
//  NQCommonManager.h
//  NQProject
//
//  Created by 阿蒙 on 2019/11/5.
//  Copyright © 2019 NQKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccess)(NSDictionary * _Nullable responseObject);


NS_ASSUME_NONNULL_BEGIN

@interface NQCommonManager : NSObject

+(instancetype)commenManager;

-(void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id _Nullable resp))reqSuccess fail:(void(^)(NSError *error))respFailure;

@end

NS_ASSUME_NONNULL_END
