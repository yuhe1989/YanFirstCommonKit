//
//  GAECManager.m
//  GAEC
//
//  Created by victor on 13-6-21.
//  Copyright (c) 2013年 GAEC. All rights reserved.
//

#import "MAFHttpManager.h"
#import "ASIFormDataRequest.h"
#import "RegisterRes.h"
#import "JSONKit.h"
#import "IdenCode.h"
#import "MAFUpgrate.h"
#import "DataBase64DecodeAndEncode.h"
#import "MAFProgressHUD.h"
#import "CheckNetwork.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "MAFDept.h"
#import "GTMBase64.h"
#import "SecurityUtil.h"
#import "MAFMySecurity.h"
#import "SETTINGConfig.h"
#import "MAFUUID.h"
#import "MAFConfig.h"

#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

@implementation MAFHttpManager

/*
 @ 初始化Xmpp 单例方法
 */
+(MAFHttpManager*)shareMAFHttpRequest
{
    static MAFHttpManager *httpRequestlass = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        httpRequestlass = [[self alloc] init];
    });
    return httpRequestlass;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        
        
        
        
    }
    return self;
}

//>>> >>> MAFHttpManager.m添加方法
-(void)loadUpLoadMylogFile:(NSString*)uuid name:(NSString*)name content:(id)content type:(NSString*)type progressView:(UIProgressView*)progressView file_iszip:(NSString *)file_iszip

{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"user_id",name,@"file_name",type,@"file_type", nil];
    
    NSString *bodyDataStr = [NSString stringWithFormat:@"user_id=%@&file_type=%@&file_name=%@&file_iszip=%@", dic[@"user_id"], type, dic[@"file_name"],file_iszip];
    
    
    
    [self loadASIHttpRequestBodyMylog:bodyDataStr URL:UPLOADURL2 DATA:content];
    
}

- (void)uploadQACFile:(NSString *)uuid name:(NSString *)name content:(id)content type:(NSString *)type zip:(NSString *)zip {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"user_id",name,@"file_name",type,@"file_type", nil];
    NSString *bodyDataStr = [NSString stringWithFormat:@"user_id=%@&file_type=%@&file_name=%@&file_iszip=%@", dic[@"user_id"], type, dic[@"file_name"],zip];
    
    [self loadASIHttpRequestBodyMylog:bodyDataStr URL:UPLOADMYFILE DATA:content];
}

- (void)upLoadLogFileWithParam:(NSString *)param andFileData:(NSData*)content{
    
    [self loadASIHttpRequestBodyMylog:param URL:UPLOADMYFILE DATA:content];
}

//>>> >>>MAFHttpManager.mt添加方法

-(void)loadASIHttpRequestBodyMylog:(NSString*)bodyStr URL:(NSString*)urlStr DATA:(NSData*)content
{
    
    NSMutableData *tempJsonData = [NSMutableData dataWithData:content];
    urlStr = [NSString stringWithFormat:@"%@&%@", urlStr, bodyStr];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSLog(@"****%@",url);
    self.request=[ASIHTTPRequest requestWithURL:url];
    self.request.delegate = self;
    NSMutableData *bodyData=[NSMutableData data];
    [bodyData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self.request setRequestMethod:@"POST"];
    [self.request addRequestHeader:@"Content-Type" value:@"application/json"];
    [self.request setPostBody:tempJsonData];
    // [self.request appendPostData:content];
    [self.request setShouldContinueWhenAppEntersBackground:YES];
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];//是否显示网络请求信息在status bar上：
    NSTimeInterval time = 60;
    [ASIHTTPRequest setDefaultTimeOutSeconds:time];    //设置超时时间
    [self.request startAsynchronous];
}

-(void)setFinishBlock:(MAFManagerBlock)block
{
    finishBlock = block;
}

-(void)setFailBlock:(MAFManagerBlock)block
{
    failBlock = block;
}

-(void)setDownloadMediaFinishBlock:(MAFManagerBlock)block
{
    downloadMediaFinishBlock = block;
}


/////////首页网络协议修改
- (void)queryDeptByUser:(NSString *)user_id
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user_id, @"user_id", nil];
    //NSString *bodyDataStr  = [dic JSONString];
    
    [self loadASIHttpRequestBodyT:dic URL:QUERYDEPTBYUSER];
}

- (void)queryAuthorityByUser:(NSString *)user_id user_orgid:(NSString *)user_orgid app_orgid:(NSString *)app_orgid app_paltform:(NSString *)plat_form
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user_id, @"user_id",user_orgid,@"user_orgid", plat_form, @"app_platform",app_orgid,@"app_orgid", nil];
    //    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBodyT:dic URL:QUERYUSERAUTHORITY];
}
#pragma mark -
#pragma mark private method

-(void)loadASIHttpRequestBody:(NSString*)bodyStr URL:(NSString*)urlStr
{
    NSURL *url=[NSURL URLWithString:urlStr];
    self.request=[ASIHTTPRequest requestWithURL:url];
    self.request.delegate = self;
    //
    //    self.request.uploadProgressDelegate = self;
    //    self.request.showAccurateProgress = YES;
    
    
    NSMutableData *bodyData=[NSMutableData data];
    [bodyData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    [self.request setRequestMethod:@"POST"];
    [self.request addRequestHeader:@"Content-Type" value:@"application/json"];
    [self.request appendPostData:bodyData];
    [self.request setShouldContinueWhenAppEntersBackground:YES];
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];//是否显示网络请求信息在status bar上：
    NSTimeInterval time = 30;
    [ASIHTTPRequest setDefaultTimeOutSeconds:time];    //设置超时时间
    [self.request startAsynchronous];
}

-(void)loadASIHttpRequestBodyT:(NSDictionary*)bodyStr URL:(NSString*)urlStr
{
    NSURL *url=[NSURL URLWithString:urlStr];
    self.request=[ASIHTTPRequest requestWithURL:url];
    self.request.delegate = self;
    //
    //    self.request.uploadProgressDelegate = self;
    //    self.request.showAccurateProgress = YES;
    
    
    // NSMutableData *bodyData=[NSMutableData data];
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyStr options:NSJSONWritingPrettyPrinted error:nil];
    [self.request setRequestMethod:@"POST"];
    [self.request addRequestHeader:@"Content-Type" value:@"application/json"];
    [self.request appendPostData:bodyData];
    [self.request setShouldContinueWhenAppEntersBackground:YES];
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];//是否显示网络请求信息在status bar上：
    NSTimeInterval time = 30;
    [ASIHTTPRequest setDefaultTimeOutSeconds:time];    //设置超时时间
    [self.request startAsynchronous];
}



#pragma mark -
#pragma mark public method

#pragma mark 聊天的接口

/**
 *查询所有微农信的用户 3.6.1
 *@param uuid 用户uuid
 *@param contacts 所有手机号
 */
-(void)findFriends:(NSString *)uuid contacts:(NSString*)contacts
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",contacts,@"contacts", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:FRIENDSLISTURL];
}

/**
 *查询单个人的详细信息 3.6.2
 *@param uuid 用户uuid
 */

//查询用户接口
#define SEARCHUSERURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"searchUser",VERSION]

-(void)searchUser:(NSString*)uuid
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:SEARCHUSERURL];
}

/**
 *查询单个人的详细信息 3.6.2
 *@param Mobile 用户Mobile
 */
-(void)searchUserWithMobile:(NSString*)mobile
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:SEARCHUSERURL];
}

/**
 *上传多媒体信息 3.6.3
 *@param uuid 用户uuid
 *@param name 名字
 *@param content 多媒体的数据
 *@param type 类型
 */
-(void)loadUpLoadFile:(NSString*)uuid name:(NSString*)name content:(id)content type:(NSString*)type progressView:(UIProgressView*)progressView
{
    // NSArray *a = [name componentsSeparatedByString:@"-"];
    NSDictionary *dic;
    //    if (a.count>=2) {
    //          dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",name,@"name",content,@"content",type,@"content_type",a[0],@"msg_dutime", nil];
    //    }else{
    dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",name,@"name",content,@"content",type,@"content_type", nil];
    //  }
    
    NSString *bodyDataStr  = [dic JSONString];
    
    [self loadASIHttpRequestBody:bodyDataStr URL:UPLOADURL];
}

/**
 *下载多媒体 3.6.4
 *@param UrlStr url
 */
-(void)loadMediaFile:(NSString*)UrlStr
{
    self.request = [ ASIHTTPRequest requestWithURL :[NSURL URLWithString:UrlStr]];
    self.request.delegate = self;
    [self.request setShouldContinueWhenAppEntersBackground:YES];
    [self.request setDownloadDestinationPath :nil];
    [self.request setDownloadProgressDelegate :nil];
    [self.request startAsynchronous];
}

#pragma mark 登陆信息

/**
 *获取验证码 3.1.2
 *@param mobileNo 手机号
 */
-(void)loadVerifyCode:(NSString*)mobileNo
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo,@"mobile",@"0",@"flag", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:VERIFYCODEURL];
    
    [MAFProgressHUD showHUDlabelMessage:@"正在获取验证码"];
}

/**
 *注册接口 3.1.3
 *@param mobileNo 手机号
 */
-(void)reg:(NSString*)mobileNo password:(NSString*)pasword verifyCode:(NSString*)verifyCode
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo,@"mobile",pasword,@"pwd",verifyCode,@"verify_code",COMMONCLASS.appID, @"app_id", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:REGISTERURL];
    [MAFProgressHUD showHUDlabelMessage:@"正在注册..."];
}

/**
 *获取用户的JID 3.1.4
 *@param mobileNo 手机号
 */
-(void)checkBarejidMobile:(NSString*)mobile{
    
    CHECKNETWORK
    NSString *identifierForVendor = [MAFUUID getUUID];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:identifierForVendor forKey:@"imei"];
    
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:CHECKBAREJIDURL];
}


/**
 *获取用户的资料 3.1.5
 *@param uuid 用户uuid
 */
-(void)loadDownLoadAccountInfo:(NSString *)uuid departMentID:(NSString*)departmentID
{
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",departmentID,@"deptid",nil];
    //    NSString *bodyDataStr  = [dic JSONString];
    //    [self loadASIHttpRequestBody:bodyDataStr URL:DOWNLOADACCOUNTINFOURL];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",departmentID,@"deptid", COMMONCLASS.appID,@"app_id", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:DOWNLOADACCOUNTINFOURL];
}

/**
 *修改用户的资料 3.1.6
 *@param uuid 用户uuid
 *@param logoname 头像名字
 *@param logo 头像数据
 *@param sex 性别
 *@param address 地区
 *@param desc 签名
 */
-(void)loadUpdateAccountInfo:(NSString *)uuid logo:(NSString*)logo sex:(NSString*)sex address:(NSString*)address desc:(NSString*)desc
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid,@"uuid",logo,@"logo",sex,@"sex",address,@"area_code",desc,@"desc",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:UPDATEACCOUNTINFOURL];
    [MAFProgressHUD showHUDlabelMessage:@"正在上传个人信息"];
}

- (void)updateUserSign:(NSString *)uuid signText:(NSString *)signText {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uuid, @"user_id", signText, @"desc", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:UPDATEUSERSIGN];
}

/**
 *找回密码 3.1.7
 *@param mobileNo 手机号
 *@param password 密码
 *@param verifyCode 验证码
 */
-(void)findPassword:(NSString*)mobileNo password:(NSString*)pasword verifyCode:(NSString*)verifyCode
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo,@"mobile",pasword,@"new_pwd",verifyCode,@"verify_code", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:FINDPASSWORDURL];
    [MAFProgressHUD showHUDlabelMessage:@"正在找回密码"];
}

/**
 *修改密码 3.1.8
 *@param mobileNo 手机号
 *@param password 密码
 *@param verifyCode 验证码
 */
-(void)loadChangePasswordAccount:(NSString *)mobile oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobile,@"mobile",oldPassword,@"old_pwd",newPassword,@"new_pwd",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:CHANGEPASSWORDURL];
    [MAFProgressHUD showHUDlabelMessage:@"正在更改密码"];
}

/**
 *找回密码的验证码 3.1.9
 *@param mobileNo 手机号
 */
-(void)loadFindPassVerifyCode:(NSString*)mobileNo
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mobileNo,@"mobile", nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:FINDPASSWORDVERCODEURL];
    [MAFProgressHUD showHUDlabelMessage:@"正在获取验证码"];
}

/**
 *找回密码的验证码 3.1.10
 *@param mobileNo 手机号
 */
-(void)loadInstallCount:(NSString *)appid
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:appid,@"app_id",@"1",@"platform",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:INSTALLCOUNTURL];
    
}


/**
 *升级接口 3.1.11
 *@param 手机的所有信息
 */
-(void)loadUpGradeVersion:(NSMutableDictionary*)dic
{
    //NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:COMMONCLASS.appID,@"app_id",COMMONCLASS.departmentId,@"department_id",nil];
    
    NSString *bodyDataStr  = [dic JSONString];
    
    [self loadASIHttpRequestBody:bodyDataStr URL:UPDATEURL];
    
    
}


/**
 *升级接口 3.1.12
 *@param 请求app借口
 */
-(void)loadApp:(NSString*)appid
{
    NSString *updateTime = [[NSUserDefaults standardUserDefaults]valueForKey:@"updateTime"];
    if (!updateTime) {
        updateTime = @"";
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:appid,@"id",updateTime,@"updateTime",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:LOADAPP_new];
}


//获取网页缓存数据
-(void)loadHtmlInfor:(NSString *)user_id Year:(NSString*)year Quarter:(NSString *)quarter
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:year,@"year",user_id,@"user_id",quarter,@"quarter",nil];
    NSString *bodyDataStr  = [dic JSONString];
    [self loadASIHttpRequestBody:bodyDataStr URL:LOADHTMLINFOR];
}



#pragma mark -
#pragma mark ASIHTTPRequest delegate
-(void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes
{
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
    NSLog(@"%lld",bytes);
#endif
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@", request.error);
    [MAFProgressHUD hide];
    NSString * u = [NSString stringWithFormat:@"%@",request.url];
    NSArray *a = [u componentsSeparatedByString:@"&user_id"];
    NSLog(@"%@", UPLOADURL2);
    if ([a[0] isEqual:UPLOADURL2]){
        failBlock(nil);
    }
    // ALTERVIEW(@"请求超时,请检查网络")
}


-(void)setProgress:(float)newProgress
{
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
    NSLog(@"%f",newProgress);
#endif
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * u = [NSString stringWithFormat:@"%@",request.url];
    NSArray *a = [u componentsSeparatedByString:@"&user_id"];
    if ([request.url isEqual:[NSURL URLWithString:REGISTERURL]]) {
        
        //注册接口
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            //加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                RegisterRes *registerRes = [[RegisterRes alloc]init];
                registerRes.return_code = [result valueForKey:@"code"];
                registerRes.return_res = [result valueForKey:@"desc"];
                finishBlock ?finishBlock(registerRes):nil;
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"1"])
            {
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"参数不对")
#endif
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"7"])
            {
                ALTERVIEW(@"验证码错误")
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"9"])
            {
                ALTERVIEW(@"该用户已经注册")
                [MAFProgressHUD hide];
            }
            else
            {
                ALTERVIEW(@"注册失败请重新注册")
                [MAFProgressHUD hide];
            }
            
        }
    }
    
    else if ([request.url isEqual:[NSURL URLWithString:QUERYDEPTBYUSER]]){
        NSData *registerInformation = [request responseData];
        
        id responseDic = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        
        NSString *code = [responseDic objectForKey:@"code"];
        if ([code isEqualToString:@"0"]) {
            
            NSDictionary *userSubDic = [responseDic objectForKey:@"msg"];
            NSMutableArray *userArr = [NSMutableArray arrayWithCapacity:0];
            
            MAFDept *dept = [[MAFDept alloc] init];
            dept.Id = [userSubDic objectForKey:@"id"];
            dept.name = [userSubDic objectForKey:@"name"];
            dept.code = [userSubDic objectForKey:@"code"];
            
            [userArr addObject:dept];
            
            finishBlock?finishBlock(userArr):nil;
        }
        
        else{
            finishBlock(nil);
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:QUERYUSERAUTHORITY]]){
        NSData *registerInformation = [request responseData];
        
        id responseDic = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        
        NSUserDefaults *def =[NSUserDefaults standardUserDefaults];
        [def setObject:responseDic forKey:@"QUANXIAN"];
        [def synchronize];
        
        NSString *code = [responseDic objectForKey:@"code"];
        NSLog(@"%@",responseDic);
        if ([code isEqualToString:@"0"]) {
            finishBlock?finishBlock([responseDic objectForKey:@"msgList"]):nil;
        }else{
            finishBlock(nil);
        }
        
    }
    
    
    else if ([request.url isEqual:[NSURL URLWithString:CHECKBAREJIDURL]]) {
        
        NSData *registerInformation = [request responseData];
        
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                NSString *desc = [NSString stringWithFormat:@"%@",[result valueForKey:@"desc"]];
                finishBlock ?finishBlock(desc):nil;
            }
            else if ([returnCode isEqualToString:@"3"])
            {
                ALTERVIEW(@"此用户不存在")
            }
            else
            {
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"获取breajid失败")
#endif
            }
            
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:FINDPASSWORDURL]]) {
        
        //找回密码
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                RegisterRes *registerRes = [[RegisterRes alloc]init];
                registerRes.return_code = [result valueForKey:@"code"];
                registerRes.return_res = [result valueForKey:@"desc"];
                finishBlock ?finishBlock(registerRes):nil;
                [MAFProgressHUD hide];
            }
            else
            {
                ALTERVIEW(@"找回密码失败")
                [MAFProgressHUD hide];
            }
            
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:FINDPASSWORDVERCODEURL]]){
        
        //验证码接口
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            //加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            
            if ([returnCode isEqualToString:@"0"])
            {
                IdenCode *idenCode = [[IdenCode alloc]init];
                idenCode.return_code = [result valueForKey:@"code"];
                idenCode.return_res = [result valueForKey:@"desc"];
                finishBlock ?finishBlock(idenCode):nil;
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"1"])
            {
                NSString *return_res = [NSString stringWithFormat:@"%@", [result valueForKey:@"desc"]];
                ALTERVIEW(return_res)
                [MAFProgressHUD hide];
            }
            else
            {
                ALTERVIEW(@"获取验证码失败,请重新获取")
                [MAFProgressHUD hide];
            }
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:VERIFYCODEURL]]){
        
        //验证码接口
        NSData *registerInformation = [request responseData];
        
        
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            //加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            
            if ([returnCode isEqualToString:@"0"])
            {
                IdenCode *idenCode = [[IdenCode alloc]init];
                idenCode.return_code = [result valueForKey:@"code"];
                idenCode.return_res = [result valueForKey:@"desc"];
                finishBlock ?finishBlock(idenCode):nil;
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"1"])
            {
                NSString *return_res = [NSString stringWithFormat:@"%@", [result valueForKey:@"desc"]];
                ALTERVIEW(return_res)
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"9"])
            {
                ALTERVIEW(@"该用户已经注册了，默认密码是123456")
                [MAFProgressHUD hide];
            }
            else if ([returnCode isEqualToString:@"7003"])
            {
                ALTERVIEW(@"获取验证码过于频繁")
                [MAFProgressHUD hide];
            }
            else
            {
                ALTERVIEW(@"获取验证码失败")
                [MAFProgressHUD hide];
            }
        }
    } else if ([request.url isEqual:[NSURL URLWithString:INSTALLCOUNTURL]]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:@"1" forKey:FIRSTUSE];
                [defaults synchronize];
            }
        }
    } else if ([request.url isEqual:[NSURL URLWithString:LOADHTMLINFOR]]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:result forKey:@"htmlinfor"];
                [defaults synchronize];
            }
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:CHANGEPASSWORDURL]]){
        
        NSData *registerInformation = [request responseData];
        
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            ///加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                
                MAIN(^{
                    ALTERVIEW(@"修改密码成功")
                });
                finishBlock ?finishBlock(result):nil;
                [MAFProgressHUD hide];
            }
            else
            {
                MAIN(^{
                    ALTERVIEW(@"修改密码失败")
                });
                
                [MAFProgressHUD hide];
            }
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:UPDATEACCOUNTINFOURL]]){
        
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            //加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            
            if ([returnCode isEqualToString:@"0"])
            {
                finishBlock ?finishBlock(result):nil;
                //                ALTERVIEW(@"个人信息保存成功")
                [MAFProgressHUD hide];
                
            }
            else
            {
                ALTERVIEW(@"上传个人信息失败")
                [MAFProgressHUD hide];
            }
        }
    }else if ([request.url isEqual:[NSURL URLWithString:UPDATEUSERSIGN]]) {
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            //加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"]) {
                finishBlock ?finishBlock(result):nil;
            }
        }else{
            [MAFProgressHUD hide];
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:DOWNLOADACCOUNTINFOURL]]){
        
        NSData *registerInformation = [request responseData];
        
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            //
            //加入这段代码的必要性，return_code其实是一个int类型的 先把它转化成string类型
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            
            if ([returnCode isEqualToString:@"0"])
            {
                finishBlock ?finishBlock([result valueForKey:@"user"]):nil;
                
            }
            else
            {
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"下载个人信息失败")
#endif
            }
        }
    }  else if ([request.url isEqual:[NSURL URLWithString:UPDATEURL]]){
        NSData *registerInformation = [request responseData];
        
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        
        if (!result) {
            failBlock ?failBlock(result):nil;
        }
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            
            if ([returnCode isEqualToString:@"0"]) {
                MAFUpgrate *upgrate = [[MAFUpgrate alloc]init];
                upgrate.tag = [NSString stringWithFormat:@"%@", [[result valueForKey:@"app"]valueForKey:@"tag"]];
                upgrate.version_desc = [NSString stringWithFormat:@"%@", [[result valueForKey:@"app"]valueForKey:@"note"]];
                upgrate.version_url = [NSString stringWithFormat:@"%@", [[result valueForKey:@"app"]valueForKey:@"url" ]];
                upgrate.appID = [NSString stringWithFormat:@"%@", [[result valueForKey:@"app"]valueForKey:@"app_id"]];
                finishBlock ?finishBlock(upgrate):nil;
            }
            else
            {
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"版本更新错误")
#endif
            }
        }
        
    }
    else if ([request.url isEqual:[NSURL URLWithString:UPLOADURL]]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                finishBlock ?finishBlock(result):nil;
                
                //                dispatch_async(dispatch_get_main_queue(), ^{
                //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"returnChatController" object:nil userInfo:nil];
                //                });
            }
            else
            {
                failBlock ?failBlock(nil):nil;
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"发送多媒体文件失败")
#endif
            }
            failBlock ?failBlock(nil):nil;
        }
    }
#pragma mark ================my========================
    else if ([a[0] isEqual:UPLOADURL2]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                finishBlock ?finishBlock(result):nil;
            }
            else
            {
                failBlock ?failBlock(result):nil;
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"发送多媒体文件失败")
#endif
            }
        }
    }
    
    else if ([a[0] isEqualToString:UPLOADMYFILE]) {
        
        NSData *data = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"code"] isEqualToString:@"000000"]) {
                finishBlock ?finishBlock(result):nil;
            }else {
                failBlock ?failBlock(result):nil;
            }
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:FRIENDSLISTURL]]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"]||[returnCode isEqualToString:@"3"]||[returnCode isEqualToString:@"1"])
            {
                finishBlock ?finishBlock(result):nil;
            }
            else
            {
                failBlock?failBlock(result):nil;
                
#if defined(DEBUG_ANALYTICS_MANAGER) && DEBUG_ANALYTICS_MANAGER
                ALTERVIEW(@"获取好友列表")
#endif
            }
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:SEARCHUSERURL]]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                finishBlock ?finishBlock(result):nil;
            }
            else
            {
                //ALTERVIEW(@"不是微农信用户")
            }
        }
    }
    else if ([request.url isEqual:[NSURL URLWithString:LOADAPP_new]]){
        NSData *registerInformation = [request responseData];
        id result = [NSJSONSerialization JSONObjectWithData:registerInformation options:NSJSONReadingAllowFragments error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *returnCode = [NSString stringWithFormat:@"%@", [result valueForKey:@"code"]];
            if ([returnCode isEqualToString:@"0"])
            {
                NSString *oldUpdataTime = [[NSUserDefaults standardUserDefaults]valueForKey:@"updateTime"];
                NSString *newUpdataTime = [result valueForKey:@"updateTime"];
                
                if (![oldUpdataTime isEqualToString:newUpdataTime]) {
                    
                    [[NSUserDefaults standardUserDefaults]setValue:newUpdataTime forKey:@"updateTime"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                }
                
                finishBlock ?finishBlock(result):nil;
                
            }
            if ([returnCode isEqualToString:@"2"])
            {
                
                finishBlock ?finishBlock(result):nil;
                
            }
            
            else
            {
                //ALTERVIEW(@"不是微农信用户")
            }
        }
    }
    
    
    else {
        NSData *information = [request responseData];
        NSString *url = [request.url absoluteString];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:information,@"information",url,@"url",nil];
        finishBlock ?finishBlock(information):nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            downloadMediaFinishBlock ?downloadMediaFinishBlock(dic):nil;
        });
    }
}


// 获取日志工作对象
- (void)getWorkObject:(NSDictionary *)pram url:(NSString *)url success:(void (^)(NSMutableDictionary *))success failure:(void (^)(NSError *))failure
{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //接口地址
    
    //请求超时设置
    manager.requestSerializer.timeoutInterval = 15;
    
    //网络请求
    [manager POST:url parameters:pram success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(success){
            NSMutableDictionary * josnDic = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            success(josnDic);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 待办工作

- (void)requestReportWorkWithUserId:(NSString *)user_id pg:(NSDictionary *)pg success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setValue:pg forKey:@"pg"];
    [parms setValue:user_id forKey:@"user_id"];
    NSString *requestArgument = [MAFMySecurity dictWithDicToStringEncryption:parms];
    NSString *requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"queryMyPendingDeclarationWork"] stringByAppendingString:version6];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:requestUrl parameters:requestArgument success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestCycleWorkWithUserId:(NSString *)user_id pg:(NSDictionary *)pg success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setValue:pg forKey:@"pg"];
    [parms setValue:user_id forKey:@"user_id"];
    NSString *requestArgument = [MAFMySecurity dictWithDicToStringEncryption:parms];
    NSString *requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"queryMyPendingCycleWork"] stringByAppendingString:version6];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:requestUrl parameters:requestArgument success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestFixedWorkWithUserId:(NSString *)user_id success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setValue:user_id forKey:@"user_id"];
    NSString *requestArgument = [MAFMySecurity dictToStringEncryption:parms];
    NSString *requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"queryMyPendingFixedWork"] stringByAppendingString:version6];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:requestUrl parameters:requestArgument success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestWorkScheduleDetailWithUserId:(NSString *)user_id scheduleId:(NSString *)schedule_id tableName:(NSString *)table_name success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setValue:user_id forKey:@"user_id"];
    [parms setValue:schedule_id forKey:@"schedule_id"];
    [parms setValue:table_name forKey:@"table_name"];
    NSString *requestArgument = [MAFMySecurity dictToStringEncryption:parms];
    NSString *requestUrl = [[REQUESTADDRESS_R stringByAppendingString:@"queryOfflinePendingItems"] stringByAppendingString:version6];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:requestUrl parameters:requestArgument success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
        if (success) {
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

