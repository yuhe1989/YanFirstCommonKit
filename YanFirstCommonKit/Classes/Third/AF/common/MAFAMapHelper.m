//
//  MAFAMapHelper.m
//  MAF
//
//  Created by wang k on 2017/4/5.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFAMapHelper.h"
#import "MAFCommonClass.h"
#import "MAFUUID.h"
#import "YYModel.h"
#import "MAFSignInHttpRequest.h"

#define COMMONCLASS [MAFCommonClass shareCommonClass]

@interface MAFAMapHelper () <AMapLocationManagerDelegate>
@property (nonatomic, strong) NSString *checkinInterval; //自动签到间隔
@property (nonatomic, strong) NSString *checkin_time; //上班时间
@property (nonatomic, strong) NSString *checkout_time; //下班时间
@property (nonatomic, strong) NSString *classDate; //班次日期
@property (nonatomic, strong) NSTimer *checkinTimer; //自动签到计时器
@end

@implementation MAFAMapHelper

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [AMapServices sharedServices].apiKey = COMMONCLASS.baiduAppKey;
        [self startLocation];
    }
    return self;
}

- (void)startOnceLocationSuccess:(void (^)(CLLocation *location,  AMapLocationReGeocode *regeocode))success failure:(void (^)(NSError *error))failure {
    //取消连续定位
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
    _locationManager = nil;
    
    if (!_onceLocation) {
        _onceLocation = [[AMapLocationManager alloc] init];
    }
    [_onceLocation stopUpdatingLocation];
    [_onceLocation setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    _onceLocation.locationTimeout = 5;
    _onceLocation.reGeocodeTimeout = 5;
    [_onceLocation requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"定位失败,请尝试重新定位" message:[NSString stringWithFormat:@"%ld-%@", (long)error.code, error.localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [av show];
//            if (failure) {
//                failure(error);
//            }
        }else {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HHmmss"];
            NSString *currentTime = [formatter stringFromDate:[NSDate date]];
            
            NSString *latitude = [NSString stringWithFormat:@"%0.6f", location.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%0.6f", location.coordinate.longitude];
            
            [userDefault setObject:currentTime forKey:@"lastUpdateLocation"];
            [userDefault setObject:latitude forKey:@"latitude"];
            [userDefault setObject:longitude forKey:@"longitude"];
            if (regeocode) {
                [userDefault setObject:regeocode.formattedAddress forKey:@"position_name"];
            }
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
            [dic setValue:longitude forKey:@"longitude"];
            [dic setValue:latitude forKey:@"latitude"];
            [dic setValue:[userDefault valueForKey:@"position_name"] forKey:@"position_name"];
            NSString *bodyDataStr = [dic yy_modelToJSONString];
            
            NSDictionary *callbackDic = [[NSDictionary alloc] init];
            callbackDic = @{@"body": bodyDataStr};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DcloudWeiZhi" object:nil userInfo:callbackDic];
            
            if (success) {
                success(location, regeocode);
            }
        }
        //打开连续定位
        [self startLocation];
    }];
}

- (void)startLocation {
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 5;
    [_locationManager setLocatingWithReGeocode:YES];
    [_locationManager setPausesLocationUpdatesAutomatically:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    [_locationManager startUpdatingLocation];
}

/**
 暂停连续定位
 */
- (void)stopLocation {
    //取消连续定位
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
    _locationManager = nil;
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    NSString *latitude = [NSString stringWithFormat:@"%0.6f", location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%0.6f", location.coordinate.longitude];
    
    [userDefault setObject:currentTime forKey:@"lastUpdateLocation"];
    [userDefault setObject:latitude forKey:@"latitude"];
    [userDefault setObject:longitude forKey:@"longitude"];
    if (reGeocode) {
        [userDefault setObject:reGeocode.formattedAddress forKey:@"position_name"];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", [NSString stringWithFormat:@"%ld-%@", (long)error.code, error.localizedDescription]);
}

#pragma mark - CheckIn

- (void)autoCheckIn {
    NSString *userBaseband = [[NSUserDefaults standardUserDefaults]valueForKey:@"baseband"];
    NSString *nowBaseband = [MAFUUID getUUID];
    if ([userBaseband isEqualToString:nowBaseband]){
        [[NSUserDefaults standardUserDefaults]setValue:@"true" forKey:@"checkSign"];
        [self requestClassInfo];
    }else{
        [[NSUserDefaults standardUserDefaults]setValue:@"false" forKey:@"checkSign"];
    }
}

#define UserID @"uuid"

- (void)requestClassInfo {
    // 替换查询用户班次新接口
    // 通过is_has_class字段判断是否有班次
    // 有班次,去判断是否存在本机设备号,
    // 存在则去查看自动跟踪设置 并设置自动跟踪
    // gaos.0420
    NSString *user_id = [[NSUserDefaults standardUserDefaults]valueForKey:UserID];
    MAFSignInHttpRequest *request = [[MAFSignInHttpRequest alloc]init];
    [request requsetNewUserSignClassWithUserId:user_id success:^(id responseObject) {
        if([[responseObject valueForKey:@"code"] isEqualToString:@"050000"]){
            NSDictionary * dic = [responseObject valueForKey:@"data"];
            if (dic != nil) {
                BOOL hasSignClass = [[dic valueForKey:@"is_has_class"] boolValue];
                if (hasSignClass) { // 如果有班次
                    if ([[dic allKeys] containsObject:@"equList"]) {    // 判断是否有设备列表
                        if ([dic[@"equList"] isKindOfClass:[NSArray class]]) {
                            NSArray *arr = dic[@"equList"];
                            NSMutableArray *imeiArr = [NSMutableArray array];
                            for (NSDictionary *dict in arr) {
                                NSString *imei = dict[@"imei"];
                                [imeiArr addObject:imei];
                                [[NSUserDefaults standardUserDefaults] setObject:imei forKey:@"baseband"];
                            }
                            NSString *myImei = [MAFUUID getUUID];
                            if ([imeiArr containsObject:myImei]) {  // 本机设备为开启状态
                                NSString * strr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trail_interval"]];
                                
                                if([strr isEqualToString:@"1"]){
                                    _checkinInterval = @"1";
                                }else if([strr isEqualToString:@"2"]){
                                    _checkinInterval = @"5";
                                }else if([strr isEqualToString:@"3"]){
                                    _checkinInterval = @"10";
                                }else if([strr isEqualToString:@"4"]){
                                    _checkinInterval = @"15";
                                }else if([strr isEqualToString:@"5"]){
                                    _checkinInterval = @"30";
                                }else if([strr isEqualToString:@"6"]){
                                    _checkinInterval = @"60";
                                }
                                _checkin_time = [dic valueForKey:@"signon_time"];
                                _checkout_time = [dic valueForKey:@"signout_time"];
                                _classDate = [dic valueForKey:@"class_date"];
                                
                                if ([_checkinInterval intValue] * 60 == 0) {
                                    
                                }else{
                                    _checkinTimer = [NSTimer scheduledTimerWithTimeInterval:[_checkinInterval intValue]*60 target:self selector:@selector(startAutoCheckIn) userInfo:nil repeats:YES];
                                }
                            } else {        // 本机设备未停用状态,或没有本机设备号
                            }
                        }
                    }
                }
                
            } else {
                
            }
        }
    } fail:^(NSError *error) {
        
    }];
//    NSString *user_id = [[NSUserDefaults standardUserDefaults]valueForKey:UserID];
//    MAFSignInHttpRequest *request = [[MAFSignInHttpRequest alloc]init];
//    [request requsetUserSignClassWithUserId:user_id success:^(id responseObject) {
//        if([[responseObject valueForKey:@"code"] isEqualToString:@"050000"]){
//            NSDictionary * dic = [responseObject valueForKey:@"data"];
//            NSString * strr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trail_interval"]];
//            
//            if([strr isEqualToString:@"1"]){
//                _checkinInterval = @"1";
//            }else if([strr isEqualToString:@"2"]){
//                _checkinInterval = @"5";
//            }else if([strr isEqualToString:@"3"]){
//                _checkinInterval = @"10";
//            }else if([strr isEqualToString:@"4"]){
//                _checkinInterval = @"15";
//            }else if([strr isEqualToString:@"5"]){
//                _checkinInterval = @"30";
//            }else if([strr isEqualToString:@"6"]){
//                _checkinInterval = @"60";
//            }
//            _checkin_time = [dic valueForKey:@"signon_time"];
//            _checkout_time = [dic valueForKey:@"signout_time"];
//            _classDate = [dic valueForKey:@"class_date"];
//            
//            if ([_checkinInterval intValue] * 60 == 0) {
//                
//            }else{
//                _checkinTimer = [NSTimer scheduledTimerWithTimeInterval:[_checkinInterval intValue]*60 target:self selector:@selector(startAutoCheckIn) userInfo:nil repeats:YES];
//            }
//        }
//    } fail:^(NSError *error) {
//        
//    }];
}

- (void)startAutoCheckIn {
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    if (![currentDate isEqualToString:self.classDate]) {
        return;
    }
    [formatter setDateFormat:@"HHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSInteger curr1 = [currentTime integerValue];
    NSInteger zs1 = [_checkin_time integerValue];
    NSInteger ws1 = [_checkout_time integerValue];
    
    if(zs1 > curr1 || curr1 > ws1) {
        
    }else {
        NSString *user_id = [[NSUserDefaults standardUserDefaults] valueForKey:UserID];
        NSString *longitude = [[NSUserDefaults standardUserDefaults] valueForKey:@"longitude"];
        NSString *latitude = [[NSUserDefaults standardUserDefaults] valueForKey:@"latitude"];
        NSString *position_name = [[NSUserDefaults standardUserDefaults] valueForKey:@"position_name"];
        NSString *manufacturer = [[UIDevice currentDevice] model];
        NSString *identifierForVendor = [MAFUUID getUUID];
        
        MAFSignInHttpRequest *request = [[MAFSignInHttpRequest alloc]init];
        [request signOnClassWithUserId:user_id
                              signType:@"3"
                             classDate:currentDate
                             longitude:longitude
                              latitude:latitude
                          positionName:position_name
                          manufacturer:manufacturer
                                  imei:identifierForVendor
                               success:^(id responseObject) {
                                   NSLog(@"自动签到成功");
                                   
                                   NSDictionary *returnDic = responseObject[@"data"];
                                   if ([returnDic allKeys].count) {
                                       [self updateClassInfoWithDic:returnDic];
                                   }
                               } fail:^(NSError *error) {
                                   NSLog(@"自动签到失败");
                               }];
    }
}

- (void)updateClassInfoWithDic:(NSDictionary *)dic {
    [_checkinTimer invalidate];
    _checkinTimer = nil;
    
    _checkin_time = dic[@"signon_time"];
    _checkout_time = dic[@"signout_time"];
    _classDate = dic[@"class_date"];
    
    NSString * strr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trail_interval"]];
    if([strr isEqualToString:@"1"]){
        _checkinInterval = @"1";
    }else if([strr isEqualToString:@"2"]){
        _checkinInterval = @"5";
    }else if([strr isEqualToString:@"3"]){
        _checkinInterval = @"10";
    }else if([strr isEqualToString:@"4"]){
        _checkinInterval = @"15";
    }else if([strr isEqualToString:@"5"]){
        _checkinInterval = @"30";
    }else if([strr isEqualToString:@"6"]){
        _checkinInterval = @"60";
    }
    if ([_checkinInterval intValue] * 60 == 0) {
        
    }else{
        _checkinTimer = [NSTimer scheduledTimerWithTimeInterval:[_checkinInterval intValue]*60 target:self selector:@selector(startAutoCheckIn) userInfo:nil repeats:YES];
    }
}


@end
