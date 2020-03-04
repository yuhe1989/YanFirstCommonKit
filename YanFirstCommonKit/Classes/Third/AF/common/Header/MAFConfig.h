//
//  Config.h
//  金农e信
//
//  Created by victor on 13-7-27.
//  Copyright (c) 2013年 GAEC. All rights reserved.
//

#ifndef __e__Config_h
#define __e__Config_h

#import "MAFCommonClass.h"
#import "MAFExpDate.h"

//九宫格：grid
//侧边栏：sidebar
//底部栏：bottombar

//几种样式
#define BOTTOMBAR @"bottombar"
#define SIDEBAR @"sidebar"
#define GRID @"gird"

///设置导航颜色       --- 同样是全局色系
#define NAVIGATION_BACKGROUND_COLOR [UIColor colorWithRed:135.0/255.0 green:190.0/255.0 blue:26.0/255.0 alpha:1.0]

// 设置导航字体大小
#define NAVIGATION_FONT_SIZE 18

// 设置nav返回按钮间距
#define NAVIGATION_LEFT_INTERVAL -17

// 设置nav右边按钮间距
#define NAVIGATION_RIGHT_INTERVAL 20

///设置视图背景颜色
#define BACKGROUND_COLOR [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]

///设置绿色图标的颜色
#define GREEN_BUTTON_COLOR [UIColor colorWithRed:135.0/255.0 green:190.0/255.0 blue:26.0/255.0 alpha:1.0]

///设置红色的图标的颜色
#define RED_BUTTON_COLOR [UIColor colorWithRed:238.0/255.0 green:67.0/255.0 blue:31.0/255.0 alpha:1.0]

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

///定义screen的高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height-64

///获取appdelegate
#define APPDELEGATE ((MAFAppDelegate *)[[UIApplication sharedApplication] delegate])

///获取commonClass
#define COMMONCLASS [MAFCommonClass shareCommonClass]

// 获取 MAFBuildEngineClass
#define BuildEngineClass [MAFBuildEngineClass shareBuildEngineClass]

///进行调试的时候才能输出log 上线之后改为0
#define DEBUG_ANALYTICS_MANAGER 0

///ios6和IOS7运行不同的代码
#define CHECKIOS6OR7(IOS6,IOS7) \
if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) { \
IOS6 \
} else { \
IOS7 \
}

//提示信息 要内存释放
#define ALTERVIEW_RELEASE(Message) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:Message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert    show];\
[alert    release];\

//提示消息
#define ALTERVIEW(Message) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:Message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alert    show];\

//定位提示消息
#define DALTERVIEW(Message) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"签到失败" message:Message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];\
[alert    show];\

//定位提示消息
#define CALTERVIEW(Message) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:Message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];\
[alert    show];\

//定位提示消息
#define EALTERVIEW(Message) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务已关闭" message:Message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];\
[alert    show];\

//检查是iphone5吗
#define CHECKIPHONE5 [UIScreen mainScreen].bounds.size.height >480?YES:NO

//image取值
#define IMAGEPLIST @"MAFImageList.plist"
#define IMAGED(name) [UIImage imageNamed:name]

#define kResponseObject     [responseObject[@"code"] containsString:@"0000"]

//rect的坐标
#define MAKERECT(x,y,w,h) [COMMONCLASS makeRect:CGRectMake(x,y,w,h)]

//检查网络
#define CHECKNETWORK if (![CheckNetwork isExistenceNetwork]) {return;}

#define CHECKNETWORKT [CheckNetwork isExistenceNetworkTwo]

/// 返回按钮
#define BACKBUTTON_ACTION_goBack UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, 35, 35)];\
[backBtn setImage:IMAGED(@"navigation_back") forState:UIControlStateNormal];\
[backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];\
UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];\
self.navigationItem.leftBarButtonItem = leftBtn;\

//是不是iphone5
#define ISIPHONE5 [UIScreen mainScreen].bounds.size.height>480.0

// 获取批次号
#define GetBatch [MAFExpDate getBatch]
// 获取增加6位后的批次号
#define GetSixBatch(Batch) [MAFExpDate getSixBatchWithBatch:Batch]
//现在时间
#define CURRENTTIME [MAFExpDate getCurrentDate]
#define CURRENTTIME1 [MAFExpDate getCurrentDate1]
#define CURRENTTIME2 [MAFExpDate getCurrentDate2]
#define CURRENTTIME3 [MAFExpDate getCurrentDate3]
#define CURRENTTIME4 [MAFExpDate getCurrentDate4]
#define CURRENTTIME5 [MAFExpDate getCurrentDate5]
#define CURRENTTIME6_YEAR [MAFExpDate getYearDate]
#define CURRENTTIME7_MONTH [MAFExpDate getMonthDate]
#define CURRENTTIME8_Y_M [MAFExpDate getYearMonthDate]

#define APP_CONFIG @"app_config.xml"

#define TPL_ZAKER @"zaker"

#define TPL_GOLDEN @"tpl_golden"

#define TPL_GREEN @"tpl_green"

#define TPL_ZAKER_BLUE @"zaker_blue"

#define TPL_ZAKER_ORIANGE @"zaker_orange"

#define TPL_COLOR @"tpl_color"

#define WARNNING_STR @"提醒"

#define ENTER_STR @"确认"

#define CANCEL_STR @"取消"

#define IS_ALREADY_NEW_VERSION_STR @"已经是最新版本"

#define FAIL_CHECK_UPDATA_STR @"检查更新失败"

#define HAVE_NEW_VERSION_STR @"本机构客户端有新的更新，请用户更新。"

#define FIRSTUSE @"firstUse"

#define ZERO @"0"

#define ONE @"1"

#define TWO @"2"

#define THREE @"3"

#define FOUR @"4"

#define FIVE @"5"

#define SIX @"6"

#define SEVEN @"7"

#define EIGHT @"8"

#define NIGHT @"9"

#define TEN @"10"

#define FIFTEEN @"15"

#define MAF_BACK_IMAGE_NAME @"navigation_back"

#define BACK_BUTTON_FRAME CGRectMake(0, 0, 35, 35)

//分享项目
#define FOUNT @"调整字号"
#define SHARE @"分享"
#define FAVOURTE @"收藏"
#define REFRESH @"刷新"
#define OPENSAFAIR @"Safari打开"

///收到的信息类型
#define VOICETYPE @"voice"
#define PICTURETYPE @"picture"
#define VEDIOTYPE @"vedio"
#define MESSAGETYPE @"message"


//离线DB的key类型
#define SPRING_DB  @"springDb"
#define BISHAN_DB  @"bishanDb"
#define OFFLINE_DB @"offlineDb"

/////网络请求配置/////
//开关打开为内网环境 关闭为现网环境
// 0 现网  1 内网
#define DEBUG_SWITCH 0

#define version1 @"?v=1"
#define version2 @"?v=2"
#define version3 @"?v=3"
#define version4 @"?v=4"
#define version5 @"?v=5"
#define version6 @"?v=6"
/**
 版本号
 */
#define VERSION version5

/**
 接口地址
 */
//http://222.173.29.163:81/AFMIS/
//http://192.168.1.50:8318/AFMIS/
#if DEBUG_SWITCH
#define REQUESTADDRESS  @"http://222.173.29.163:81/AFMIS/"
//#define REQUESTADDRESS @"http://192.168.1.33:8082/AFMIS2/"
#define REQUESTADDRESS_R @"http://222.173.29.163:81/AFMIS/"
//#define REQUESTADDRESS_R @"http://192.168.1.129:8080/AFMIS2/"
#else
#define REQUESTADDRESS  @"http://12316yun.net/AFMIS/"
#define REQUESTADDRESS_R @"http://12316yun.net/AFMIS/"
#endif

/**
 表单地址
 */
#if DEBUG_SWITCH
#define BIAODANWANG @"http://222.173.29.163:81/AFMMobile/"
#else
#define BIAODANWANG @"http://12316yun.net/AFMMobile/"
#endif

/**
 ZIP包
 */
#if DEBUG_SWITCH
#define ZIP @"wwwtest"
#else
#define ZIP @"www"
#endif

/**
 定位信息上传
 */
#if DEBUG_SWITCH
#define IPT @"http://222.173.29.164:8068"
#else
#define IPT @"http://12316yun.net"
#endif

/**
 视频监控
 */
#if DEBUG_SWITCH
#define VM_IP @"http://192.168.1.147:8320"
#else
#define VM_IP @"http://12316yun.net"
#endif

/**
 XMPP
 */
#if DEBUG_SWITCH
#define SERVER @"222.173.29.165"
#define KHOSTPORT 5333
#else
#define SERVER @"mobile.12316yun.net"
#define KHOSTPORT 5222
#endif

//环信
//申请应用时的appkey
#if DEBUG_SWITCH
#define EaseMobAppKey @"bjctnq#12316fangzhen"
#else
#define EaseMobAppKey @"bjctnq#12316"
#endif
//需要使用的APNS证书名字(需要与后台上传时的APNS证书名字相同, 客户端打包时的证书, 需要与服务器后台的证书一一对应)
#define EaseMobAPNSCertName @"test"
//用户密码
#define EaseMobPassword @"02ce3adfe27b737ea466b83f3a240db6"

#define TalkingDataAppId @"5F062704DC90587C4F4F114B9BFD5F09"
#define TalkingDataChannelId @"ios"

//瞩目
#define ZhumuDomain @"launcher.zhumu.me"
#define ZhumuAppKey @"poOjsbpyWOEZksgATQpGebAGvYcSwxEy8sKq"
#define ZhumuAppSecret @"X69MVU0EuqOcwSaYhds2BhZDR079NsnojYVP"
#define ZhumuApiKey @"3575CD1E143E2B15A436B570BF6758BA"
#define ZhumuApiSecret @"A58636D57135589663742CBA7B52964A"
#define ZhumuAuthURL @"https://api.zhumu.me/v1/user/get"

#define KScreenHeight       [UIScreen mainScreen].bounds.size.height
#define KScreenWidth        [UIScreen mainScreen].bounds.size.width

#endif



