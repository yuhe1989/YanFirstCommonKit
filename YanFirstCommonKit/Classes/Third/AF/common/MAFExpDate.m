//
//  MAFExpDate.m
//  MAF
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 ctnq. All rights reserved.
//

#import "MAFExpDate.h"

#define ISEMPTY(STR) (STR == nil || [STR isEqualToString:@""])

#define DaxieStr @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]
#define XiaoxieStr @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"]
#define Num @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]

@implementation MAFExpDate

+ (NSDate *)getCurrentDate:(NSString *)dateFormat{
    NSString *dateString = [MAFExpDate getCurrentDateString:dateFormat];
    return [MAFExpDate stringToDate:dateString dateFormat:dateFormat];
    
}

+ (NSString *)getCurrentDate
{
    return [MAFExpDate getCurrentDateString:@"yyyyMMddHHmmss"];
}
+ (NSString *)getCurrentDate1
{
    return [MAFExpDate getCurrentDateString:@"yyyyMMdd"];
}
+ (NSString *)getCurrentDate2
{
    return [MAFExpDate getCurrentDateString:@"yyyyMMddHHmm"];
}
+ (NSString *)getCurrentDate3
{
    return [MAFExpDate getCurrentDateString:@"yyyy-MM-dd HH:mm:ss"];
}
+ (NSString *)getCurrentDate4 {
    return [MAFExpDate getCurrentDateString:@"yyyy-MM-dd"];
}
+ (NSString *)getCurrentDate5 {
    return [MAFExpDate getCurrentDateString:@"yyyy-MM-dd HH:mm"];
}
+ (NSString *)getYearDate {
    return [MAFExpDate getCurrentDateString:@"yyyy"];
}
+ (NSString *)getMonthDate {
    return [MAFExpDate getCurrentDateString:@"MM"];
}
+ (NSString *)getYearMonthDate {
    return [MAFExpDate getCurrentDateString:@"yyyy-MM"];
}

+ (NSString *)getCurrentDateString:(NSString *)dateFormat{
    NSDate *date = [NSDate date];
    if (ISEMPTY(dateFormat)) {
        dateFormat = @"yyyyMMddHHmmss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateToString:(NSDate *)date dateFormat:(NSString *)dateFormat{
    if (ISEMPTY(dateFormat)) {
        dateFormat = @"yyyyMMddHHmmss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)stringToDate:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    if (ISEMPTY(dateFormat)) {
        dateFormat = @"yyyyMMddHHmmss";
    }    
    [dateFormatter setDateFormat:dateFormat];
    //[dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"] ] ;
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDate *temp = [dateFormatter dateFromString:dateString];
    return temp;
}

+ (NSString *)stringToString:(NSString *)date dateFormat:(NSString *)dateFormat{
    NSDate *dateTemp = [MAFExpDate stringToDate:date dateFormat:dateFormat];
    
    return [MAFExpDate dateToString:dateTemp dateFormat:dateFormat];
}

+ (NSDate *)dateToDate:(NSDate *)date dateFormat:(NSString *)dateFormat{
    NSString *dateString = [MAFExpDate dateToString:date dateFormat:dateFormat];
    return [MAFExpDate stringToDate:dateString dateFormat:dateFormat];
}


+ (NSString *)distanceToNow:(NSString *)date DateFormat:(NSString*)dateFormat{
    NSDate *oldDate ;
    if (dateFormat == nil) {
        oldDate = [MAFExpDate stringToDate:date dateFormat:dateFormat];
        if(oldDate == nil){
            oldDate = [MAFExpDate stringToDate:date dateFormat:@"yyyyMMddHHmm"];
        }
        
        if (oldDate == nil) {
            oldDate = [MAFExpDate stringToDate:date dateFormat:@"yyyyMMddHH"];
        }
        
        if (oldDate == nil) {
            oldDate = [MAFExpDate stringToDate:date dateFormat:@"yyyyMMdd"];
        }
        
        if (oldDate == nil) {
            oldDate = [MAFExpDate stringToDate:date dateFormat:@"yyyyMM"];
        }
        
        if (oldDate == nil) {
            oldDate = [MAFExpDate stringToDate:date dateFormat:@"yyyy"];
        }
    }
    //else{
        oldDate = [MAFExpDate stringToDate:date dateFormat:dateFormat];
    //}
    
    NSDate *newDate = [[NSDate alloc]init];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMinuteCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate toDate:newDate options:0];
    int minute = (int)[comps minute];
    int year = minute/(365*24*60);
    if (year > 0) {
        return [NSString stringWithFormat:@"%d年前",year];
    }
    
    int mounth = minute/(24*60*30);
    if (mounth > 0) {
        return [NSString stringWithFormat:@"%d月前",mounth];
    }
    
    int week = minute/(24*60*7);
    if (mounth > 0) {
        return [NSString stringWithFormat:@"%d周前",week];
    }
    
    int day = minute/(24*60);
    if (day > 0) {
        return [NSString stringWithFormat:@"%d天前",day];
    }
    
    int hour = minute/60;
    if (hour > 0) {
        return [NSString stringWithFormat:@"%d小时前",hour];
    }
    
    if (minute > 1) {
        return [NSString stringWithFormat:@"%d分钟前",minute];
    }
    return @"刚刚";
}

/**
 获取批次信息
 */
+ (NSString *)getBatch {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    NSString *str = timeString;
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:DaxieStr,XiaoxieStr,Num, nil];
    NSArray *tempArr = arr[arc4random() % 3];
    str = [str stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    str = [str stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    str = [str stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    str = [str stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    return str;
}
+ (NSString *)getSixBatchWithBatch:(NSString *)batch {
    
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:DaxieStr,XiaoxieStr,Num, nil];
    NSArray *tempArr = arr[arc4random() % 3];
    batch = [batch stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    batch = [batch stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    batch = [batch stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    batch = [batch stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    batch = [batch stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    tempArr = arr[arc4random() % 3];
    batch = [batch stringByAppendingString:tempArr[arc4random() % tempArr.count]];
    
    return batch;
}


+ (NSString *)distanceToNow:(NSString *)date {
   return [MAFExpDate distanceToNow:date DateFormat:nil];
}

@end
