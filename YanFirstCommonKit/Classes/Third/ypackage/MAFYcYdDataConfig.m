//
//  MAFYcYdDataConfig.m
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdDataConfig.h"
#import "MAFYcYdDataModel.h"

@interface MAFYcYdDataConfig ()
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end

@implementation MAFYcYdDataConfig

+ (instancetype)sharedInstance {
    static id manager = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataDic = [NSMutableDictionary dictionary];
        
        NSArray *a1 = @[[[MAFYcYdDataModel alloc] initWithId:@"c4d74468-89ed-4e55-a11f-92eeb066617b" name:@"适养区"],
                        [[MAFYcYdDataModel alloc] initWithId:@"4b02227a-2e94-4be6-bb65-720b18ef2802" name:@"禁养区"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2a71e19c-d1b8-477a-9a9b-3ba0313d2fca" name:@"限养区"]
                        ];
        [_dataDic setValue:a1 forKey:@"yzqy"];
        
        NSArray *a2 = @[[[MAFYcYdDataModel alloc] initWithId:@"e08babaf-f274-48c6-9454-7404dcb5c079" name:@"有手续"],
                        [[MAFYcYdDataModel alloc] initWithId:@"fdf03472-4414-4068-9f0a-d6467014593f" name:@"无手续"]];
        [_dataDic setValue:a2 forKey:@"yzydsp"];
        
        NSArray *a3 = @[[[MAFYcYdDataModel alloc] initWithId:@"53b39a5e-64ec-405a-9809-9c007725cb4e" name:@"自有"],
                        [[MAFYcYdDataModel alloc] initWithId:@"1f4b6030-57c7-48b4-b76e-9c244a30ce73" name:@"租用"]];
        [_dataDic setValue:a3 forKey:@"yzydqs"];
        
        NSArray *a4 = @[[[MAFYcYdDataModel alloc] initWithId:@"72d24538-ee34-4486-9c61-864b7a0c25b6" name:@"正常生产"],
                        [[MAFYcYdDataModel alloc] initWithId:@"989435d6-42c5-488a-bc20-ccb99e5ef621" name:@"临时性停产"],
                        [[MAFYcYdDataModel alloc] initWithId:@"465f6a2d-3666-4aad-8a37-541f2a4e1f5f" name:@"长期停产"],
                        [[MAFYcYdDataModel alloc] initWithId:@"ceb854dc-1cd3-45c6-b5dc-da6ed568ea48" name:@"新建在建"],
                        [[MAFYcYdDataModel alloc] initWithId:@"75388e28-b734-4745-bb33-353050a44c07" name:@"列入整治关停任务"]];
        [_dataDic setValue:a4 forKey:@"scyxzt"];
//        [[MAFYcYdDataModel alloc] initWithId:@"f2ede5fe-6e92-45bd-90bb-d4c6e6ec95c1" name:@"已关闭或搬迁"],
//        [[MAFYcYdDataModel alloc] initWithId:@"e541ddb0-086e-4b23-9d50-bceb0370661a" name:@"已停产整治"],
//        [[MAFYcYdDataModel alloc] initWithId:@"b70d48f0-3bfa-447a-9611-ff2df916c30a" name:@"自然关闭"],
        
        NSArray *a5 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"猪"],
                        [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"奶牛"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"肉牛"],
                        [[MAFYcYdDataModel alloc] initWithId:@"3" name:@"水牛"],
                        [[MAFYcYdDataModel alloc] initWithId:@"4" name:@"山羊"],
                        [[MAFYcYdDataModel alloc] initWithId:@"5" name:@"绵羊"],
                        [[MAFYcYdDataModel alloc] initWithId:@"6" name:@"兔"],
                        [[MAFYcYdDataModel alloc] initWithId:@"7" name:@"马"],
                        [[MAFYcYdDataModel alloc] initWithId:@"8" name:@"蛋鸡"],
                        [[MAFYcYdDataModel alloc] initWithId:@"9" name:@"肉鸡"],
                        [[MAFYcYdDataModel alloc] initWithId:@"10" name:@"蛋鸭"],
                        [[MAFYcYdDataModel alloc] initWithId:@"11" name:@"肉鸭"],
                        [[MAFYcYdDataModel alloc] initWithId:@"12" name:@"蛋鹅"],
                        [[MAFYcYdDataModel alloc] initWithId:@"13" name:@"肉鹅"],
                        [[MAFYcYdDataModel alloc] initWithId:@"14" name:@"蛋鸽"],
                        [[MAFYcYdDataModel alloc] initWithId:@"15" name:@"肉鸽"],
                        [[MAFYcYdDataModel alloc] initWithId:@"16" name:@"鹌鹑"],
                        [[MAFYcYdDataModel alloc] initWithId:@"17" name:@"蜜蜂(中)"],
                        [[MAFYcYdDataModel alloc] initWithId:@"18" name:@"蜜蜂(西)"],
                        [[MAFYcYdDataModel alloc] initWithId:@"19" name:@"蚕"],
                        [[MAFYcYdDataModel alloc] initWithId:@"20" name:@"驴"],
                        [[MAFYcYdDataModel alloc] initWithId:@"21" name:@"骡"],
                        [[MAFYcYdDataModel alloc] initWithId:@"22" name:@"骆驼"],
                        [[MAFYcYdDataModel alloc] initWithId:@"23" name:@"鹿"],
                        [[MAFYcYdDataModel alloc] initWithId:@"24" name:@"特禽"],
                        [[MAFYcYdDataModel alloc] initWithId:@"25" name:@"其它"]];
        [_dataDic setValue:a5 forKey:@"yzczjzl"];
        
        NSArray *a6 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"仅育肥/商品畜禽饲养"],
                        [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"自繁自养"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"仅饲养种畜禽"],
                        [[MAFYcYdDataModel alloc] initWithId:@"3" name:@"其他"]];
        [_dataDic setValue:a6 forKey:@"yzms"];
        
        NSArray *a7 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"部级监测点"],
                        [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"省级监测点"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"仅待审批监测点"],
                        [[MAFYcYdDataModel alloc] initWithId:@"3" name:@"待撤销监测点"],
                        [[MAFYcYdDataModel alloc] initWithId:@"4" name:@"否"]];
        [_dataDic setValue:a7 forKey:@"sqjcdlx"];
        
        NSArray *a8 = @[[[MAFYcYdDataModel alloc] initWithId:@"1e6feea1-ac8c-4a56-9ab4-516f2462d7a8" name:@"商品代"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2f185115-0705-4cfc-bc9d-b7d3f5c8ab6c" name:@"父母代"],
                        [[MAFYcYdDataModel alloc] initWithId:@"d6783610-baa7-47a2-b4b5-4ee9069f11ef" name:@"祖代场"],
                        [[MAFYcYdDataModel alloc] initWithId:@"8a2c6503-cdb9-4837-b65e-86d754b7cb7f" name:@"原种场"]];
        [_dataDic setValue:a8 forKey:@"yzfs"];
        
        NSArray *a9 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"砖混"],
                        [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"砖木"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"墙瓦"],
                        [[MAFYcYdDataModel alloc] initWithId:@"3" name:@"简易"],
                        [[MAFYcYdDataModel alloc] initWithId:@"4" name:@"钢架结构"]];
        [_dataDic setValue:a9 forKey:@"cqjsjg"];
        
        NSArray *a10 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"粪污全量收集还田利用模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"粪污专业化能源利用模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"固体粪便堆肥利用模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"3" name:@"粪便垫料回用模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"4" name:@"异位发酵床模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"5" name:@"污水肥料化利用模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"6" name:@"污水达标排放模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"7" name:@"污水深度处理模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"9" name:@"销售给第三方机构"],
                         [[MAFYcYdDataModel alloc] initWithId:@"8" name:@"无"]];
        [_dataDic setValue:a10 forKey:@"fbcllyms"];
        
        NSArray *a11 = @[[[MAFYcYdDataModel alloc] initWithId:@"2c1edf90-0d5d-4274-b3b2-30a28db2c28b" name:@"人工干清粪"],
                         [[MAFYcYdDataModel alloc] initWithId:@"e1b0d58b-e8b3-43cc-9f1f-895d4f775c42" name:@"机械干清粪"],
                         [[MAFYcYdDataModel alloc] initWithId:@"d6a01623-d968-4698-b450-54169237df3c" name:@"水冲粪"],
                         [[MAFYcYdDataModel alloc] initWithId:@"86104243-28c6-4bfa-8933-fa9a60e863d5" name:@"水泡粪"],
                         [[MAFYcYdDataModel alloc] initWithId:@"ec7a267b-a3c5-4b43-8ab8-30bce3987fab" name:@"发酵床垫料"],
                         [[MAFYcYdDataModel alloc] initWithId:@"5b452131-8890-4cf6-8421-d27f3b7c231d" name:@"其他"]];
        [_dataDic setValue:a11 forKey:@"qffs"];
        
        NSArray *a12 = @[[[MAFYcYdDataModel alloc] initWithId:@"9863282c-17f1-46a8-917c-11897b34d31a" name:@"生产液态商品有机肥"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2c11fdd4-b79a-4af7-99f2-2b1d8dde0ddf" name:@"达标排放"],
                         [[MAFYcYdDataModel alloc] initWithId:@"13689b7a-693f-4b0d-ae39-42d414f8f4f8" name:@"第三方处理"],
                         [[MAFYcYdDataModel alloc] initWithId:@"a65d8659-212b-4836-a0ec-680b6cfc8091" name:@"未处理直接排放"],
                         [[MAFYcYdDataModel alloc] initWithId:@"4a3b65e9-0580-4eb4-908f-3a1db559db0d" name:@"处理后还田利用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"6ae659b0-3523-4524-a4bd-df22fe33075a" name:@"异位发酵床模式"],
                         [[MAFYcYdDataModel alloc] initWithId:@"91eb5f4f-8f79-449e-b0d8-8aa911414f7b" name:@"其他"]];
        [_dataDic setValue:a12 forKey:@"wslyfs"];
        
        NSArray *a13 = @[[[MAFYcYdDataModel alloc] initWithId:@"111afacd-6629-49e4-864f-3ee0323c6fe5" name:@"免备案(现存栏20-200当量)"],
                         [[MAFYcYdDataModel alloc] initWithId:@"9c87052a-735e-46b4-9379-77ff6e90db3a" name:@"环评登记表(现存栏量大于200当量，年出栏量小于5000头)"],
                         [[MAFYcYdDataModel alloc] initWithId:@"da381612-72d2-419f-96e1-fbe39e5542bc" name:@"环评报告书(年出栏大于等于5000头)"],
                         [[MAFYcYdDataModel alloc] initWithId:@"7db94319-e447-45dc-ac10-3014cbe00b1e" name:@"无"]];
        [_dataDic setValue:a13 forKey:@"hplb"];
        
        NSArray *a14 = @[[[MAFYcYdDataModel alloc] initWithId:@"fbd867f9-b143-47b3-827f-326915d63164" name:@"执行三同时管理"],
                         [[MAFYcYdDataModel alloc] initWithId:@"a8991907-2928-4373-a004-936229c22f08" name:@"未执行三同时管理"]];
        [_dataDic setValue:a14 forKey:@"stsgl"];
        
        NSArray *a15 = @[[[MAFYcYdDataModel alloc] initWithId:@"1" name:@"正常运行有记录"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"正常运行无记录"],
                         [[MAFYcYdDataModel alloc] initWithId:@"0" name:@"不正常运行"]];
        [_dataDic setValue:a15 forKey:@"hbclss"];
        
        NSArray *shi = @[[[MAFYcYdDataModel alloc] initWithId:@"50" name:@"重庆市"]];
        [_dataDic setValue:shi forKey:@"shi"];
        
#pragma mark -新增字段
        //是否是种畜禽场
        NSArray *a16 = @[[[MAFYcYdDataModel alloc] initWithId:@"1" name:@"市级"],
                        [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"县级"]];
        [_dataDic setValue:a16 forKey:@"is_sfxqyzc"];
        // 排放标准
        NSArray *a17 = @[[[MAFYcYdDataModel alloc] initWithId:@"6e21e4ab-59dd-4143-a4e7-df6173d74e76" name:@"畜禽养殖标准(COD＜400mg/L)"],
                         [[MAFYcYdDataModel alloc] initWithId:@"d1575ce0-bc73-4b86-9187-b23f9cfe8dc9" name:@"污水综合级排放标准(COD＜100mg/L)"],
                         [[MAFYcYdDataModel alloc] initWithId:@"f696a2f6-e486-41dc-b8eb-85ef5abd3b77" name:@"农田灌溉标准(COD＜150mg/L)"]];
        [_dataDic setValue:a17 forKey:@"pfbz"];
        // 沼气存储及利用
        NSArray *a18 = @[[[MAFYcYdDataModel alloc] initWithId:@"828d7ea4-48f9-42ac-8e53-0f603763d215" name:@"燃料"],
                         [[MAFYcYdDataModel alloc] initWithId:@"28b682ea-53e6-4dc8-931a-7680afc82e40" name:@"发电"],
                         [[MAFYcYdDataModel alloc] initWithId:@"71c56030-3347-4386-8624-817a4618cb92" name:@"燃烧排空"],
                         [[MAFYcYdDataModel alloc] initWithId:@"3f884251djin4ff69350da9504e8ac94" name:@"生物天然气"],
                         [[MAFYcYdDataModel alloc] initWithId:@"3f88470d-4b80-4ff6-9350-da9504e8ac94" name:@"其他"]];
        [_dataDic setValue:a18 forKey:@"zqccjly"];
        // 沼液还田设施
        NSArray *a19 = @[[[MAFYcYdDataModel alloc] initWithId:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8" name:@"粪水潜水泵"],
                         [[MAFYcYdDataModel alloc] initWithId:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804" name:@"硬管及田间沼液池"],
                         [[MAFYcYdDataModel alloc] initWithId:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18" name:@"沼液车"],
                         [[MAFYcYdDataModel alloc] initWithId:@"e0b16a8e-79b2-4ad6-a5a1-ffd741abb847" name:@"人工"],
                         [[MAFYcYdDataModel alloc] initWithId:@"58b99206-c953-4a6b-8076-2fdd8bb39cf1" name:@"无"]];
        [_dataDic setValue:a19 forKey:@"zyhtss"];
        //7RXKNT6N43NL
        // 干粪储存设施
        NSArray *a20 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"无干粪储存设施"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"有干粪储存设施有防雨防渗"],
                         [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"有干粪储存设施无防雨防渗"]];
        [_dataDic setValue:a20 forKey:@"gfccss"];
        // 配套消纳农用地
        NSArray *a21 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"养殖场自有/已流转"],
                         [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"农户协议使用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"3" name:@"其他"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"无"]];
        [_dataDic setValue:a21 forKey:@"ptxnnyd"];
        // 干湿分离设施
        NSArray *a22 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"干湿分离机"],
                         [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"其他"]];
        [_dataDic setValue:a22 forKey:@"gsflss"];
        // 干粪发酵设施
        NSArray *a23 = @[[[MAFYcYdDataModel alloc] initWithId:@"0" name:@"无干粪发酵设施"],
                         [[MAFYcYdDataModel alloc] initWithId:@"1" name:@"有干粪发酵设施无防雨防渗"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2" name:@"有干粪发酵设施有防雨防渗"]];
        [_dataDic setValue:a23 forKey:@"gffjss"];
        
        // 整治年限
        NSArray *a24 = @[[[MAFYcYdDataModel alloc] initWithId:@"2016年" name:@"2016年"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2017年" name:@"2017年"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2018年" name:@"2018年"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2019年" name:@"2019年"],
                         [[MAFYcYdDataModel alloc] initWithId:@"2020年" name:@"2020年"]];
        [_dataDic setValue:a24 forKey:@"zznx"];
        
        //用途
        NSArray *a25 = @[[[MAFYcYdDataModel alloc] initWithId:@"05e6d450-20b9-4678-a82e-f578ec7f7e74" name:@"乳用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"3b4a588b-3b76-485c-96b7-e4827bbb8930" name:@"展览"],
                         [[MAFYcYdDataModel alloc] initWithId:@"708104e3-d793-4a52-aa66-d61e20842110" name:@"屠宰"],
                         [[MAFYcYdDataModel alloc] initWithId:@"5e15befc-7b7d-47ad-b929-4ba6552854a3" name:@"演出"],
                         [[MAFYcYdDataModel alloc] initWithId:@"8c656caf-a669-46a0-ac92-3766c7dd2a39" name:@"饲养"],
                         [[MAFYcYdDataModel alloc] initWithId:@"9bfb7fb5-f0c8-44b0-b3b3-548f63bd00fd" name:@"肉用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"44760b1e-6e76-4f9b-b8be-d388325adbac" name:@"役用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"6627b4ca-9f40-4209-ac88-9d2672e0d2e1" name:@"宠物"],
                         [[MAFYcYdDataModel alloc] initWithId:@"4df3d13a-4c6f-4e94-a527-b103a6bafb1d" name:@"比赛"],
                         [[MAFYcYdDataModel alloc] initWithId:@"5f3bf4b3-5970-4aa0-afd4-cb664e3ff508" name:@"种用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"1c9b0f43-00da-4ca3-bd25-b4033ac63c5d" name:@"制皮"],
                         [[MAFYcYdDataModel alloc] initWithId:@"6867b8c7-453c-4b4b-aa0a-f0d355a36866" name:@"食用"],
                         [[MAFYcYdDataModel alloc] initWithId:@"40d161d5-b326-4ce0-9f51-ae7bbb6b070a" name:@"其它"]];
        [_dataDic setValue:a25 forKey:@"use"];
    }
    return self;
}

- (NSArray *)getDataWithType:(NSString *)type {
    return [_dataDic valueForKey:type];
}

@end
