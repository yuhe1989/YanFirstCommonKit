//
//  MAFExpDate.h
//  MAF
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFExpDate : NSObject
/**
 *  获取当前日期
 *
 *  @param dateFormat 日期格式
 *
 *  @return 返回当前日期
 */
+ (NSDate *)getCurrentDate:(NSString *)dateFormat;

/**
 *  获取当前日期
 *
 *  @param dateFormat 日期格式（默认格式为yyyyMMddHHmmss）
 *
 *  @return 根据格式返回当前日期(NSString类型)
 */
+ (NSString *)getCurrentDate;
+ (NSString *)getCurrentDate1;
+ (NSString *)getCurrentDate2;
+ (NSString *)getCurrentDate3;
+ (NSString *)getCurrentDate4;
+ (NSString *)getCurrentDate5;
+ (NSString *)getYearDate;
+ (NSString *)getMonthDate;
+ (NSString *)getYearMonthDate;
+ (NSString *)getCurrentDateString:(NSString *)dateFormat;

/**
 *  将日期转化为NSString
 *
 *  @param date       要转化的日期
 *  @param dateFormat 格式(如果格式为空，默认为原来date的格式)
 *
 *  @return NSString 类型的日期
 */
+ (NSString *)dateToString:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *  将NSString类型转化为NSDate类型日期
 *
 *  @param dateString NSString 类型日期
 *  @param dateFormat 日期格式(为空则默认为yyyyMMddHHmmss)
 *
 *  @return NSDate
 */
+ (NSDate *)stringToDate:(NSString *)dateString dateFormat:(NSString *)dateFormat;
/**
 *  字符串日期转化为特定格式的字符串类型日期
 *
 *  @param date       NSString 类型的日期
 *  @param dateFormat 转化格式
 *
 *  @return 特定格式的日期
 */
+ (NSString *)stringToString:(NSString *)date dateFormat:(NSString *)dateFormat;
/**
 *  日期转化为特定格式的日期
 *
 *  @param date       日期
 *  @param dateFormat 转化格式
 *
 *  @return 特定格式的日期
 */
+ (NSDate *)dateToDate:(NSDate *)date dateFormat:(NSString *)dateFormat;
/**
 *  某个日期距离现在的时间
 *
 *  @param date 日期
 *
 *  @return 距离现在的时间
 */
+ (NSString *)distanceToNow:(NSString *)date;
/**
 获取批次信息
 */
+ (NSString *)getBatch;
+ (NSString *)getSixBatchWithBatch:(NSString *)batch;


+ (NSString *)distanceToNow:(NSString *)date DateFormat:(NSString*)dateFormat;
@end
