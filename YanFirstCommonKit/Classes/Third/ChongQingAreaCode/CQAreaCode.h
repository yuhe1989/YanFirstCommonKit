//
//  CQAreaCode.h
//  MAF
//
//  Created by joy 尹 on 2019/12/11.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQAreaCode : NSObject


/**
 单例

 @return 只用于 .txt 文件加载
 */
+ (instancetype)shareAreaCode;

//地区
@property (nonatomic, copy) NSDictionary * areaDict;

/**
 获取重庆列表 .txt

 @param levelCode 所在位置code
 @return 所在位置包含的位置list
 */
- (NSArray *)getChongQingAreaCodeWithLevelCode:(NSString *)levelCode;



/**
 获取省份

 @param levelCode 省传 @"1" 其他地区传父类code
 @param isSheng
 @return 省市区县等
 */
+ (NSArray *)getAreaDataDBWithLevelCode:(NSString *)code isSheng:(BOOL)isSheng;


/**
 获取其他市区县等  弃用

 @param parentCode 父类areacode
 @return 市区县等
 */
+ (NSArray *)getAreaDataDBWithParentCode:(NSString *)parentCode DEPRECATED_MSG_ATTRIBUTE("Please use [getAreaDataDBWithLevelCode:isSheng:]");

/**
 获取组
 
 @param areaCode 父类areaCode
 @return 组
 */
+ (NSArray *)getZuAreaDataDBWithParentCode:(NSString *)areaCode;


@end

NS_ASSUME_NONNULL_END
