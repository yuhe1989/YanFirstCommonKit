//
//  MAFManager.h
//  MAF
//
//  Created by victor on 13-6-21.
//  Copyright (c) 2013年 MAF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIProgressDelegate.h"
#import "ASIHTTPRequest.h"


//
//请求回传的block
typedef void (^MAFManagerBlock)(id result);

@interface MAFHttpManager : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>
{
    ///请求成功的block
    MAFManagerBlock finishBlock;
    
    ///下载多媒体的的block
    MAFManagerBlock downloadMediaFinishBlock;
    
    ///请求失败的block
    MAFManagerBlock failBlock;
    
}
-(void)loadUpLoadMylogFile:(NSString*)uuid name:(NSString*)name content:(id)content type:(NSString*)type progressView:(UIProgressView*)progressView file_iszip:(NSString *)file_iszip;

/**
 在线农技员上传附件
 */
- (void)uploadQACFile:(NSString *)uuid name:(NSString *)name content:(id)content type:(NSString *)type zip:(NSString *)zip;

- (void)upLoadLogFileWithParam:(NSString *)param andFileData:(NSData*)content;

-(void)loadASIHttpRequestBodyMylog:(NSString*)bodyStr URL:(NSString*)urlStr DATA:(NSData*)content;
+(MAFHttpManager*)shareMAFHttpRequest;

-(void)setFinishBlock:(MAFManagerBlock)block;

-(void)setFailBlock:(MAFManagerBlock)block;

-(void)setDownloadMediaFinishBlock:(MAFManagerBlock)block;

-(void)getWorkObject:(NSDictionary *)pram url:(NSString *)url success:(void (^)(NSMutableDictionary * jsonDic))success failure:(void (^)(NSError * error))failure;

@property(nonatomic,retain)NSString *weiXinUrl;
@property(nonatomic,strong)ASIHTTPRequest *request;

#pragma mark 聊天的接口

/**
 *查询所有微农信的用户 3.6.1
 *@param uuid 用户uuid
 *@param contacts 所有手机号
 */
-(void)findFriends:(NSString *)uuid contacts:(NSString*)contacts;

/**
 *查询单个人的详细信息 3.6.2
 *@param uuid 用户uuid
 */
-(void)searchUser:(NSString*)uuid;


/**
 *查询单个人的详细信息 3.6.2
 *@param mobile 用户mobile
 */
-(void)searchUserWithMobile:(NSString*)mobile;

/**
 *上传多媒体信息 3.6.3
 *@param uuid 用户uuid
 *@param name 名字
 *@param content 多媒体的数据
 *@param type 类型
 */
-(void)loadUpLoadFile:(NSString*)uuid name:(NSString*)name content:(id)content type:(NSString*)type progressView:(UIProgressView*)progressView;

/**
 *下载多媒体 3.6.4
 *@param UrlStr url
 */
-(void)loadMediaFile:(NSString*)UrlStr;


#pragma mark 登陆信息

/**
 *获取验证码 3.1.2
 *@param mobileNo 手机号
 */
-(void)loadVerifyCode:(NSString*)mobileNo;

/**
 *注册接口 3.1.3
 *@param mobileNo 手机号
 */
-(void)reg:(NSString*)mobileNo password:(NSString*)pasword verifyCode:(NSString*)verifyCode;

/**
 *获取用户的JID 3.1.4
 *@param mobileNo 手机号
 */
-(void)checkBarejidMobile:(NSString*)mobile;


/**
 *获取用户的资料 3.1.5
 *@param uuid 用户uuid
 */
-(void)loadDownLoadAccountInfo:(NSString *)uuid departMentID:(NSString*)departmentID;

/**
 *修改用户的资料 3.1.6
 *@param uuid 用户uuid
 *@param logoname 头像名字
 *@param logo 头像数据
 *@param sex 性别
 *@param address 地区
 *@param desc 签名
 */
-(void)loadUpdateAccountInfo:(NSString *)uuid logo:(NSString*)logo sex:(NSString*)sex address:(NSString*)address desc:(NSString*)desc;

/**
 更新用户签名
 
 @param parms ID & 签名信息
 @param success
 @param fail
 */
- (void)updateUserSign:(NSString *)uuid signText:(NSString *)signText;

/**
 *找回密码 3.1.7
 *@param mobileNo 手机号
 *@param password 密码
 *@param verifyCode 验证码
 */
-(void)findPassword:(NSString*)mobileNo password:(NSString*)pasword verifyCode:(NSString*)verifyCode;

/**
 *修改密码 3.1.8
 *@param mobileNo 手机号
 *@param password 密码
 *@param verifyCode 验证码
 */
-(void)loadChangePasswordAccount:(NSString *)mobile oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;

/**
 *找回密码的验证码 3.1.9
 *@param mobileNo 手机号
 */
-(void)loadFindPassVerifyCode:(NSString*)mobileNo;

/**
 *找回密码的验证码 3.1.10
 *@param mobileNo 手机号
 */
-(void)loadInstallCount:(NSString *)appid;


/**
 *升级接口 3.1.11
 *@param 手机的所有信息
 */
-(void)loadUpGradeVersion:(NSMutableDictionary*)dic;

/**
 *升级接口 3.1.12
 *@param 请求app借口
 */
-(void)loadApp:(NSString*)appid;

-(void)loadHtmlInfor:(NSString *)user_id Year:(NSString*)year Quarter:(NSString *)quarter;


///////NSC首页网络协议修改
- (void)queryDeptByUser:(NSString *)user_id;

- (void)queryAuthorityByUser:(NSString *)user_id user_orgid:(NSString *)user_orgid app_orgid:(NSString *)app_orgid app_paltform:(NSString *)plat_form;

#pragma mark - 待办工作

/**
 查询待办申报工作
 */
- (void)requestReportWorkWithUserId:(NSString *)user_id pg:(NSDictionary *)pg success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 查询待办周期工作
 */
- (void)requestCycleWorkWithUserId:(NSString *)user_id pg:(NSDictionary *)pg success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 查询待办固定工作
 */
- (void)requestFixedWorkWithUserId:(NSString *)user_id success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 查询离线工作详情
 */
- (void)requestWorkScheduleDetailWithUserId:(NSString *)user_id scheduleId:(NSString *)schedule_id tableName:(NSString *)table_name success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
