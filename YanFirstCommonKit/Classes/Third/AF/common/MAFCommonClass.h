//
//  CommonClass.h
//  GAEC
//
//  Created by victor on 13-7-22.
//  Copyright (c) 2013年 GAEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "XMPPMessage.h"

@protocol FileSendDelegate <NSObject>

-(void)Getfile:(NSMutableArray *)array;

@end

@interface MAFCommonClass : NSObject
{
    NSString *_userSelectIndex;
}
@property(nonatomic,retain)NSString *userSelectIndex;
@property(nonatomic,retain)NSMutableArray *menuArray;
@property(nonatomic,retain)NSString *appID;
@property(nonatomic,retain)NSString *layoutID;
@property(nonatomic,retain)NSString *skinID;
@property(nonatomic,retain)NSString *appVersion;
@property(nonatomic,retain)NSString *departmentName;
@property(nonatomic,retain)NSString *departmentId;
@property(nonatomic,retain)NSString *background;
@property(nonatomic,retain)NSString *qac_expert;
@property(nonatomic,retain)NSString *release_power;
@property(nonatomic,retain)NSString *PlatCode;
@property(nonatomic,copy)NSString *baiduAppKey;
@property (nonatomic, copy) NSString *appNameKey;
@property (nonatomic, copy) NSString *appNamePath;
@property (nonatomic, strong) NSDictionary *themeConfig;

+(MAFCommonClass *)shareCommonClass;
/*
 *@解析xml文件中的数据
 */
-(void)analysisXMLFile:(NSString*)name;
/*
 *@清除空格和其他相关的东西
 */
-(id)clearAllChar:(NSString*)str;
/*
 *@给出图片和要压缩的大小自动压缩返回数组
 */
-(NSDictionary*)scaleToSize:(float)size image:(UIImage*)image;
/*
 *@计算坐标
 */
-(CGRect)makeRect:(CGRect)rect;
/**
 获取以app名称为名的文件夹路径
 */
//- (NSString *)getAppNamePath;

@end
