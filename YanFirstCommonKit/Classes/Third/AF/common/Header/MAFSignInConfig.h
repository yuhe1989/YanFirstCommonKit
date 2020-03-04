//
//  MAFSignInConfig.h
//  MAF
//
//  Created by 王涛 on 17/2/13.
//  Copyright © 2017年 ctnq. All rights reserved.
//

//查询用户班次
#define QUERYSIGNCLASS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"querySignClss",version6]
/*
 查询用户班次,新接口,改变判断逻辑,不以data是否为空判断是否有班次,新加字段来判断,并且返回数据中新增设备信息
 gaos.0420
 */
#define QUERYSIGNNEWCLASS [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"querySignClssInfo",version6]

#define QUERYMYTRAIL [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"queryMyTrail",version6]

#define SIGNONWORK [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"signOnWork",version6]

#define SIGNOUTWORK [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"signOutWork",version6]

#define APPEALWORK [NSString stringWithFormat:@"%@%@%@", REQUESTADDRESS_R,@"signExplain",version6]
