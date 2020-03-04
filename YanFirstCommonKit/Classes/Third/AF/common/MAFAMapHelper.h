//
//  MAFAMapHelper.h
//  MAF
//
//  Created by wang k on 2017/4/5.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface MAFAMapHelper : NSObject

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) AMapLocationManager *onceLocation;

+ (instancetype)sharedInstance;
/**
 单次定位
 */
- (void)startOnceLocationSuccess:(void (^)(CLLocation *location,  AMapLocationReGeocode *regeocode))success failure:(void (^)(NSError *error))failure;
/**
 持续定位
 */
- (void)startLocation;
/**
 暂停连续定位
 */
- (void)stopLocation;
/**
 自动签到
 */
- (void)autoCheckIn;

@end
