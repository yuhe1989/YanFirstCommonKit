//
//  CQAreaCode.m
//  MAF
//
//  Created by joy 尹 on 2019/12/11.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "CQAreaCode.h"
#import "FMDB.h"
#import "AFNetDownloadAreaData.h"

#define TABLENAME       @"umc_areainfo"
#define SHETABLENAME    @"umc_farmer_she"

@implementation CQAreaCode

static CQAreaCode *areaCode = nil;

+ (instancetype)shareAreaCode{
    if (areaCode == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            areaCode = [[CQAreaCode alloc] init];
            NSError * error;
            NSString * areaString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChongQingAreaCode" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
            areaCode.areaDict = [self dictionaryWithJsonString:areaString];
        });
    }
    return areaCode;
}

- (NSArray *)getChongQingAreaCodeWithLevelCode:(NSString *)levelCode{
    
    //通过字典获取地区对应的值
    NSArray * areaArray = [NSArray array];
    
    if ([levelCode isEqualToString:@"50"]) {
        NSArray * arr = areaCode.areaDict[@"data"];
        NSDictionary * dic = [arr firstObject];
        areaArray = dic[@"data"];
        return areaArray;
    }else{
        NSArray * arr = areaCode.areaDict[@"data"];
        NSDictionary * dic = [arr firstObject];
        NSArray * cqList = dic[@"data"];
        for (NSDictionary * quDict in cqList) {//这里是区
            NSString * qu_code = quDict[@"area_code"];
            if ([qu_code isEqualToString:levelCode]) {
                areaArray = quDict[@"data"];
                return areaArray;
            }else{
                for (NSDictionary * zhenDict in quDict[@"data"]) {//镇
                    NSString * zhen_code = zhenDict[@"area_code"];
                    if ([zhen_code isEqualToString:levelCode]) {
                        areaArray = zhenDict[@"data"];
                        return areaArray;
                    }else{
                        for (NSDictionary * cunDict in zhenDict[@"data"]) {//村
                            NSString * cun_code = cunDict[@"area_code"];
                            if ([cun_code isEqualToString:levelCode]) {
                                areaArray = cunDict[@"data"];
                                return areaArray;
                            }else{
                                if ([cunDict[@"data"] count] > 0) {//社 判断一下是否有
                                    for (NSDictionary * sheDict in cunDict[@"data"]) {
                                        NSString * she_code = sheDict[@"area_code"];
                                        if ([she_code isEqualToString:levelCode]) {
                                            areaArray = sheDict[@"data"];
                                            return areaArray;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    return areaArray;
}



+ (NSArray *)getAreaDataDBWithLevelCode:(NSString *)code isSheng:(BOOL)isSheng{
    [AFNetDownloadAreaData judegFileExist];
    NSString * dbPaht = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/area_data.db"];
    FMDatabaseQueue * dataBase = [FMDatabaseQueue databaseQueueWithPath:dbPaht];
    NSString * searchStr;
    if (isSheng) {
        searchStr = [NSString stringWithFormat:@"SELECT * FROM umc_areainfo WHERE level = %@",code];
    }else{
        searchStr = [NSString stringWithFormat:@"SELECT * FROM umc_areainfo WHERE parentcode = %@",code];
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [dataBase inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:searchStr];
    
        while ([result next]) {
            //用数组arr保存一条记录转成的字典
            [arr addObject:[result resultDictionary]];
        }
//        NSLog(@"===%@",arr);
    }];
    return arr;
}


+ (NSArray *)getAreaDataDBWithParentCode:(NSString *)parentCode{
    NSString * dbPaht = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/area_data.db"];
    FMDatabaseQueue * dataBase = [FMDatabaseQueue databaseQueueWithPath:dbPaht];
    
    NSString * searchStr = [NSString stringWithFormat:@"SELECT * FROM umc_areainfo WHERE parentcode = %@",parentCode];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [dataBase inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:searchStr];
        
        while ([result next]) {
            //用数组arr保存一条记录转成的字典
            [arr addObject:[result resultDictionary]];
        }
        //        NSLog(@"===%@",arr);
    }];
    return arr;
}


+ (NSArray *)getZuAreaDataDBWithParentCode:(NSString *)areaCode{
    NSString * dbPaht = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/area_data.db"];
    FMDatabaseQueue * dataBase = [FMDatabaseQueue databaseQueueWithPath:dbPaht];
    
    NSString * searchStr = [NSString stringWithFormat:@"SELECT * FROM umc_farmer_she WHERE area_code = %@",areaCode];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [dataBase inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:searchStr];
        
        while ([result next]) {
            //用数组arr保存一条记录转成的字典
            [arr addObject:[result resultDictionary]];
        }
        //        NSLog(@"===%@",arr);
    }];
    return arr;
}



//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

@end
