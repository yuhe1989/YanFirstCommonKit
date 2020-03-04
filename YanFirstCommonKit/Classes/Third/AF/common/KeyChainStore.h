//
//  KeyChainStore.h
//  MAF
//
//  Created by ctnq on 16/7/15.
//  Copyright © 2016年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;

@end
