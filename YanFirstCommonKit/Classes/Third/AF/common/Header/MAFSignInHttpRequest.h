//
//  MAFSignInHttpRequest.h
//  MAF
//
//  Created by 王涛 on 17/2/13.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAFSignInConfig.h"

@interface MAFSignInHttpRequest : NSObject


/*
    查询用户班次
 */
- (void)requsetUserSignClassWithUserId:(NSString *)user_id success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail;
/*
 查询用户班次,新接口,改变判断逻辑,不以data是否为空判断是否有班次,新加字段来判断,并且返回数据中新增设备信息
 gaos.0420
 */
- (void)requsetNewUserSignClassWithUserId:(NSString *)user_id success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail;

/*
    查询用户轨迹
 */

- (void)queryUserTrailWithUserId:(NSString *)user_id  classDate:(NSString *)class_date page:(NSDictionary *)pg success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail;

/*
    上班签到  1.考勤  3.自动签到  5.手动签到
 */

- (void)signOnClassWithUserId:(NSString *)user_id signType:(NSString *)sign_type classDate:(NSString *)class_date longitude:(NSString *)longitude latitude:(NSString *)latitude positionName:(NSString *)position_name manufacturer:(NSString *)manufacturer imei:(NSString *)imei success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail;

/*
    下班签退
 */

- (void)signOutClassWithUserId:(NSString *)user_id classDate:(NSString *)class_date longitude:(NSString *)longitude latitude:(NSString *)latitude positionName:(NSString *)position_name manufacturer:(NSString *)manufacturer imei:(NSString *)imei success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail;

/*
    考勤申诉
 */

- (void)appealSignWithUserId:(NSString *)user_id classDate:(NSString *)class_date classId:(NSString *)class_id signId:(NSString *)sign_id signType:(NSString *)sign_explain_type signExplain:(NSString *)sign_explain success:(void(^)(id responseObject))success fail:(void(^)(NSError *error))fail;
@end
