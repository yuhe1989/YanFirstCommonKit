//
//  MAFMySecurity.m
//  MAF
//
//  Created by ctnq on 16/6/8.
//  Copyright © 2016年 ctnq. All rights reserved.
//

#import "MAFMySecurity.h"
#import "SecurityUtil.h"
#import "WQMD5.h"
#import "YYModel.h"
#import "MAFExpDate.h"
#import "MAFConfig.h"
#import "MAFCommonClass.h"

@implementation MAFMySecurity
+(NSString *)doSign:(NSDictionary *)dict{
    NSString *str = [SecurityUtil encryptAESData:[self dictKeySort:dict from:@"sign"] app_key:@"ctnq12316encrypt"];
    NSString *sign = [WQMD5 md5:str];
    return sign;
}
+(NSString *)dictToStringEncryption:(NSDictionary *)dict{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self doSign:dict],@"sign_data",[self dictKeySort:dict from:@"data"],@"pro_data",@"1",@"app_type",COMMONCLASS.PlatCode,@"app_platcode",COMMONCLASS.appVersion,@"app_version",CURRENTTIME,@"time_stmap",nil];
    NSLog(@"======= encrydic:  %@", dic);
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}
/**
 字典加密 不过滤空格
 */
+(NSString *)dictToStringNoSpaceEncryption:(NSDictionary *)dict{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self doSign:dict],@"sign_data",[self dictKeySort:dict from:@"data"],@"pro_data",@"1",@"app_type",COMMONCLASS.PlatCode,@"app_platcode",COMMONCLASS.appVersion,@"app_version",CURRENTTIME,@"time_stmap",nil];
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr2 = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}
+(NSString *)dictKeySort:(NSDictionary*)dict from:(NSString *)from{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    if ([from isEqualToString:@"sign"]) {
        for (NSString *categoryId in sortedArray) {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
        }
        NSArray *a =  [contentString componentsSeparatedByString:@"&"];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:a];
        [arr removeLastObject];
        NSString *s = [arr componentsJoinedByString:@"&"];
        return s;
    } else {
        for (NSString *categoryId in sortedArray) {
            [contentString appendFormat:@"\"%@\":\"%@\",", categoryId, [dict valueForKey:categoryId]];
        }
        NSArray *a =  [contentString componentsSeparatedByString:@","];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:a];
        [arr removeLastObject];
        NSString *tmpStr = [NSString stringWithFormat:@"{%@}",[arr componentsJoinedByString:@","]];
        NSString * s = [tmpStr stringByReplacingOccurrencesOfString:@";" withString:@","];
        return s;
    }
}
#pragma mark - 字典加密
+(NSString *)dictWithDicToStringEncryption:(NSDictionary *)dict{
    NSDictionary *pg = [dict valueForKey:@"pg"];
    NSString *pgStr = [self dictWithDicKeySort:pg from:@"data"];
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [newDic setDictionary:dict];
    [newDic removeObjectForKey:@"pg"];
    [newDic setValue:pgStr forKey:@"pg"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self doSignWithDic:newDic],@"sign_data",[self dictWithDicKeySort:newDic from:@"data"],@"pro_data",@"1",@"app_type",COMMONCLASS.PlatCode,@"app_platcode",COMMONCLASS.appVersion,@"app_version",CURRENTTIME,@"time_stmap",nil];
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}
+(NSString *)doSignWithDic:(NSDictionary *)dict{
    NSString *str = [SecurityUtil encryptAESData:[self dictWithDicKeySort:dict from:@"sign"] app_key:@"ctnq12316encrypt"];
    NSString *sign = [WQMD5 md5:str];
    return sign;
}
+(NSString *)dictWithDicKeySort:(NSDictionary*)dict from:(NSString *)from{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    if ([from isEqualToString:@"sign"]) {
        for (NSString *categoryId in sortedArray) {
            if([categoryId isEqualToString:@"pg"]) {
                [contentString appendFormat:@"%@=%@&", categoryId, @""];
            } else {
                [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
            }
        }
        NSArray *a =  [contentString componentsSeparatedByString:@"&"];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:a];
        [arr removeLastObject];
        NSString *s = [arr componentsJoinedByString:@"&"];
        return s;
    } else {
        for (NSString *categoryId in sortedArray) {
            if ([categoryId isEqualToString:@"user_mobile"]) {
                [contentString appendFormat:@"%@:\"%@\",", categoryId, [dict valueForKey:categoryId]];
            } else {
                [contentString appendFormat:@"%@:%@,", categoryId, [dict valueForKey:categoryId]];
            }
        }
        NSArray *a =  [contentString componentsSeparatedByString:@","];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:a];
        [arr removeLastObject];
        NSString *tmpStr = [NSString stringWithFormat:@"{%@}",[arr componentsJoinedByString:@","]];
        NSString * s = [tmpStr stringByReplacingOccurrencesOfString:@";" withString:@","];
        return s;
    }
}
#pragma mark - 数组加密
+(NSString *)dictWithArrToStringEncryption:(NSDictionary *)dict{
    // NSDictionary *userDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"fullUserInfo"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self doSignWithArr:dict],@"sign_data",
                         [self dictWithArrKeySort:dict from:@"data"],@"pro_data",
                         @"1",@"app_type",
                         COMMONCLASS.PlatCode,@"app_platcode",
                         COMMONCLASS.appVersion,@"app_version",
                         CURRENTTIME,@"time_stmap",nil];
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}
+(NSString *)doSignWithArr:(NSDictionary *)dict{
    NSString *str = [SecurityUtil encryptAESData:[self dictWithArrKeySort:dict from:@"sign"] app_key:@"ctnq12316encrypt"];
    NSLog(@"%@",[self dictWithArrKeySort:dict from:@"sign"] );
    NSString *sign = [WQMD5 md5:str];
    return sign;
}
+(NSString *)dictWithArrKeySort:(NSDictionary*)dict from:(NSString *)from {
    NSMutableString *contentString  =[NSMutableString string];
    NSMutableString *listString = [NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    if ([from isEqualToString:@"sign"]) {
        for (NSString *categoryId in sortedArray) {
            NSObject *obj = [dict objectForKey:categoryId];
            if ([obj isKindOfClass:[NSArray class]]) {
                [contentString appendFormat:@"%@=%@&", categoryId, @""];
            }else {
                [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
            }
        }
        NSArray *a =  [contentString componentsSeparatedByString:@"&"];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:a];
        [arr removeLastObject];
        NSString *s = [arr componentsJoinedByString:@"&"];
        return s;
    } else {
        for (NSString *categoryId in sortedArray) {
            NSObject *obj = [dict objectForKey:categoryId];
            if ([obj isKindOfClass:[NSArray class]]) {
                [listString deleteCharactersInRange:NSMakeRange(0, listString.length)];
                NSArray *dataArr = [dict objectForKey:categoryId];
                for (int i=0; i<dataArr.count; i++) {
                    NSDictionary *dic = [dataArr objectAtIndex:i];
                    BOOL isHaveArr = NO;
                    for (NSString *key in [dic allKeys]) {
                        if ([dic[key] isKindOfClass:[NSArray class]]) {
                            isHaveArr = YES;
                        }
                    }
                    if(i == dataArr.count - 1){
                        
                        if (isHaveArr) {
                            [listString appendFormat:@"%@",[self dictWithArrKeySort:dic from:@"data"]];
                        } else {
                            [listString appendFormat:@"%@",[self dictKeySort:dic from:@"data"]];
                        }
                    }else{
                        if (isHaveArr) {
                            [listString appendFormat:@"%@,",[self dictWithArrKeySort:dic from:@"data"]];
                        } else {
                            [listString appendFormat:@"%@,",[self dictKeySort:dic from:@"data"]];
                        }
                    }
                }
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    dict = [NSMutableDictionary dictionaryWithDictionary:dict];
                }
                [dict setValue:[NSString stringWithFormat:@"[%@]",listString] forKey:categoryId];
                [contentString appendFormat:@"\"%@\":%@,", categoryId, [dict valueForKey:categoryId]];
            }else {
                [contentString appendFormat:@"\"%@\":\"%@\",", categoryId, [dict valueForKey:categoryId]];
            }
        }
        NSArray *a =  [contentString componentsSeparatedByString:@","];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:a];
        [arr removeLastObject];
        NSString *tmpStr = [NSString stringWithFormat:@"{%@}",[arr componentsJoinedByString:@","]];
        NSString * s = [tmpStr stringByReplacingOccurrencesOfString:@";" withString:@","];
        return s;
    }
}
#pragma mark 数组加密  不过滤空格
/**
 不过滤空格的数组加密
 */
+(NSString *)dictWithArrToStringNoSpaceEncryption:(NSDictionary *)dict {
    // NSDictionary *userDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"fullUserInfo"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self doSignWithArr:dict],@"sign_data",
                         [self dictWithArrKeySort:dict from:@"data"],@"pro_data",
                         @"1",@"app_type",
                         COMMONCLASS.PlatCode,@"app_platcode",
                         COMMONCLASS.appVersion,@"app_version",
                         CURRENTTIME,@"time_stmap",nil];
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr2 = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}
#pragma mark - 发送带空格信息
+(NSString *)dictToBlankStringEncryption:(NSDictionary *)dict {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self doSign:dict],@"sign_data",[self dictKeySort:dict from:@"data"],@"pro_data",@"1",@"app_type",COMMONCLASS.PlatCode,@"app_platcode",COMMONCLASS.appVersion,@"app_version",CURRENTTIME,@"time_stmap",nil];
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr2 = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}

#pragma mark 数组与字典同级 不过滤空格
/**
 不过滤空格的数组加密
 */
+(NSString *)dictAndArrSiblingToStringNoSpaceEncryption:(NSDictionary *)dict {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[self dictAndArrSiblingdoSignWithArr:dict],@"sign_data",
                         [self dictAndArrSiblingKeySort:dict from:@"data"],@"pro_data",
                         @"1",@"app_type",
                         COMMONCLASS.PlatCode,@"app_platcode",
                         COMMONCLASS.appVersion,@"app_version",
                         CURRENTTIME,@"time_stmap",nil];
    NSString * jsonStr =[dic yy_modelToJSONString];
    NSString * jsonStr2 = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *s =[SecurityUtil encryptAESData:jsonStr2 app_key:@"ctnq12316encrypt"];
    return s;
}
+(NSString *)dictAndArrSiblingdoSignWithArr:(NSDictionary *)dict{
    NSString *str = [SecurityUtil encryptAESData:[self dictAndArrSiblingKeySort:dict from:@"sign"] app_key:@"ctnq12316encrypt"];
    NSLog(@"%@",[self dictAndArrSiblingKeySort:dict from:@"sign"] );
    NSString *sign = [WQMD5 md5:str];
    return sign;
}
#pragma mark - 发送字典与数组同级的参数
+(NSString *)dictAndArrSiblingKeySort:(NSDictionary*)dict from:(NSString *)from {
    NSMutableString *contentString  =[NSMutableString string];
    NSMutableString *listString = [NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    if ([from isEqualToString:@"sign"]) {
        for (NSString *categoryId in sortedArray) {
            NSObject *obj = [dict objectForKey:categoryId];
            if ([obj isKindOfClass:[NSArray class]]) {
                [contentString appendFormat:@"%@=%@&", categoryId, @""];
            }else if ([obj isKindOfClass:[NSDictionary class]]) {
                [contentString appendFormat:@"%@=%@&", categoryId, @""];
            } else {
                [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
            }
        }
        NSArray *a =  [contentString componentsSeparatedByString:@"&"];
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:a];
        [arr removeLastObject];
        NSString *s = [arr componentsJoinedByString:@"&"];
        return s;
    } else {
        for (NSString *categoryId in sortedArray) {
            NSObject *obj = [dict objectForKey:categoryId];
            if ([obj isKindOfClass:[NSArray class]]) {
                [listString deleteCharactersInRange:NSMakeRange(0, listString.length)];
                NSArray *dataArr = [dict objectForKey:categoryId];
                for (int i=0; i<dataArr.count; i++) {
                    NSDictionary *dic = [dataArr objectAtIndex:i];
                    BOOL isHaveArr = NO;
                    for (NSString *key in [dic allKeys]) {
                        if ([dic[key] isKindOfClass:[NSArray class]]) {
                            isHaveArr = YES;
                        }
                    }
                    if(i == dataArr.count - 1){
                        
                        if (isHaveArr) {
                            [listString appendFormat:@"%@",[self dictWithArrKeySort:dic from:@"data"]];
                        } else {
                            [listString appendFormat:@"%@",[self dictKeySort:dic from:@"data"]];
                        }
                    }else{
                        if (isHaveArr) {
                            [listString appendFormat:@"%@,",[self dictWithArrKeySort:dic from:@"data"]];
                        } else {
                            [listString appendFormat:@"%@,",[self dictKeySort:dic from:@"data"]];
                        }
                    }
                }
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    dict = [NSMutableDictionary dictionaryWithDictionary:dict];
                }
                [dict setValue:[NSString stringWithFormat:@"[%@]",listString] forKey:categoryId];
                [contentString appendFormat:@"\"%@\":%@,", categoryId, [dict valueForKey:categoryId]];
            }else if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary *)obj;
                BOOL isHaveArr = NO;
                for (NSString *key in [dic allKeys]) {
                    if ([dic[key] isKindOfClass:[NSArray class]]) {
                        isHaveArr = YES;
                    }
                }
                
                if (isHaveArr) {
                    [listString appendFormat:@"%@",[self dictWithArrKeySort:dic from:@"data"]];
                } else {
                    [listString appendFormat:@"%@",[self dictKeySort:dic from:@"data"]];
                }
                
                [dict setValue:[NSString stringWithFormat:@"%@",listString] forKey:categoryId];
                [contentString appendFormat:@"\"%@\":%@,", categoryId, [dict valueForKey:categoryId]];
            } else {
                [contentString appendFormat:@"\"%@\":\"%@\",", categoryId, [dict valueForKey:categoryId]];  
            }
        }
        NSArray *a =  [contentString componentsSeparatedByString:@","];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:a];
        [arr removeLastObject];
        NSString *tmpStr = [NSString stringWithFormat:@"{%@}",[arr componentsJoinedByString:@","]];
        NSString * s = [tmpStr stringByReplacingOccurrencesOfString:@";" withString:@","];
        return s;
    }
}


@end
