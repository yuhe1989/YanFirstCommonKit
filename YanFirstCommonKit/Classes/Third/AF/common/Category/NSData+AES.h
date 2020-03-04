//
//  CryptoUtils.h
//  client
//
//  Created by dang on 15-3-2.
//  Copyright (c) 2015年 zhidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES128EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key;   //解密

@end
