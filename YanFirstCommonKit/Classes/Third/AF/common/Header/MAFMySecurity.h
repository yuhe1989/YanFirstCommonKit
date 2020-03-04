//
//  MAFMySecurity.h
//  MAF
//
//  Created by ctnq on 16/6/8.
//  Copyright © 2016年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFMySecurity : NSObject

+(NSString *)dictToStringEncryption:(NSDictionary *)dict;
/**
 字典加密 不过滤空格
 */
+(NSString *)dictToStringNoSpaceEncryption:(NSDictionary *)dict;

+(NSString *)dictWithDicToStringEncryption:(NSDictionary *)dict;

+(NSString *)dictWithArrToStringEncryption:(NSDictionary *)dict;
//发送带有空格的消息加密
+(NSString *)dictToBlankStringEncryption:(NSDictionary *)dict;
#pragma mark 数组加密  不过滤空格
/**
 不过滤空格的数组加密
 */
+(NSString *)dictWithArrToStringNoSpaceEncryption:(NSDictionary *)dict;

#pragma mark 数组与字典同级 不过滤空格
/**
 不过滤空格的数组加密
 */
+(NSString *)dictAndArrSiblingToStringNoSpaceEncryption:(NSDictionary *)dict;


@end
