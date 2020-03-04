//
//  MAFSignInHttpRequest.m
//  MAF
//
//  Created by 王涛 on 17/2/13.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFSignInHttpRequest.h"
#import "AFNetworking.h"
#import "SETTINGConfig.h"
#import "WQMD5.h"
#import "GTMBase64.h"
#import "MAFMySecurity.h"
#import "SecurityUtil.h"
#import "MAFSignInConfig.h"
#import "MAFConfig.h"

@implementation MAFSignInHttpRequest

- (void)requsetUserSignClassWithUserId:(NSString *)user_id success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setValue:user_id forKey:@"user_id"];
    //发送请求
    NSString *s = [MAFMySecurity dictToStringEncryption:param];
    [manager POST:QUERYSIGNCLASS parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *xmlData = responseObject;
        xmlData = [GTMBase64 decodeData:xmlData];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDic1 = myRequest;
        NSString *str = responseDic1[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
        id myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
        }
        NSDictionary *responseDic = myReques2;
        if(success){
            success(responseDic);
        }
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(fail){
            fail(error);
        }
    }];
}
/*
 查询用户班次,新接口,改变判断逻辑,不以data是否为空判断是否有班次,新加字段来判断,并且返回数据中新增设备信息
 gaos.0420
 */
- (void)requsetNewUserSignClassWithUserId:(NSString *)user_id success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail {
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setValue:user_id forKey:@"user_id"];
    //发送请求
    NSString *s = [MAFMySecurity dictToStringEncryption:param];
    [manager POST:QUERYSIGNNEWCLASS parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *xmlData = responseObject;
        xmlData = [GTMBase64 decodeData:xmlData];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDic1 = myRequest;
        NSString *str = responseDic1[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
        id myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
        }
        NSDictionary *responseDic = myReques2;
        if(success){
            success(responseDic);
        }
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(fail){
            fail(error);
        }
    }];
}
//查询用户轨迹
- (void)queryUserTrailWithUserId:(NSString *)user_id  classDate:(NSString *)class_date page:(NSDictionary *)pg success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:class_date forKey:@"class_date"];
    [param setValue:pg forKey:@"pg"];
    
    //发送请求
    NSString *s = [MAFMySecurity dictWithDicToStringEncryption:param];
    
    [manager POST:QUERYMYTRAIL parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *xmlData = responseObject;
        xmlData = [GTMBase64 decodeData:xmlData];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDic1 = myRequest;
        NSString *str = responseDic1[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
        id myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
        }
        NSDictionary *responseDic = myReques2;
        if(success){
            success(responseDic);
        }
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(fail){
            fail(error);
        }
    }];
}

- (void)signOnClassWithUserId:(NSString *)user_id signType:(NSString *)sign_type classDate:(NSString *)class_date longitude:(NSString *)longitude latitude:(NSString *)latitude positionName:(NSString *)position_name manufacturer:(NSString *)manufacturer imei:(NSString *)imei success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail{

    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:sign_type forKey:@"sign_type"];
    [param setValue:class_date forKey:@"class_date"];
    [param setValue:longitude forKey:@"longitude"];
    [param setValue:latitude forKey:@"latitude"];
    [param setValue:position_name forKey:@"position_name"];
    [param setValue:manufacturer forKey:@"manufacturer"];
    [param setValue:imei forKey:@"imei"];
    
    //发送请求
    NSString *s = [MAFMySecurity dictToStringEncryption:param];
    
    [manager POST:SIGNONWORK parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *xmlData = responseObject;
        xmlData = [GTMBase64 decodeData:xmlData];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDic1 = myRequest;
        NSString *str = responseDic1[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
        id myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
        }
        NSDictionary *responseDic = myReques2;
        if(success){
            success(responseDic);
        }
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(fail){
            fail(error);
        }
    }];
}

- (void)signOutClassWithUserId:(NSString *)user_id classDate:(NSString *)class_date longitude:(NSString *)longitude latitude:(NSString *)latitude positionName:(NSString *)position_name manufacturer:(NSString *)manufacturer imei:(NSString *)imei success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:class_date forKey:@"class_date"];
    [param setValue:longitude forKey:@"longitude"];
    [param setValue:latitude forKey:@"latitude"];
    [param setValue:position_name forKey:@"position_name"];
    [param setValue:manufacturer forKey:@"manufacturer"];
    [param setValue:imei forKey:@"imei"];
    
    //发送请求
    NSString *s = [MAFMySecurity dictToStringEncryption:param];
    
    [manager POST:SIGNOUTWORK parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *xmlData = responseObject;
        xmlData = [GTMBase64 decodeData:xmlData];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDic1 = myRequest;
        NSString *str = responseDic1[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
        id myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
        }
        NSDictionary *responseDic = myReques2;
        if(success){
            success(responseDic);
        }
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(fail){
            fail(error);
        }
    }];
}

- (void)appealSignWithUserId:(NSString *)user_id classDate:(NSString *)class_date classId:(NSString *)class_id signId:(NSString *)sign_id signType:(NSString *)sign_explain_type signExplain:(NSString *)sign_explain success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail{
    
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:class_date forKey:@"class_date"];
    [param setValue:class_id forKey:@"class_id"];
    [param setValue:sign_id forKey:@"sign_id"];
    [param setValue:sign_explain_type forKey:@"sign_explain_type"];
    [param setValue:sign_explain forKey:@"sign_explain"];
    
    //发送请求
    NSString *s = [MAFMySecurity dictToStringEncryption:param];
    
    [manager POST:APPEALWORK parameters:s success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *xmlData = responseObject;
        xmlData = [GTMBase64 decodeData:xmlData];
        NSString *s =   [SecurityUtil decryptAESData:xmlData app_key:@"ctnq12316encrypt"];
        
        NSData* xmlData1 = [s dataUsingEncoding:NSUTF8StringEncoding];
        id myRequest = [NSJSONSerialization JSONObjectWithData:xmlData1 options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDic1 = myRequest;
        NSString *str = responseDic1[@"pro_data"];
        
        NSData* xmlData2 = [str dataUsingEncoding:NSUTF8StringEncoding];
        id myReques2 = nil;
        if (xmlData2 != nil) {
            myReques2 = [NSJSONSerialization JSONObjectWithData:xmlData2 options:NSJSONReadingMutableContainers error:nil];
        }
        NSDictionary *responseDic = myReques2;
        if(success){
            success(responseDic);
        }
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(fail){
            fail(error);
        }
    }];
}


@end
