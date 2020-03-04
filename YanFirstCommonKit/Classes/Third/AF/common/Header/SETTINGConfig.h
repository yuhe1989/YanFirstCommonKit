//
//  SETTINGConfig.h
//  MAF
//
//  Created by mac on 14-7-1.
//  Copyright (c) 2014年 ctnq. All rights reserved.
//

#ifndef MAF_SETTINGConfig_h
#define MAF_SETTINGConfig_h

#import "MAFConfig.h"

/*
 *定义统一：
 *jid:      登录服务器登陆标识+resource
 *barejid： 登录服务器登陆标识
 *id:       umc中的用户唯一标识
 *mobile:   用户手机号码
 *resource: 用户当前绑定的资源，android客户端，resource是android，ios是ios
 *password: 用户的密码
 *barejid与id关系：id@domain.com等于barejid
 *用户初次登录时，先访问"获取登陆信息"接口,再进行登陆。
 **/
#define BAREJID @"barejid"
#define UserID @"uuid"
#define USERNAME @"name"
#define USERLOGO @"logo"
#define MOBILE @"mobile"
#define RESOURCE @"resource"
#define PASSWORD @"password"
#define DEPTID @"deptId"
#define FIRSTLOAD @"firstload"
#define USERSEX @"sex"
#define ORGNAME @"user_orgname"
#define APP_DEPTID @"app_deptid"
#define APP_DEPTNAME @"app_deptname"
#define APP_DEPTCODE @"app_deptcode"
#define USER_ZHENID @"user_zhencode"
#define USER_ZHENNAME @"user_zhenname"

#define FILEDOWNPATH [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@",@"Library",@"/",@"Caches/FileDown"]]
#define FILEDOWNPATH1 [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@%@",@"Library",@"/",@"Caches/FileDown"]]

///消息发送者userdefault的名字
#define DEPARTMENTNAME @"senderName"

///聊天的时候的消息发送者的名字
#define CHATSENDERNAME @"chatsenderName"

///获取本地的数据（在手机下面使用）
#define LOCALPATH @"/var/mobile/Applications"
///获取本地的数据（在模拟器下面使用）
//#define LOCALPATH @"/Users/victor"


//注册接口
#define REGISTERURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"register",VERSION]
//找到barejid接口
#define CHECKBAREJIDURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryLoginInfo",VERSION]

//#define CHECKBAREJIDURL_new @"http://222.173.29.163:81/BMS/userLogin"
#define LOADAPP_new @"http://222.173.29.163:81/BMS/buildQueryAppFunction"
//网页缓存信息
#define LOADHTMLINFOR [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"querySpringFangYiOffline",VERSION]

//修改密码
#define CHANGEPASSWORDURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"changePwd",VERSION]
//忘记密码
#define FINDPASSWORDURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"findPwd",VERSION]
///统计安装量
#define INSTALLCOUNTURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"install",VERSION]
//升级接口
#define UPDATEURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"update",VERSION]
//获取验证码接口
#define VERIFYCODEURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"simulationVerifyCode",VERSION]
/*
 上传文件接口已弃用
 */
#define UPLOADURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"upLoad",VERSION]
/*
 老版上传接口
 */
#define UPLOADURL2 [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"upLoadFileCommon",VERSION]
/*
 上传重构接口 1.2
 */
#define UPLOADMYFILE [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"upLoadMyFile",version6]

//上传个人信息
#define UPDATEACCOUNTINFOURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"modifyUserInfo",VERSION]
//更新用户签名
#define UPDATEUSERSIGN [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"updateUserSign",VERSION]
//下载个人信息
#define DOWNLOADACCOUNTINFOURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryUserInfo",VERSION]
////忘记密码验证码接口
#define FINDPASSWORDVERCODEURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"verifyCodeForPwd",VERSION]
///获取所有好友
#define FRIENDSLISTURL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"findFriends",VERSION]

///获取离线数据包 (由原不加密改成加密接口)
#define LOADOFFLINEPACKET [NSString stringWithFormat:@"%@app/common/v1.2/%@%@",REQUESTADDRESS,@"upGradeAppPkg",version6]

//查询个人工作
#define QUERYWORKITEMS [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryWorkItems",VERSION]
//查询待办事项
#define QUERYPENDINGITEMS [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryPendingItems",VERSION]
//查询待办事项详情
#define QUERYPENDINGITEMSDETAIL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryPendingWorkDetail",VERSION]
//查询离线待办事项详情
#define QUERYOFFLINEPENDINGI [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryOfflinePendingWorks",VERSION]

//查询工作事项
#define QUERYMYWORKITEMS [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryMyWorkItems",VERSION]
//查询工作对象
#define QUERYWORKSERVICEOBJ [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryWorkServiceObj",VERSION]
//查询工作表单
#define QUERYWORKFORM [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryWorkForm",VERSION]

//查询申报单
#define QUERYFARMERSUBMITFORMS [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryFarmerSubmitForms",VERSION]

//提交日志
#define ADDMYLOG [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"addMyLog",VERSION]

//删除日志
#define DELMYLOG [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"delMyLog",VERSION]
//查询日志
#define QUERYALLMYLOG [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryAllMyLogs",VERSION]
//查询日志详情
#define QUERYMYLOGDETAIL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryMyLogDetail",VERSION]

//查询日志列表 1.2重构版
#define REQUESTLOGLIST [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"queryAllMyLogs",version6]

//查询日志详情 1.2重构版
#define REQUESTLOGDETAIL [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"queryMyLogDetail",version6]

//查询日志评论 1.2重构版
#define REQUESTLOGCOMMENT [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"queryLogComments",version6]
//查询所有日志评论列表 1.2重构版
#define REQUESTALLCOMMENT [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"app/log/v1.2/queryAllLogComments",version6]
//添加日志评论 1.2重构版
#define ADDLOGCOMMENT [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"addLogComment",version6]

//获取用户写日志的日期  1.2重构版
#define QUERYWRITELOGDATE [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"queryWriteLogDate",version6]

//删除日志 1.2重构版
#define DELETELOG [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS_R,@"delMyLog",version6]

//编辑日志
#define EDITMYLOG [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"editMyLog",VERSION]
//查询匹配日志
#define QUERYMATCHLOGS [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryMatchLogs",VERSION]
//查询事项分类
#define QUERYITEMCATEGORYS [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryItemCategorys",VERSION]

//查询直属单位
#define QUERYSUBORDINATEUNIT [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"querySubordinateUnit",VERSION]
//查询直属单位下级人员
#define QUERYSUBORDINATEUNITUSER [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"querySubordinateUnitUser",VERSION]
//查询下级人员日志
#define QUERYEMPLOYEELOG [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryEmployeeLog",VERSION]

//查询归口单位
#define QUERYBELONGDEPT [NSString stringWithFormat:@"%@%@%@",REQUESTADDRESS,@"queryBelongDept",VERSION]

//视频监控
#define QUERYSERVOBJ [NSString stringWithFormat:@"%@%@",VM_IP,@"/afm-jk/monitor-api/serviceobj?"]

//视频监控分组
#define QUERYGROUP [NSString stringWithFormat:@"%@%@",VM_IP,@"/afm-jk/monitor-api/query_group?"]

//视频监控-设备
#define QUERYSERVDEV [NSString stringWithFormat:@"%@%@",VM_IP,@"/afm-jk/monitor-api/devices?"]

//环信消息回执接口
#define HUANXINBACKMESSAGE [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"updateMsgState",version6]

//查询用户基本信息
#define QUERYUSER [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"searchUser",VERSION]

//用户登录
#define CHECKLOGININFO [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"userLoginXmpp",VERSION]
//新用户登录接口
#define NEWCHECKLOGININFO [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"app/personal/v1.2/userLogin",version6]
//删除好友
#define DELFRIEND [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"delFriends",VERSION]
#define QUERYQRCODE [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryQRCode",VERSION]
/*
 查询二维码地址 1.1.1
 */
#define QUERYAPPQRCODE [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"buildAppQRCode",VERSION]

#define QUERYCOPYRIGHT [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryCopyRight",VERSION]

#define QUERYFRIENDS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryFriends",VERSION]
#define QUERYADDFRIENDSHISTORY [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryAddFriendsHistory",VERSION]
#define QUERYUNIONMECHANISMTYPE [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionMechanismType",VERSION]
#define QUERYUNIONUSERGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionUserGroup",VERSION]

#define QUERYUNIONGROUPINFO [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionGroupInofo",VERSION]

#define CREATEUSERGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"createUnionUserGroup",VERSION]
#define JOINUNIONGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"joinUnionGroup",VERSION]
#define JOINMULSESSIONGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"joinMulSessionGroup",VERSION]
#define QUERYUNIONGROUPUSER [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionGroupUser",VERSION]
#define EXITUNIONGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"exitUnionGroup",VERSION]
#define DELUNIONUSERGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"delUnionUserGroup",VERSION]
#define UPDATEUNIONUSERGROUP [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"updateUnionUserGroup",VERSION]

//权限查询
#define QUERYUSERAUTHORITY [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryAllAuth",VERSION]
//#define QUERYUSERAUTHORITY [NSString stringWithFormat:@"%@%@", REQUESTADDRESS,@"queryLogModuleAuth"]
// 查询我的工作圈子
#define QUERYUSERCIRCLE [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUserCircle",VERSION]
#define QueryUnionUserDept [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"QueryUnionUserDept",VERSION]

//我的服务对象
#define QueryMySevObj [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryMyServObj",VERSION]

//我的技术员
#define QueryMyFarmerServers [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryFarmerServers",VERSION]

//详细信息
#define QueryXXXX [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUserInfo",VERSION]

// 查询部门id
#define QUERYDEPTBYUSER [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryDeptByUser",VERSION]
// 查询联盟圈组织结构
#define QUERYUNIONORG [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"QueryUnionOrg",VERSION]
// 权限  查询联盟圈组织结构
#define QUERYUNIONORGQUANXIAN [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryOrgTree",VERSION]
// 查询联盟圈好友
#define QUERYUNIONFRIENDS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionFriends",VERSION]
// 联盟圈发送消息

// 查询圈子信息
#define QUERYCIRCLEINFOR [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryCircleInfor",VERSION]
// 查询圈子成员
#define QUERYCIRCLEUSERS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryCircleUsers",VERSION]

#define QUERYORGUSER [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryOrgUser",VERSION]

//#define QUERYORGUSERT [NSString stringWithFormat:@"%@%@", REQUESTADDRESS,@"queryUnionGroupUser"]
// 查询地区
#define QUERYUNIONAREA [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionArea",VERSION]
// 查询圈子聊天历史
#define QUERYCHATHISTORY [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryChatHistory",VERSION]
// 查询专业技能
#define QUERYUNIONPROSKILL [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionProSkill",VERSION]
// 条件查询好友
#define QUERYUNIONORGUSER [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"queryUnionOrgJg",VERSION]
#define QUERYUNIONORGJGUSERS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"QueryUnionOrgJgUsers",VERSION]
// 添加好友
#define ADDUNIONFRIENDS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"addFriendRequest",VERSION]
// 同意申请
#define ADDFRIENDS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"addFriendResponse",VERSION]
//检查设备有效性接口
#define CHECKUSEREQU [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS,@"checkUserEqu",VERSION]

///userdefault 标识符
#define DEVICEPUSHTOKEN @"devicepushtoken"


//临时
///查看监管工作统计
//#define JAINGUANGONGZUOTONGJI @"view_log_tongji"
/////查看部门人员日志view_deptuser_worklog
//#define BUMENRENYUANRIZHI @"view_log_branch"
/////查看直属单位日志
//#define ZHISHUDANWEIRIZHI @"view_log_dirdept"


///查看监管工作统计
#define JAINGUANGONGZUOTONGJI @"view_jianguan_statistic"
///查看部门人员日志view_deptuser_worklog
#define BUMENRENYUANRIZHI @"view_deptuser_worklog"
///查看直属单位日志
#define ZHISHUDANWEIRIZHI @"view_dirdept_worklog"
///查看归口单位日志
#define GUIKOUDANWEIRIZHI @"view_belongdept_worklog"

///本部门聊天
#define ZUZHIJIGOU @"chat_with_selfdept"
///上级直属机构聊天
#define SHANGJIZHISHU @"chat_with_updirdept"
///上级归口机构聊天
#define SHANGJIGUIKOU @"chat_with_upbelongdept"
///同级直属机构聊天
#define TONGJIZHISHU @"chat_with_equivdirdept"
///下级直属机构聊天
#define ZHISHUDANWEI @"chat_with_dirdept"
///下级归口机构聊天
#define GUIKOUDANWEI @"chat_with_belongdept"
///大权限
#define DAQUANXIAN @"chat_with_app_dept_dir"
///专业群组/圈子聊天
//#define ZHUANYEQUNZU @"chat_with_groupuser"
//与服务对象聊天  chat_with_serviceobj

///进行判断的两个title
#define FORGETPASSWORDTITLE @"忘记密码"
#define REGISTTITLE @"注册"

#endif
