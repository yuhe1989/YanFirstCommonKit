//
//  NQCommonManager.m
//  NQProject
//
//  Created by 阿蒙 on 2019/11/5.
//  Copyright © 2019 NQKJ. All rights reserved.
//

#import "NQCommonManager.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"
#import "MAFMySecurity.h"
#import "AFNetworking.h"

static NQCommonManager *commenManager;

@implementation NQCommonManager

+(instancetype)commenManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commenManager = [[NQCommonManager alloc] init];
    });
    return commenManager;
}

-(void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id _Nullable resp))reqSuccess fail:(void(^)(NSError *error))respFailure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //发送请求
    NSString *s = [MAFMySecurity dictToStringEncryption:params];
    NSLog(@"========== s:%@", s);
    [manager POST:url parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSData *xmlData = [GTMBase64 decodeData:responseObject];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSString *str = myRequest[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
                
        NSDictionary *myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"====== login data:%@", myReques2);
            if(reqSuccess){
                reqSuccess(myReques2);
            }
        } else {
            NSLog(@"========= 数据异常");
        }
        
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if(respFailure){
            respFailure(error);
        }
    }];
}

@end
