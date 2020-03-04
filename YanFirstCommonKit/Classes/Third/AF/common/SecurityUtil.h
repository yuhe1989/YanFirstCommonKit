//
//  CryptoUtils.h
//  client
//
//  Created by dang on 15-3-2.
//  Copyright (c) 2015年 zhidong. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const AUTHORITYKEY = @"JcVXP8ADJcVXP8AD";

@interface SecurityUtil : NSObject 

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
//将string转成带密码的data
+ (NSString*)encryptAESData:(NSString*)string app_key:(NSString*)key ;
+(NSData*)encryptAESData1:(NSString*)string app_key:(NSString*)key;
//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data app_key:(NSString*)key ;


@end
