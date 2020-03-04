//
//  MAFYcYdCacheManager.h
//  MAF
//
//  Created by wang k on 2018/3/6.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFYcYdCacheManager : NSObject

+ (instancetype)sharedInstance;
/**
 state:
 0:待提交
 1:提交中
 2:提交失败
 1000:草稿
 */

//添加表单数据
- (void)addYcYdInfoWithDic:(NSDictionary *)dic remark1:(NSString *)remark1 remark2:(NSString *)remark2;

//根据表单id更新某条表单信息
- (void)updateYcYdInfoWithDic:(NSMutableDictionary *)dic userID:(NSString *)userID formID:(NSString *)formID;

//查询数据库中所有未提交的表单
- (NSMutableArray *)searchYcYdCacheListWithUserID:(NSString *)userID;
//根据畜禽养殖代码检索数据库
- (NSMutableArray *)searchYcYdXQYZDM:(NSString *)xqyzdm;

//根据表单id查询某条表单信息
- (NSMutableDictionary *)searchYcYdInfoWithUserID:(NSString *)userID formID:(NSString *)formID;

//更新某条表单state字段
- (void)updateYcYdSubmitStateWithFormID:(NSString *)formID state:(NSString *)state;

//删除某条表单
- (void)deleteYcYdInfoWithFormID:(NSString *)formID;

//查看是否存在草稿
- (BOOL)checkYcYdDraftExistWithUserID:(NSString *)userID formID:(NSString *)formID;

//查询所有草稿
- (NSMutableArray *)searchYcYdDraftListWithUserID:(NSString *)userID;
/**
 查询所有表单
 */
- (NSMutableArray *)searchYcYdAllListWithUserID:(NSString *)userID;

//附件
- (void)addYcYdFileWithFormID:(NSString *)formID
                     file_url:(NSString *)file_url
                    file_name:(NSString *)file_name
                     pic_name:(NSString *)pic_name
                    file_type:(NSString *)file_type
                    file_code:(NSString *)file_code
                    file_data:(NSString *)file_data
                      remark1:(NSString *)remark1
                      remark2:(NSString *)remark2;

- (NSMutableArray *)searchYcYdFileListWithFormID:(NSString *)formID;
/**
 删除大门处其他的照片
 */
- (void)deleteOtherImagesWithFormID:(NSString *)formID;
/**
 删除圈舍的照片
 */
- (void)deleteJuanSheImagesWithFormID:(NSString *)formID;
/**
 删除粪污有无直排
 */
- (void)deleteFWYWZPImagesWithFormID:(NSString *)formID;
/**
 删除附件
 */
- (void)deleteYcYdFileListWithFormID:(NSString *)formID;

@end
