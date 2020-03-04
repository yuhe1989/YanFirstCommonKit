//
//  NSDate+MAFChickDate.m
//  MAF
//
//  Created by nqkj on 2018/6/27.
//  Copyright © 2018年 崔祥莉. All rights reserved.
//

#import "NSDate+MAFChickDate.h"

@implementation NSDate (MAFChickDate)

//比较两个日期大小
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

//获取当地时间
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//获取当地月份
+ (NSString *)getCurrentMonth{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *month = [dateTime substringWithRange:NSMakeRange(5, 2)];
    int num = [month intValue];
    month = [NSString stringWithFormat:@"%d",num];
    return month;
}

+(NSString *)getTheDayOfTheWeekByDateString:(NSString *)dateString firstWeekDay:(BOOL)firstWeekDay{
    NSDateFormatter *inputFormatter=[[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate=[inputFormatter dateFromString:dateString];
    NSDateFormatter *outputFormatter=[[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"EEEE-MMMM-d"];
    NSString *outputDateStr=[outputFormatter stringFromDate:formatterDate];
    NSArray *weekArray=[outputDateStr componentsSeparatedByString:@"-"];
    return [weekArray objectAtIndex:0];
}

// 获取本周开始结束时间
+ (NSString *)getWeekBeginAndEndWith:(NSDate *)newDate firstWeekDay:(BOOL)firstWeekDay{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    /**获取当前几个月*/
    NSInteger monthDay = [comp month];
    NSLog(@"%ld",monthDay);
    // 获取几天是几号
    NSInteger day = [comp day];
    NSLog(@"%ld----%ld",weekDay,day);
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1){
        firstDiff = -6;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    if (firstWeekDay) {
        return firstDay;
    }else{
        return lastDay;
    }
}

// 获取本月开始结束时间
+ (NSString *)getMonthBeginAndEndWith:(NSDate *)newDate firstMonth:(BOOL)firstMonth{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    //设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]; //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *beginString = [myDateFormatter stringFromDate:beginDate];
        NSString *endString = [myDateFormatter stringFromDate:endDate];
        if (firstMonth) {
            return beginString;
        }else{
            return endString;
        }
    }
    return nil;
}

// 获取前后一个月的日期
+(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month firstMonth:(BOOL)firstMonth{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *startString = [dateFormatter stringFromDate:mDate];
    NSString *year = [startString componentsSeparatedByString:@"-"].firstObject;
    NSString *monthStr = [startString componentsSeparatedByString:@"-"][1];
    return startString;
}

// 获取上月开始结束时间
+ (NSString *)getPriousorWithFirstMonth:(BOOL)firstMonth{
    //1.当然是获取当前时间。
    //日历操作工具待会儿要用
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //当前时间
    NSDate *dateNow = [NSDate date];
    //转换当前时间的格式为 XXXX-XX-XX
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    
    //2.然后将年月日分解出来,从而构造这个月和上月1号时间:
    NSLog(@"dateNow-->%@",dateStr);
    //获取 年月日
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSInteger month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger day = [[dateStr substringFromIndex:8] integerValue];
    NSLog(@"year -> %ld month -> %ld day -> %ld",(long)year,(long)month,(long)day);
    
    ///3.构造这个月一号的起始时间:
    //NSDateComponents这个叫什么还真不知道。 大致理解为时间元,构造时间的
    //构造当月的1号时间
    NSDateComponents *firstDayCurrentMonth = [[NSDateComponents alloc] init];
    [firstDayCurrentMonth setYear:year];
    [firstDayCurrentMonth setMonth:month];
    [firstDayCurrentMonth setDay:1];
    //当月1号
    NSDate *firstDayOfCurrentMonth = [calendar dateFromComponents:firstDayCurrentMonth];
    NSLog(@"firstDayOfCurrentMonth -> %@",firstDayOfCurrentMonth);
    
    //4.然后再获取上月一号时间:
    //构造上月1号时间
    month --;
    //获取上月月份 没的说
    if (month == 0) {
        month = 12;
        year--;
    }
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:1];
    //上月1号时间
    NSDate *firstDayOfLastMonth = [calendar dateFromComponents:dateComponents];
    NSLog(@"firstDayOfLastMonth -> %@",firstDayOfLastMonth);
    //5.最后就是上月的结束时间:
    //上个月的最后一天的最后一秒
    NSDate *lastDayOfLastlMonth = [firstDayOfCurrentMonth dateByAddingTimeInterval:-1];
    NSLog(@"lastDayOfLastlMonth -> %@",lastDayOfLastlMonth);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *beginString = [dateFormatter stringFromDate:firstDayOfLastMonth];
    NSString *endString = [dateFormatter stringFromDate:lastDayOfLastlMonth];
    if (firstMonth) {
        return beginString;
    }else{
        return endString;
    }
}

// 获取上周时间
+(NSString *)getPreWeekTimeWithFirstWeekDay:(BOOL)firstWeekDay{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit| NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    //获取今天是周几
    NSInteger weekDay = [comp weekday];
    //获取某天是几号
    NSInteger day = [comp day];
    //计算当前日期和上周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -13;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay +1-7;
        lastDiff = [calendar firstWeekday] - weekDay;
    }
    //在当前日期基础上加上时间差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    if(firstWeekDay){
        return firstDay;
    }
    return lastDay;
}

// 获取昨天时间
+ (NSString *)getYesterdayDay{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    NSString *yesterday = [format stringFromDate:yesterdayDate];
    return yesterday;
}

@end
