//
//  NSDate+MAFChickDate.h
//  MAF
//
//  Created by nqkj on 2018/6/27.
//  Copyright © 2018年 崔祥莉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MAFChickDate)

//比较两个日期大小
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate;

//获取当地时间
+ (NSString *)getCurrentTime;

//获取当地月份
+ (NSString *)getCurrentMonth;

+(NSString *)getTheDayOfTheWeekByDateString:(NSString *)dateString firstWeekDay:(BOOL)firstWeekDay;

// 获取本周开始结束时间
+ (NSString *)getWeekBeginAndEndWith:(NSDate *)newDate firstWeekDay:(BOOL)firstWeekDay;

// 获取本月开始结束时间
+ (NSString *)getMonthBeginAndEndWith:(NSDate *)newDate firstMonth:(BOOL)firstMonth;

// 获取前后一个月的日期
+(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month firstMonth:(BOOL)firstMonth;

// 获取上月开始结束时间
+ (NSString *)getPriousorWithFirstMonth:(BOOL)firstMonth;

// 获取上周时间
+(NSString *)getPreWeekTimeWithFirstWeekDay:(BOOL)firstWeekDay;

// 获取昨天时间
+ (NSString *)getYesterdayDay;

@end
