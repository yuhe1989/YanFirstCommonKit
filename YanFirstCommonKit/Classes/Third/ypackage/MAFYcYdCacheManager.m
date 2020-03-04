//
//  MAFYcYdCacheManager.m
//  MAF
//
//  Created by wang k on 2018/3/6.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdCacheManager.h"
#import "FMDatabaseQueue.h"
#import "MAFCommonClass.h"


#define COMMONCLASS [MAFCommonClass shareCommonClass]


/**
 ycyd_info0515      一场一档基本信息
 ycyd_filelist  一场一档关联附件
 */
@interface MAFYcYdCacheManager ()
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation MAFYcYdCacheManager

+ (instancetype)sharedInstance {
    static id db = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        db = [[self alloc] init];
        [db initDataBase];
    });
    return db;
}

- (void)initDataBase {
    NSString *documentPath = COMMONCLASS.appNamePath;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"ycyd.db"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS ycyd_info0515 (form_id text PRIMARY KEY,\
         state text,\
         user_id text,\
         plat_code text,\
         chang_name text,\
         jianchang_time text,\
         sprov text,\
         sprov_name text,\
         scity text,\
         scity_name text,\
         qu_id text,\
         qu_name text,\
         zhen_id text,\
         zhen_name text,\
         cun_id text,\
         cun_name text,\
         she_id text,\
         she_name text,\
         longitude text,\
         latitude text,\
         position_name text,\
         huanbao_beian text,\
         huanbao_beianbh text,\
         yangzhi_beian text,\
         yangzhi_beianbh text,\
         dongwu_fyhgz text,\
         dongwu_fyhgzbh text,\
         zhongchu_jyxkz text,\
         zhongchu_jyxkzbh text,\
         shehui_xydm text,\
         shehui_xydmbh text,\
         is_quanjing_picture text,\
         yangzhi_quyu_id text,\
         yangzhi_quyu_name text,\
         yangzhi_ydsp_id text,\
         yangzhi_ydsp_name text,\
         yangzhi_ydqs_id text,\
         yangzhi_ydqs_name text,\
         chang_fz_idcard text,\
         chang_fz_name text,\
         chang_tel text,\
         chang_phone text,\
         operatorList text,\
         scyxzt_id text,\
         scyxzt_name text,\
         zhengzhinianxian text,\
         shutdown_status text,\
         shutdown_time text,\
         plan_shutdown_time text,\
         xqzhongl_id text,\
         xqzhongl_name text,\
         zhuyaopz text,\
         yangzhimoshi_id text,\
         yangzhimoshi_name text,\
         is_sfxqyzc text,\
         is_sfxqyzc_name text,\
         sqjiancedian_id text,\
         sqjiancedian_name text,\
         yangzhifs_id text,\
         yangzhifs_name text,\
         quanshe_id text,\
         quanshe_name text,\
         sheji_cunlan_num text,\
         sheji_nianchulan_num text,\
         sheji_muchu_num text,\
         now_all_chunlan_num text,\
         shangpin_chunlan_num text,\
         muchu_cunlan_num text,\
         gongchu_chunlan_num text,\
         yangzhi_yongdi_mianji text,\
         zhongchu_jianzhu_mianji text,\
         shangchu_jianzhu_mianji text,\
         shifouazzxjk text,\
         shifouanzxjiance text,\
         is_fenwuzhipai text,\
         fenbianchuliliyong_id text,\
         fenbianchuliliyong_name text,\
         qingffs_id text,\
         qingffs_name text,\
         shifouysfl text,\
         is_guyefenli text,\
         ganshifenlisheshi_id text,\
         ganshifenlisheshi_name text,\
         paiwuxkz text,\
         paiwuxkzbh text,\
         is_wushuichuli text,\
         wushui_lyfs_id text,\
         wushui_lyfs_name text,\
         is_paifang text,\
         paifangbiaoz_id text,\
         paifangbiaoz_name text,\
         is_zhaoqichuli text,\
         is_zhaoqichuli_zhengchang text,\
         zhaojichi_fang text,\
         zqccjly_id text,\
         zqccjly_name text,\
         jizhonggq text,\
         zhaoyhtcs_id text,\
         zhaoyhtcs_name text,\
         zhaoyhtcs_num1 text,\
         zhaoyhtcs_num2 text,\
         zhaoyhtcs_num3 text,\
         chang_chuye_ge text,\
         chang_chuye_fang text,\
         tianjian_chuye_ge text,\
         tianjian_chuye_fang text,\
         ganfen_chucunsheshi_id text,\
         ganfen_chucunsheshi_name text,\
         ganfen_chucunsheshi_fy_num text,\
         ganfen_chucunsheshi_wfy_num text,\
         ganfen_fajiaosheshi_id text,\
         ganfen_fajiaosheshi_name text,\
         ganfen_fajiaosheshi_wufangyu text,\
         ganfen_fajiaosheshi_youfangyu text,\
         peitaoxnnmyd text,\
         peitaoxnnmyd_name text,\
         xiaonnydmj text,\
         xiaonzzwglmj text,\
         is_yjfsc text,\
         is_yjfsc_num text,\
         qt_fwclsbmcjsl text,\
         is_peitaossccclys text,\
         liyonglv text,\
         sc_youjifei_zhbl text,\
         is_tousu text,\
         huanplb_id text,\
         huanplb_name text,\
         santsgl_id text,\
         santsgl_name text,\
         is_hbclss text,\
         is_hbclss_name text,\
         huanbaosheshi text,\
         huanbaobutie text,\
         remark text,\
         xj_username text,\
         xj_time text,\
         qianming text,\
         remark1 text,\
         remark2 text,\
         is_weiqiang text,\
         is_zhuanzhishouyi text,\
         yanjiusheng_shouyi_num text,\
         benke_shouyi_num text,\
         dazhuan_shouyi_num text,\
         is_jianzhi text,\
         shouyi_num text,\
         all_user_num text,\
         yongtu_name text,\
         is_fenkai text,\
         geli_mianji text,\
         shenghuo_mianji text,\
         xingzheng_mianji text,\
         is_gaoyugandao text,\
         is_tuzaichang text,\
         is_jingruchangqu text,\
         is_chongxi text,\
         is_sheshi text,\
         is_zhongzhuan text,\
         is_quyu text,\
         is_xiaodusheshi text,\
         is_wuhaihua text,\
         chuli_fangshi text,\
         chuli_fangshi_name text,\
         is_tongdao text,\
         is_meishusheshi text,\
         diaochudi_sprov text,\
         diaochudi_sprov_name text,\
         diaochudi_scity text,\
         diaochudi_scity_name text,\
         diaochudi_qu_id text,\
         diaochudi_qu_name text,\
         diaochudi_zhen_id text,\
         diaochudi_zhen_name text)"];
    }];
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS ycyd_filelist (form_id text,\
         file_url text,\
         file_name text,\
         pic_name text,\
         file_type text,\
         file_code text,\
         file_data text,\
         remark1 text,\
         remark2 text)"];
    }];
}

- (void)addYcYdInfoWithDic:(NSDictionary *)dic remark1:(NSString *)remark1 remark2:(NSString *)remark2 {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"INSERT INTO ycyd_info0515(form_id, state, user_id, plat_code, chang_name, jianchang_time, sprov, sprov_name, scity, scity_name, qu_id, qu_name, zhen_id, zhen_name, cun_id, cun_name, she_id, she_name, longitude, latitude, position_name, huanbao_beian, huanbao_beianbh, yangzhi_beian, yangzhi_beianbh, dongwu_fyhgz, dongwu_fyhgzbh, zhongchu_jyxkz, zhongchu_jyxkzbh, shehui_xydm, shehui_xydmbh, is_quanjing_picture, yangzhi_quyu_id, yangzhi_quyu_name, yangzhi_ydsp_id, yangzhi_ydsp_name, yangzhi_ydqs_id, yangzhi_ydqs_name, chang_fz_idcard, chang_fz_name, chang_tel, chang_phone, operatorList, scyxzt_id, scyxzt_name, zhengzhinianxian, shutdown_status, shutdown_time, plan_shutdown_time, xqzhongl_id, xqzhongl_name, zhuyaopz, yangzhimoshi_id, yangzhimoshi_name, is_sfxqyzc, is_sfxqyzc_name, sqjiancedian_id, sqjiancedian_name, yangzhifs_id, yangzhifs_name, quanshe_id, quanshe_name, sheji_cunlan_num, sheji_nianchulan_num, sheji_muchu_num, now_all_chunlan_num, shangpin_chunlan_num, muchu_cunlan_num, gongchu_chunlan_num, yangzhi_yongdi_mianji, zhongchu_jianzhu_mianji, shangchu_jianzhu_mianji, shifouazzxjk, shifouanzxjiance, is_fenwuzhipai, fenbianchuliliyong_id, fenbianchuliliyong_name, qingffs_id, qingffs_name, shifouysfl, is_guyefenli, ganshifenlisheshi_id, ganshifenlisheshi_name, paiwuxkz, paiwuxkzbh, is_wushuichuli, wushui_lyfs_id, wushui_lyfs_name, is_paifang, paifangbiaoz_id, paifangbiaoz_name, is_zhaoqichuli, is_zhaoqichuli_zhengchang, zhaojichi_fang, zqccjly_id, zqccjly_name, jizhonggq, zhaoyhtcs_id, zhaoyhtcs_name, zhaoyhtcs_num1, zhaoyhtcs_num2, zhaoyhtcs_num3, chang_chuye_ge, chang_chuye_fang, tianjian_chuye_ge, tianjian_chuye_fang, ganfen_chucunsheshi_id, ganfen_chucunsheshi_name, ganfen_chucunsheshi_fy_num, ganfen_chucunsheshi_wfy_num, ganfen_fajiaosheshi_id, ganfen_fajiaosheshi_name, ganfen_fajiaosheshi_wufangyu, ganfen_fajiaosheshi_youfangyu, peitaoxnnmyd, peitaoxnnmyd_name, xiaonnydmj, xiaonzzwglmj, is_yjfsc, is_yjfsc_num, qt_fwclsbmcjsl, is_peitaossccclys, liyonglv, sc_youjifei_zhbl, is_tousu, huanplb_id, huanplb_name, santsgl_id, santsgl_name, is_hbclss, is_hbclss_name, huanbaosheshi, huanbaobutie, remark, xj_username, xj_time, qianming, remark1, remark2, is_weiqiang, is_zhuanzhishouyi, yanjiusheng_shouyi_num, benke_shouyi_num, dazhuan_shouyi_num, is_jianzhi, shouyi_num, all_user_num, yongtu_name, is_fenkai, geli_mianji, shenghuo_mianji, xingzheng_mianji, is_gaoyugandao, is_tuzaichang, is_jingruchangqu, is_chongxi, is_sheshi, is_zhongzhuan, is_quyu, is_xiaodusheshi, is_wuhaihua, chuli_fangshi, chuli_fangshi_name, is_tongdao, is_meishusheshi, diaochudi_sprov, diaochudi_sprov_name, diaochudi_scity, diaochudi_scity_name, diaochudi_qu_id, diaochudi_qu_name, diaochudi_zhen_id, diaochudi_zhen_name) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", dic[@"farmcheck_id"], dic[@"state"], dic[@"user_id"], dic[@"plat_code"], dic[@"chang_name"], dic[@"jianchang_time"], dic[@"sprov"], dic[@"sprov_name"], dic[@"scity"], dic[@"scity_name"], dic[@"qu_id"], dic[@"qu_name"], dic[@"zhen_id"], dic[@"zhen_name"], dic[@"cun_id"], dic[@"cun_name"], dic[@"she_id"], dic[@"she_name"], dic[@"longitude"], dic[@"latitude"], dic[@"position_name"], dic[@"huanbao_beian"], dic[@"huanbao_beianbh"], dic[@"yangzhi_beian"], dic[@"yangzhi_beianbh"], dic[@"dongwu_fyhgz"], dic[@"dongwu_fyhgzbh"], dic[@"zhongchu_jyxkz"], dic[@"zhongchu_jyxkzbh"], dic[@"shehui_xydm"], dic[@"shehui_xydmbh"], dic[@"is_quanjing_picture"], dic[@"yangzhi_quyu_id"], dic[@"yangzhi_quyu_name"], dic[@"yangzhi_ydsp_id"], dic[@"yangzhi_ydsp_name"], dic[@"yangzhi_ydqs_id"], dic[@"yangzhi_ydqs_name"], dic[@"chang_fz_idcard"], dic[@"chang_fz_name"], dic[@"chang_tel"], dic[@"chang_phone"], dic[@"operatorList"], dic[@"scyxzt_id"], dic[@"scyxzt_name"], dic[@"zhengzhinianxian"], dic[@"shutdown_status"], dic[@"shutdown_time"], dic[@"plan_shutdown_time"], dic[@"xqzhongl_id"], dic[@"xqzhongl_name"], dic[@"zhuyaopz"], dic[@"yangzhimoshi_id"], dic[@"yangzhimoshi_name"], dic[@"is_sfxqyzc"], dic[@"is_sfxqyzc_name"], dic[@"sqjiancedian_id"], dic[@"sqjiancedian_name"], dic[@"yangzhifs_id"], dic[@"yangzhifs_name"], dic[@"quanshe_id"], dic[@"quanshe_name"], dic[@"sheji_cunlan_num"], dic[@"sheji_nianchulan_num"], dic[@"sheji_muchu_num"], dic[@"now_all_chunlan_num"], dic[@"shangpin_chunlan_num"], dic[@"muchu_cunlan_num"], dic[@"gongchu_chunlan_num"], dic[@"yangzhi_yongdi_mianji"], dic[@"zhongchu_jianzhu_mianji"], dic[@"shangchu_jianzhu_mianji"], dic[@"shifouazzxjk"], dic[@"shifouanzxjiance"], dic[@"is_fenwuzhipai"], dic[@"fenbianchuliliyong_id"], dic[@"fenbianchuliliyong_name"], dic[@"qingffs_id"], dic[@"qingffs_name"], dic[@"shifouysfl"], dic[@"is_guyefenli"], dic[@"ganshifenlisheshi_id"], dic[@"ganshifenlisheshi_name"], dic[@"paiwuxkz"], dic[@"paiwuxkzbh"], dic[@"is_wushuichuli"], dic[@"wushui_lyfs_id"], dic[@"wushui_lyfs_name"], dic[@"is_paifang"], dic[@"paifangbiaoz_id"], dic[@"paifangbiaoz_name"], dic[@"is_zhaoqichuli"], dic[@"is_zhaoqichuli_zhengchang"], dic[@"zhaojichi_fang"], dic[@"zqccjly_id"], dic[@"zqccjly_name"], dic[@"jizhonggq"], dic[@"zhaoyhtcs_id"], dic[@"zhaoyhtcs_name"], dic[@"zhaoyhtcs_num1"], dic[@"zhaoyhtcs_num2"], dic[@"zhaoyhtcs_num3"], dic[@"chang_chuye_ge"], dic[@"chang_chuye_fang"], dic[@"tianjian_chuye_ge"], dic[@"tianjian_chuye_fang"], dic[@"ganfen_chucunsheshi_id"], dic[@"ganfen_chucunsheshi_name"], dic[@"ganfen_chucunsheshi_fy_num"], dic[@"ganfen_chucunsheshi_wfy_num"], dic[@"ganfen_fajiaosheshi_id"], dic[@"ganfen_fajiaosheshi_name"], dic[@"ganfen_fajiaosheshi_wufangyu"], dic[@"ganfen_fajiaosheshi_youfangyu"], dic[@"peitaoxnnmyd"], dic[@"peitaoxnnmyd_name"], dic[@"xiaonnydmj"], dic[@"xiaonzzwglmj"], dic[@"is_yjfsc"], dic[@"is_yjfsc_num"], dic[@"qt_fwclsbmcjsl"], dic[@"is_peitaossccclys"], dic[@"liyonglv"], dic[@"sc_youjifei_zhbl"], dic[@"is_tousu"], dic[@"huanplb_id"], dic[@"huanplb_name"], dic[@"santsgl_id"], dic[@"santsgl_name"], dic[@"is_hbclss"], dic[@"is_hbclss_name"], dic[@"huanbaosheshi"], dic[@"huanbaobutie"], dic[@"remark"], dic[@"xj_username"], dic[@"xj_time"], dic[@"qianming"], remark1, remark2, dic[@"is_weiqiang"], dic[@"is_zhuanzhishouyi"], dic[@"yanjiusheng_shouyi_num"], dic[@"benke_shouyi_num"], dic[@"dazhuan_shouyi_num"], dic[@"is_jianzhi"], dic[@"shouyi_num"], dic[@"all_user_num"], dic[@"yongtu_name"], dic[@"is_fenkai"], dic[@"geli_mianji"], dic[@"shenghuo_mianji"], dic[@"xingzheng_mianji"], dic[@"is_gaoyugandao"], dic[@"is_tuzaichang"], dic[@"is_jingruchangqu"], dic[@"is_chongxi"], dic[@"is_sheshi"], dic[@"is_zhongzhuan"], dic[@"is_quyu"], dic[@"is_xiaodusheshi"], dic[@"is_wuhaihua"], dic[@"chuli_fangshi"], dic[@"chuli_fangshi_name"], dic[@"is_tongdao"], dic[@"is_meishusheshi"], dic[@"diaochudi_sprov"], dic[@"diaochudi_sprov_name"], dic[@"diaochudi_scity"], dic[@"diaochudi_scity_name"], dic[@"diaochudi_qu_id"], dic[@"diaochudi_qu_name"], dic[@"diaochudi_zhen_id"], dic[@"diaochudi_zhen_name"]];
    }];
}

- (void)updateYcYdInfoWithDic:(NSMutableDictionary *)dic userID:(NSString *)userID formID:(NSString *)formID {
    
    for (NSString *key in dic.allKeys) {
        NSString *value = dic[key];
        [_queue inDatabase:^(FMDatabase *db) {
            NSString *sqlStr = [NSString stringWithFormat:@"UPDATE ycyd_info0515 SET '%@' = '%@' WHERE user_id = '%@' AND form_id = '%@'", key, value, userID, formID];
            [db executeUpdate:sqlStr];
        }];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YCYD_UPDATE_SUCCESS" object:nil];
}

- (NSMutableArray *)searchYcYdCacheListWithUserID:(NSString *)userID {
    __block NSMutableArray *cacheList = @[].mutableCopy;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE user_id = ?", userID];
        while ([set next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[set stringForColumn:@"form_id"] forKey:@"farmcheck_id"];
            [dic setValue:[set stringForColumn:@"state"] forKey:@"state"];
            [dic setValue:[set stringForColumn:@"user_id"] forKey:@"user_id"];
            [dic setValue:[set stringForColumn:@"plat_code"] forKey:@"plat_code"];
            [dic setValue:[set stringForColumn:@"chang_name"] forKey:@"chang_name"];
            [dic setValue:[set stringForColumn:@"jianchang_time"] forKey:@"jianchang_time"];
            [dic setValue:[set stringForColumn:@"sprov"] forKey:@"sprov"];
            [dic setValue:[set stringForColumn:@"sprov_name"] forKey:@"sprov_name"];
            [dic setValue:[set stringForColumn:@"scity"] forKey:@"scity"];
            [dic setValue:[set stringForColumn:@"scity_name"] forKey:@"scity_name"];
            [dic setValue:[set stringForColumn:@"qu_id"] forKey:@"qu_id"];
            [dic setValue:[set stringForColumn:@"qu_name"] forKey:@"qu_name"];
            [dic setValue:[set stringForColumn:@"zhen_id"] forKey:@"zhen_id"];
            [dic setValue:[set stringForColumn:@"zhen_name"] forKey:@"zhen_name"];
            [dic setValue:[set stringForColumn:@"cun_id"] forKey:@"cun_id"];
            [dic setValue:[set stringForColumn:@"cun_name"] forKey:@"cun_name"];
            [dic setValue:[set stringForColumn:@"she_id"] forKey:@"she_id"];
            [dic setValue:[set stringForColumn:@"she_name"] forKey:@"she_name"];
            [dic setValue:[set stringForColumn:@"longitude"] forKey:@"longitude"];
            [dic setValue:[set stringForColumn:@"latitude"] forKey:@"latitude"];
            [dic setValue:[set stringForColumn:@"position_name"] forKey:@"position_name"];
            [dic setValue:[set stringForColumn:@"huanbao_beian"] forKey:@"huanbao_beian"];
            [dic setValue:[set stringForColumn:@"huanbao_beianbh"] forKey:@"huanbao_beianbh"];
            [dic setValue:[set stringForColumn:@"yangzhi_beian"] forKey:@"yangzhi_beian"];
            [dic setValue:[set stringForColumn:@"yangzhi_beianbh"] forKey:@"yangzhi_beianbh"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgz"] forKey:@"dongwu_fyhgz"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgzbh"] forKey:@"dongwu_fyhgzbh"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkz"] forKey:@"zhongchu_jyxkz"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkzbh"] forKey:@"zhongchu_jyxkzbh"];
            [dic setValue:[set stringForColumn:@"shehui_xydm"] forKey:@"shehui_xydm"];
            [dic setValue:[set stringForColumn:@"shehui_xydmbh"] forKey:@"shehui_xydmbh"];
            [dic setValue:[set stringForColumn:@"is_quanjing_picture"] forKey:@"is_quanjing_picture"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_id"] forKey:@"yangzhi_quyu_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_name"] forKey:@"yangzhi_quyu_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_id"] forKey:@"yangzhi_ydsp_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_name"] forKey:@"yangzhi_ydsp_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_id"] forKey:@"yangzhi_ydqs_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_name"] forKey:@"yangzhi_ydqs_name"];
            [dic setValue:[set stringForColumn:@"chang_fz_idcard"] forKey:@"chang_fz_idcard"];
            [dic setValue:[set stringForColumn:@"chang_fz_name"] forKey:@"chang_fz_name"];
            [dic setValue:[set stringForColumn:@"chang_tel"] forKey:@"chang_tel"];
            [dic setValue:[set stringForColumn:@"chang_phone"] forKey:@"chang_phone"];
            [dic setValue:[set stringForColumn:@"operatorList"] forKey:@"operatorList"];
            [dic setValue:[set stringForColumn:@"scyxzt_id"] forKey:@"scyxzt_id"];
            [dic setValue:[set stringForColumn:@"scyxzt_name"] forKey:@"scyxzt_name"];
            [dic setValue:[set stringForColumn:@"zhengzhinianxian"] forKey:@"zhengzhinianxian"];
            [dic setValue:[set stringForColumn:@"shutdown_status"] forKey:@"shutdown_status"];
            [dic setValue:[set stringForColumn:@"shutdown_time"] forKey:@"shutdown_time"];
            [dic setValue:[set stringForColumn:@"plan_shutdown_time"] forKey:@"plan_shutdown_time"];
            [dic setValue:[set stringForColumn:@"xqzhongl_id"] forKey:@"xqzhongl_id"];
            [dic setValue:[set stringForColumn:@"xqzhongl_name"] forKey:@"xqzhongl_name"];
            [dic setValue:[set stringForColumn:@"zhuyaopz"] forKey:@"zhuyaopz"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_id"] forKey:@"yangzhimoshi_id"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_name"] forKey:@"yangzhimoshi_name"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc"] forKey:@"is_sfxqyzc"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc_name"] forKey:@"is_sfxqyzc_name"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_id"] forKey:@"sqjiancedian_id"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_name"] forKey:@"sqjiancedian_name"];
            [dic setValue:[set stringForColumn:@"yangzhifs_id"] forKey:@"yangzhifs_id"];
            [dic setValue:[set stringForColumn:@"yangzhifs_name"] forKey:@"yangzhifs_name"];
            [dic setValue:[set stringForColumn:@"quanshe_id"] forKey:@"quanshe_id"];
            [dic setValue:[set stringForColumn:@"quanshe_name"] forKey:@"quanshe_name"];
            [dic setValue:[set stringForColumn:@"sheji_cunlan_num"] forKey:@"sheji_cunlan_num"];
            [dic setValue:[set stringForColumn:@"sheji_nianchulan_num"] forKey:@"sheji_nianchulan_num"];
            [dic setValue:[set stringForColumn:@"sheji_muchu_num"] forKey:@"sheji_muchu_num"];
            [dic setValue:[set stringForColumn:@"now_all_chunlan_num"] forKey:@"now_all_chunlan_num"];
            [dic setValue:[set stringForColumn:@"shangpin_chunlan_num"] forKey:@"shangpin_chunlan_num"];
            [dic setValue:[set stringForColumn:@"muchu_cunlan_num"] forKey:@"muchu_cunlan_num"];
            [dic setValue:[set stringForColumn:@"gongchu_chunlan_num"] forKey:@"gongchu_chunlan_num"];
            [dic setValue:[set stringForColumn:@"yangzhi_yongdi_mianji"] forKey:@"yangzhi_yongdi_mianji"];
            [dic setValue:[set stringForColumn:@"zhongchu_jianzhu_mianji"] forKey:@"zhongchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shangchu_jianzhu_mianji"] forKey:@"shangchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shifouazzxjk"] forKey:@"shifouazzxjk"];
            [dic setValue:[set stringForColumn:@"shifouanzxjiance"] forKey:@"shifouanzxjiance"];
            [dic setValue:[set stringForColumn:@"is_fenwuzhipai"] forKey:@"is_fenwuzhipai"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_id"] forKey:@"fenbianchuliliyong_id"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_name"] forKey:@"fenbianchuliliyong_name"];
            [dic setValue:[set stringForColumn:@"qingffs_id"] forKey:@"qingffs_id"];
            [dic setValue:[set stringForColumn:@"qingffs_name"] forKey:@"qingffs_name"];
            [dic setValue:[set stringForColumn:@"shifouysfl"] forKey:@"shifouysfl"];
            [dic setValue:[set stringForColumn:@"is_guyefenli"] forKey:@"is_guyefenli"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_id"] forKey:@"ganshifenlisheshi_id"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_name"] forKey:@"ganshifenlisheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_id"] forKey:@"ganfen_fajiaosheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_name"] forKey:@"ganfen_fajiaosheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_wufangyu"] forKey:@"ganfen_fajiaosheshi_wufangyu"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_youfangyu"] forKey:@"ganfen_fajiaosheshi_youfangyu"];
            [dic setValue:[set stringForColumn:@"paiwuxkz"] forKey:@"paiwuxkz"];
            [dic setValue:[set stringForColumn:@"paiwuxkzbh"] forKey:@"paiwuxkzbh"];
            [dic setValue:[set stringForColumn:@"is_wushuichuli"] forKey:@"is_wushuichuli"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_id"] forKey:@"wushui_lyfs_id"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_name"] forKey:@"wushui_lyfs_name"];
            [dic setValue:[set stringForColumn:@"is_paifang"] forKey:@"is_paifang"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_id"] forKey:@"paifangbiaoz_id"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_name"] forKey:@"paifangbiaoz_name"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli"] forKey:@"is_zhaoqichuli"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli_zhengchang"] forKey:@"is_zhaoqichuli_zhengchang"];
            [dic setValue:[set stringForColumn:@"zhaojichi_fang"] forKey:@"zhaojichi_fang"];
            [dic setValue:[set stringForColumn:@"zqccjly_id"] forKey:@"zqccjly_id"];
            [dic setValue:[set stringForColumn:@"zqccjly_name"] forKey:@"zqccjly_name"];
            [dic setValue:[set stringForColumn:@"jizhonggq"] forKey:@"jizhonggq"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_id"] forKey:@"zhaoyhtcs_id"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_name"] forKey:@"zhaoyhtcs_name"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num1"] forKey:@"zhaoyhtcs_num1"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num2"] forKey:@"zhaoyhtcs_num2"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num3"] forKey:@"zhaoyhtcs_num3"];
            [dic setValue:[set stringForColumn:@"chang_chuye_ge"] forKey:@"chang_chuye_ge"];
            [dic setValue:[set stringForColumn:@"chang_chuye_fang"] forKey:@"chang_chuye_fang"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_ge"] forKey:@"tianjian_chuye_ge"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_fang"] forKey:@"tianjian_chuye_fang"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_id"] forKey:@"ganfen_chucunsheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_name"] forKey:@"ganfen_chucunsheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_fy_num"] forKey:@"ganfen_chucunsheshi_fy_num"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_wfy_num"] forKey:@"ganfen_chucunsheshi_wfy_num"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd"] forKey:@"peitaoxnnmyd"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd_name"] forKey:@"peitaoxnnmyd_name"];
            [dic setValue:[set stringForColumn:@"xiaonnydmj"] forKey:@"xiaonnydmj"];
            [dic setValue:[set stringForColumn:@"xiaonzzwglmj"] forKey:@"xiaonzzwglmj"];
            [dic setValue:[set stringForColumn:@"is_yjfsc"] forKey:@"is_yjfsc"];
            [dic setValue:[set stringForColumn:@"is_yjfsc_num"] forKey:@"is_yjfsc_num"];
            [dic setValue:[set stringForColumn:@"qt_fwclsbmcjsl"] forKey:@"qt_fwclsbmcjsl"];
            [dic setValue:[set stringForColumn:@"is_peitaossccclys"] forKey:@"is_peitaossccclys"];
            [dic setValue:[set stringForColumn:@"liyonglv"] forKey:@"liyonglv"];
            [dic setValue:[set stringForColumn:@"sc_youjifei_zhbl"] forKey:@"sc_youjifei_zhbl"];
            [dic setValue:[set stringForColumn:@"is_tousu"] forKey:@"is_tousu"];
            [dic setValue:[set stringForColumn:@"huanplb_id"] forKey:@"huanplb_id"];
            [dic setValue:[set stringForColumn:@"huanplb_name"] forKey:@"huanplb_name"];
            [dic setValue:[set stringForColumn:@"santsgl_id"] forKey:@"santsgl_id"];
            [dic setValue:[set stringForColumn:@"santsgl_name"] forKey:@"santsgl_name"];
            [dic setValue:[set stringForColumn:@"is_hbclss"] forKey:@"is_hbclss"];
            [dic setValue:[set stringForColumn:@"is_hbclss_name"] forKey:@"is_hbclss_name"];
            [dic setValue:[set stringForColumn:@"huanbaosheshi"] forKey:@"huanbaosheshi"];
            [dic setValue:[set stringForColumn:@"huanbaobutie"] forKey:@"huanbaobutie"];
            [dic setValue:[set stringForColumn:@"remark"] forKey:@"remark"];
            [dic setValue:[set stringForColumn:@"xj_username"] forKey:@"xj_username"];
            [dic setValue:[set stringForColumn:@"xj_time"] forKey:@"xj_time"];
            [dic setValue:[set stringForColumn:@"qianming"] forKey:@"qianming"];
            [dic setValue:[set stringForColumn:@"remark1"] forKey:@"remark1"];
            [dic setValue:[set stringForColumn:@"remark2"] forKey:@"remark2"];
            
            [dic setValue:[set stringForColumn:@"is_weiqiang"] forKey:@"is_weiqiang"];
            [dic setValue:[set stringForColumn:@"is_zhuanzhishouyi"] forKey:@"is_zhuanzhishouyi"];
            [dic setValue:[set stringForColumn:@"yanjiusheng_shouyi_num"] forKey:@"yanjiusheng_shouyi_num"];
            [dic setValue:[set stringForColumn:@"benke_shouyi_num"] forKey:@"benke_shouyi_num"];
            [dic setValue:[set stringForColumn:@"dazhuan_shouyi_num"] forKey:@"dazhuan_shouyi_num"];
            [dic setValue:[set stringForColumn:@"is_jianzhi"] forKey:@"is_jianzhi"];
            [dic setValue:[set stringForColumn:@"shouyi_num"] forKey:@"shouyi_num"];
            [dic setValue:[set stringForColumn:@"all_user_num"] forKey:@"all_user_num"];
            [dic setValue:[set stringForColumn:@"yongtu_name"] forKey:@"yongtu_name"];
            [dic setValue:[set stringForColumn:@"is_fenkai"] forKey:@"is_fenkai"];
            [dic setValue:[set stringForColumn:@"geli_mianji"] forKey:@"geli_mianji"];
            [dic setValue:[set stringForColumn:@"shenghuo_mianji"] forKey:@"shenghuo_mianji"];
            [dic setValue:[set stringForColumn:@"xingzheng_mianji"] forKey:@"xingzheng_mianji"];
            [dic setValue:[set stringForColumn:@"is_gaoyugandao"] forKey:@"is_gaoyugandao"];
            [dic setValue:[set stringForColumn:@"is_tuzaichang"] forKey:@"is_tuzaichang"];
            [dic setValue:[set stringForColumn:@"is_jingruchangqu"] forKey:@"is_jingruchangqu"];
            [dic setValue:[set stringForColumn:@"is_chongxi"] forKey:@"is_chongxi"];
            [dic setValue:[set stringForColumn:@"is_sheshi"] forKey:@"is_sheshi"];
            [dic setValue:[set stringForColumn:@"is_zhongzhuan"] forKey:@"is_zhongzhuan"];
            [dic setValue:[set stringForColumn:@"is_quyu"] forKey:@"is_quyu"];
            [dic setValue:[set stringForColumn:@"is_xiaodusheshi"] forKey:@"is_xiaodusheshi"];
            [dic setValue:[set stringForColumn:@"is_wuhaihua"] forKey:@"is_wuhaihua"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi"] forKey:@"chuli_fangshi"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi_name"] forKey:@"chuli_fangshi_name"];
            [dic setValue:[set stringForColumn:@"is_tongdao"] forKey:@"is_tongdao"];
            [dic setValue:[set stringForColumn:@"is_meishusheshi"] forKey:@"is_meishusheshi"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov"] forKey:@"diaochudi_sprov"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov_name"] forKey:@"diaochudi_sprov_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity"] forKey:@"diaochudi_scity"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity_name"] forKey:@"diaochudi_scity_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_id"] forKey:@"diaochudi_qu_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_name"] forKey:@"diaochudi_qu_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_id"] forKey:@"diaochudi_zhen_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_name"] forKey:@"diaochudi_zhen_name"];
            
            
            [cacheList addObject:dic];
        }
    }];
    return cacheList;
}
//根据畜禽养殖代码检索数据库
- (NSMutableArray *)searchYcYdXQYZDM:(NSString *)xqyzdm {
    __block NSMutableArray *cacheList = @[].mutableCopy;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE yangzhi_beianbh = ?", xqyzdm];
        while ([set next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[set stringForColumn:@"form_id"] forKey:@"farmcheck_id"];
            [dic setValue:[set stringForColumn:@"state"] forKey:@"state"];
            [dic setValue:[set stringForColumn:@"user_id"] forKey:@"user_id"];
            [dic setValue:[set stringForColumn:@"plat_code"] forKey:@"plat_code"];
            [dic setValue:[set stringForColumn:@"chang_name"] forKey:@"chang_name"];
            [dic setValue:[set stringForColumn:@"jianchang_time"] forKey:@"jianchang_time"];
            [dic setValue:[set stringForColumn:@"sprov"] forKey:@"sprov"];
            [dic setValue:[set stringForColumn:@"sprov_name"] forKey:@"sprov_name"];
            [dic setValue:[set stringForColumn:@"scity"] forKey:@"scity"];
            [dic setValue:[set stringForColumn:@"scity_name"] forKey:@"scity_name"];
            [dic setValue:[set stringForColumn:@"qu_id"] forKey:@"qu_id"];
            [dic setValue:[set stringForColumn:@"qu_name"] forKey:@"qu_name"];
            [dic setValue:[set stringForColumn:@"zhen_id"] forKey:@"zhen_id"];
            [dic setValue:[set stringForColumn:@"zhen_name"] forKey:@"zhen_name"];
            [dic setValue:[set stringForColumn:@"cun_id"] forKey:@"cun_id"];
            [dic setValue:[set stringForColumn:@"cun_name"] forKey:@"cun_name"];
            [dic setValue:[set stringForColumn:@"she_id"] forKey:@"she_id"];
            [dic setValue:[set stringForColumn:@"she_name"] forKey:@"she_name"];
            [dic setValue:[set stringForColumn:@"longitude"] forKey:@"longitude"];
            [dic setValue:[set stringForColumn:@"latitude"] forKey:@"latitude"];
            [dic setValue:[set stringForColumn:@"position_name"] forKey:@"position_name"];
            [dic setValue:[set stringForColumn:@"huanbao_beian"] forKey:@"huanbao_beian"];
            [dic setValue:[set stringForColumn:@"huanbao_beianbh"] forKey:@"huanbao_beianbh"];
            [dic setValue:[set stringForColumn:@"yangzhi_beian"] forKey:@"yangzhi_beian"];
            [dic setValue:[set stringForColumn:@"yangzhi_beianbh"] forKey:@"yangzhi_beianbh"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgz"] forKey:@"dongwu_fyhgz"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgzbh"] forKey:@"dongwu_fyhgzbh"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkz"] forKey:@"zhongchu_jyxkz"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkzbh"] forKey:@"zhongchu_jyxkzbh"];
            [dic setValue:[set stringForColumn:@"shehui_xydm"] forKey:@"shehui_xydm"];
            [dic setValue:[set stringForColumn:@"shehui_xydmbh"] forKey:@"shehui_xydmbh"];
            [dic setValue:[set stringForColumn:@"is_quanjing_picture"] forKey:@"is_quanjing_picture"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_id"] forKey:@"yangzhi_quyu_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_name"] forKey:@"yangzhi_quyu_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_id"] forKey:@"yangzhi_ydsp_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_name"] forKey:@"yangzhi_ydsp_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_id"] forKey:@"yangzhi_ydqs_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_name"] forKey:@"yangzhi_ydqs_name"];
            [dic setValue:[set stringForColumn:@"chang_fz_idcard"] forKey:@"chang_fz_idcard"];
            [dic setValue:[set stringForColumn:@"chang_fz_name"] forKey:@"chang_fz_name"];
            [dic setValue:[set stringForColumn:@"chang_tel"] forKey:@"chang_tel"];
            [dic setValue:[set stringForColumn:@"chang_phone"] forKey:@"chang_phone"];
            [dic setValue:[set stringForColumn:@"operatorList"] forKey:@"operatorList"];
            [dic setValue:[set stringForColumn:@"scyxzt_id"] forKey:@"scyxzt_id"];
            [dic setValue:[set stringForColumn:@"scyxzt_name"] forKey:@"scyxzt_name"];
            [dic setValue:[set stringForColumn:@"zhengzhinianxian"] forKey:@"zhengzhinianxian"];
            [dic setValue:[set stringForColumn:@"shutdown_status"] forKey:@"shutdown_status"];
            [dic setValue:[set stringForColumn:@"shutdown_time"] forKey:@"shutdown_time"];
            [dic setValue:[set stringForColumn:@"plan_shutdown_time"] forKey:@"plan_shutdown_time"];
            [dic setValue:[set stringForColumn:@"xqzhongl_id"] forKey:@"xqzhongl_id"];
            [dic setValue:[set stringForColumn:@"xqzhongl_name"] forKey:@"xqzhongl_name"];
            [dic setValue:[set stringForColumn:@"zhuyaopz"] forKey:@"zhuyaopz"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_id"] forKey:@"yangzhimoshi_id"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_name"] forKey:@"yangzhimoshi_name"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc"] forKey:@"is_sfxqyzc"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc_name"] forKey:@"is_sfxqyzc_name"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_id"] forKey:@"sqjiancedian_id"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_name"] forKey:@"sqjiancedian_name"];
            [dic setValue:[set stringForColumn:@"yangzhifs_id"] forKey:@"yangzhifs_id"];
            [dic setValue:[set stringForColumn:@"yangzhifs_name"] forKey:@"yangzhifs_name"];
            [dic setValue:[set stringForColumn:@"quanshe_id"] forKey:@"quanshe_id"];
            [dic setValue:[set stringForColumn:@"quanshe_name"] forKey:@"quanshe_name"];
            [dic setValue:[set stringForColumn:@"sheji_cunlan_num"] forKey:@"sheji_cunlan_num"];
            [dic setValue:[set stringForColumn:@"sheji_nianchulan_num"] forKey:@"sheji_nianchulan_num"];
            [dic setValue:[set stringForColumn:@"sheji_muchu_num"] forKey:@"sheji_muchu_num"];
            [dic setValue:[set stringForColumn:@"now_all_chunlan_num"] forKey:@"now_all_chunlan_num"];
            [dic setValue:[set stringForColumn:@"shangpin_chunlan_num"] forKey:@"shangpin_chunlan_num"];
            [dic setValue:[set stringForColumn:@"muchu_cunlan_num"] forKey:@"muchu_cunlan_num"];
            [dic setValue:[set stringForColumn:@"gongchu_chunlan_num"] forKey:@"gongchu_chunlan_num"];
            [dic setValue:[set stringForColumn:@"yangzhi_yongdi_mianji"] forKey:@"yangzhi_yongdi_mianji"];
            [dic setValue:[set stringForColumn:@"zhongchu_jianzhu_mianji"] forKey:@"zhongchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shangchu_jianzhu_mianji"] forKey:@"shangchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shifouazzxjk"] forKey:@"shifouazzxjk"];
            [dic setValue:[set stringForColumn:@"shifouanzxjiance"] forKey:@"shifouanzxjiance"];
            [dic setValue:[set stringForColumn:@"is_fenwuzhipai"] forKey:@"is_fenwuzhipai"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_id"] forKey:@"fenbianchuliliyong_id"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_name"] forKey:@"fenbianchuliliyong_name"];
            [dic setValue:[set stringForColumn:@"qingffs_id"] forKey:@"qingffs_id"];
            [dic setValue:[set stringForColumn:@"qingffs_name"] forKey:@"qingffs_name"];
            [dic setValue:[set stringForColumn:@"shifouysfl"] forKey:@"shifouysfl"];
            [dic setValue:[set stringForColumn:@"is_guyefenli"] forKey:@"is_guyefenli"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_id"] forKey:@"ganshifenlisheshi_id"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_name"] forKey:@"ganshifenlisheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_id"] forKey:@"ganfen_fajiaosheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_name"] forKey:@"ganfen_fajiaosheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_wufangyu"] forKey:@"ganfen_fajiaosheshi_wufangyu"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_youfangyu"] forKey:@"ganfen_fajiaosheshi_youfangyu"];
            [dic setValue:[set stringForColumn:@"paiwuxkz"] forKey:@"paiwuxkz"];
            [dic setValue:[set stringForColumn:@"paiwuxkzbh"] forKey:@"paiwuxkzbh"];
            [dic setValue:[set stringForColumn:@"is_wushuichuli"] forKey:@"is_wushuichuli"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_id"] forKey:@"wushui_lyfs_id"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_name"] forKey:@"wushui_lyfs_name"];
            [dic setValue:[set stringForColumn:@"is_paifang"] forKey:@"is_paifang"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_id"] forKey:@"paifangbiaoz_id"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_name"] forKey:@"paifangbiaoz_name"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli"] forKey:@"is_zhaoqichuli"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli_zhengchang"] forKey:@"is_zhaoqichuli_zhengchang"];
            [dic setValue:[set stringForColumn:@"zhaojichi_fang"] forKey:@"zhaojichi_fang"];
            [dic setValue:[set stringForColumn:@"zqccjly_id"] forKey:@"zqccjly_id"];
            [dic setValue:[set stringForColumn:@"zqccjly_name"] forKey:@"zqccjly_name"];
            [dic setValue:[set stringForColumn:@"jizhonggq"] forKey:@"jizhonggq"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_id"] forKey:@"zhaoyhtcs_id"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_name"] forKey:@"zhaoyhtcs_name"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num1"] forKey:@"zhaoyhtcs_num1"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num2"] forKey:@"zhaoyhtcs_num2"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num3"] forKey:@"zhaoyhtcs_num3"];
            [dic setValue:[set stringForColumn:@"chang_chuye_ge"] forKey:@"chang_chuye_ge"];
            [dic setValue:[set stringForColumn:@"chang_chuye_fang"] forKey:@"chang_chuye_fang"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_ge"] forKey:@"tianjian_chuye_ge"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_fang"] forKey:@"tianjian_chuye_fang"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_id"] forKey:@"ganfen_chucunsheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_name"] forKey:@"ganfen_chucunsheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_fy_num"] forKey:@"ganfen_chucunsheshi_fy_num"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_wfy_num"] forKey:@"ganfen_chucunsheshi_wfy_num"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd"] forKey:@"peitaoxnnmyd"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd_name"] forKey:@"peitaoxnnmyd_name"];
            [dic setValue:[set stringForColumn:@"xiaonnydmj"] forKey:@"xiaonnydmj"];
            [dic setValue:[set stringForColumn:@"xiaonzzwglmj"] forKey:@"xiaonzzwglmj"];
            [dic setValue:[set stringForColumn:@"is_yjfsc"] forKey:@"is_yjfsc"];
            [dic setValue:[set stringForColumn:@"is_yjfsc_num"] forKey:@"is_yjfsc_num"];
            [dic setValue:[set stringForColumn:@"qt_fwclsbmcjsl"] forKey:@"qt_fwclsbmcjsl"];
            [dic setValue:[set stringForColumn:@"is_peitaossccclys"] forKey:@"is_peitaossccclys"];
            [dic setValue:[set stringForColumn:@"liyonglv"] forKey:@"liyonglv"];
            [dic setValue:[set stringForColumn:@"sc_youjifei_zhbl"] forKey:@"sc_youjifei_zhbl"];
            [dic setValue:[set stringForColumn:@"is_tousu"] forKey:@"is_tousu"];
            [dic setValue:[set stringForColumn:@"huanplb_id"] forKey:@"huanplb_id"];
            [dic setValue:[set stringForColumn:@"huanplb_name"] forKey:@"huanplb_name"];
            [dic setValue:[set stringForColumn:@"santsgl_id"] forKey:@"santsgl_id"];
            [dic setValue:[set stringForColumn:@"santsgl_name"] forKey:@"santsgl_name"];
            [dic setValue:[set stringForColumn:@"is_hbclss"] forKey:@"is_hbclss"];
            [dic setValue:[set stringForColumn:@"is_hbclss_name"] forKey:@"is_hbclss_name"];
            [dic setValue:[set stringForColumn:@"huanbaosheshi"] forKey:@"huanbaosheshi"];
            [dic setValue:[set stringForColumn:@"huanbaobutie"] forKey:@"huanbaobutie"];
            [dic setValue:[set stringForColumn:@"remark"] forKey:@"remark"];
            [dic setValue:[set stringForColumn:@"xj_username"] forKey:@"xj_username"];
            [dic setValue:[set stringForColumn:@"xj_time"] forKey:@"xj_time"];
            [dic setValue:[set stringForColumn:@"qianming"] forKey:@"qianming"];
            [dic setValue:[set stringForColumn:@"remark1"] forKey:@"remark1"];
            [dic setValue:[set stringForColumn:@"remark2"] forKey:@"remark2"];
            
            [dic setValue:[set stringForColumn:@"is_weiqiang"] forKey:@"is_weiqiang"];
            [dic setValue:[set stringForColumn:@"is_zhuanzhishouyi"] forKey:@"is_zhuanzhishouyi"];
            [dic setValue:[set stringForColumn:@"yanjiusheng_shouyi_num"] forKey:@"yanjiusheng_shouyi_num"];
            [dic setValue:[set stringForColumn:@"benke_shouyi_num"] forKey:@"benke_shouyi_num"];
            [dic setValue:[set stringForColumn:@"dazhuan_shouyi_num"] forKey:@"dazhuan_shouyi_num"];
            [dic setValue:[set stringForColumn:@"is_jianzhi"] forKey:@"is_jianzhi"];
            [dic setValue:[set stringForColumn:@"shouyi_num"] forKey:@"shouyi_num"];
            [dic setValue:[set stringForColumn:@"all_user_num"] forKey:@"all_user_num"];
            [dic setValue:[set stringForColumn:@"yongtu_name"] forKey:@"yongtu_name"];
            [dic setValue:[set stringForColumn:@"is_fenkai"] forKey:@"is_fenkai"];
            [dic setValue:[set stringForColumn:@"geli_mianji"] forKey:@"geli_mianji"];
            [dic setValue:[set stringForColumn:@"shenghuo_mianji"] forKey:@"shenghuo_mianji"];
            [dic setValue:[set stringForColumn:@"xingzheng_mianji"] forKey:@"xingzheng_mianji"];
            [dic setValue:[set stringForColumn:@"is_gaoyugandao"] forKey:@"is_gaoyugandao"];
            [dic setValue:[set stringForColumn:@"is_tuzaichang"] forKey:@"is_tuzaichang"];
            [dic setValue:[set stringForColumn:@"is_jingruchangqu"] forKey:@"is_jingruchangqu"];
            [dic setValue:[set stringForColumn:@"is_chongxi"] forKey:@"is_chongxi"];
            [dic setValue:[set stringForColumn:@"is_sheshi"] forKey:@"is_sheshi"];
            [dic setValue:[set stringForColumn:@"is_zhongzhuan"] forKey:@"is_zhongzhuan"];
            [dic setValue:[set stringForColumn:@"is_quyu"] forKey:@"is_quyu"];
            [dic setValue:[set stringForColumn:@"is_xiaodusheshi"] forKey:@"is_xiaodusheshi"];
            [dic setValue:[set stringForColumn:@"is_wuhaihua"] forKey:@"is_wuhaihua"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi"] forKey:@"chuli_fangshi"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi_name"] forKey:@"chuli_fangshi_name"];
            [dic setValue:[set stringForColumn:@"is_tongdao"] forKey:@"is_tongdao"];
            [dic setValue:[set stringForColumn:@"is_meishusheshi"] forKey:@"is_meishusheshi"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov"] forKey:@"diaochudi_sprov"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov_name"] forKey:@"diaochudi_sprov_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity"] forKey:@"diaochudi_scity"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity_name"] forKey:@"diaochudi_scity_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_id"] forKey:@"diaochudi_qu_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_name"] forKey:@"diaochudi_qu_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_id"] forKey:@"diaochudi_zhen_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_name"] forKey:@"diaochudi_zhen_name"];
            
            [cacheList addObject:dic];
        }
    }];
    return cacheList;
}

- (NSMutableDictionary *)searchYcYdInfoWithUserID:(NSString *)userID formID:(NSString *)formID {
    __block NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE user_id = ? AND form_id = ?", userID, formID];
        while ([set next]) {
            [dic setValue:[set stringForColumn:@"form_id"] forKey:@"farmcheck_id"];
            [dic setValue:[set stringForColumn:@"state"] forKey:@"state"];
            [dic setValue:[set stringForColumn:@"user_id"] forKey:@"user_id"];
            [dic setValue:[set stringForColumn:@"plat_code"] forKey:@"plat_code"];
            [dic setValue:[set stringForColumn:@"chang_name"] forKey:@"chang_name"];
            [dic setValue:[set stringForColumn:@"jianchang_time"] forKey:@"jianchang_time"];
            [dic setValue:[set stringForColumn:@"sprov"] forKey:@"sprov"];
            [dic setValue:[set stringForColumn:@"sprov_name"] forKey:@"sprov_name"];
            [dic setValue:[set stringForColumn:@"scity"] forKey:@"scity"];
            [dic setValue:[set stringForColumn:@"scity_name"] forKey:@"scity_name"];
            [dic setValue:[set stringForColumn:@"qu_id"] forKey:@"qu_id"];
            [dic setValue:[set stringForColumn:@"qu_name"] forKey:@"qu_name"];
            [dic setValue:[set stringForColumn:@"zhen_id"] forKey:@"zhen_id"];
            [dic setValue:[set stringForColumn:@"zhen_name"] forKey:@"zhen_name"];
            [dic setValue:[set stringForColumn:@"cun_id"] forKey:@"cun_id"];
            [dic setValue:[set stringForColumn:@"cun_name"] forKey:@"cun_name"];
            [dic setValue:[set stringForColumn:@"she_id"] forKey:@"she_id"];
            [dic setValue:[set stringForColumn:@"she_name"] forKey:@"she_name"];
            [dic setValue:[set stringForColumn:@"longitude"] forKey:@"longitude"];
            [dic setValue:[set stringForColumn:@"latitude"] forKey:@"latitude"];
            [dic setValue:[set stringForColumn:@"position_name"] forKey:@"position_name"];
            [dic setValue:[set stringForColumn:@"huanbao_beian"] forKey:@"huanbao_beian"];
            [dic setValue:[set stringForColumn:@"huanbao_beianbh"] forKey:@"huanbao_beianbh"];
            [dic setValue:[set stringForColumn:@"yangzhi_beian"] forKey:@"yangzhi_beian"];
            [dic setValue:[set stringForColumn:@"yangzhi_beianbh"] forKey:@"yangzhi_beianbh"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgz"] forKey:@"dongwu_fyhgz"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgzbh"] forKey:@"dongwu_fyhgzbh"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkz"] forKey:@"zhongchu_jyxkz"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkzbh"] forKey:@"zhongchu_jyxkzbh"];
            [dic setValue:[set stringForColumn:@"shehui_xydm"] forKey:@"shehui_xydm"];
            [dic setValue:[set stringForColumn:@"shehui_xydmbh"] forKey:@"shehui_xydmbh"];
            [dic setValue:[set stringForColumn:@"is_quanjing_picture"] forKey:@"is_quanjing_picture"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_id"] forKey:@"yangzhi_quyu_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_name"] forKey:@"yangzhi_quyu_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_id"] forKey:@"yangzhi_ydsp_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_name"] forKey:@"yangzhi_ydsp_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_id"] forKey:@"yangzhi_ydqs_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_name"] forKey:@"yangzhi_ydqs_name"];
            [dic setValue:[set stringForColumn:@"chang_fz_idcard"] forKey:@"chang_fz_idcard"];
            [dic setValue:[set stringForColumn:@"chang_fz_name"] forKey:@"chang_fz_name"];
            [dic setValue:[set stringForColumn:@"chang_tel"] forKey:@"chang_tel"];
            [dic setValue:[set stringForColumn:@"chang_phone"] forKey:@"chang_phone"];
            [dic setValue:[set stringForColumn:@"operatorList"] forKey:@"operatorList"];
            [dic setValue:[set stringForColumn:@"scyxzt_id"] forKey:@"scyxzt_id"];
            [dic setValue:[set stringForColumn:@"scyxzt_name"] forKey:@"scyxzt_name"];
            [dic setValue:[set stringForColumn:@"zhengzhinianxian"] forKey:@"zhengzhinianxian"];
            [dic setValue:[set stringForColumn:@"shutdown_status"] forKey:@"shutdown_status"];
            [dic setValue:[set stringForColumn:@"shutdown_time"] forKey:@"shutdown_time"];
            [dic setValue:[set stringForColumn:@"plan_shutdown_time"] forKey:@"plan_shutdown_time"];
            [dic setValue:[set stringForColumn:@"xqzhongl_id"] forKey:@"xqzhongl_id"];
            [dic setValue:[set stringForColumn:@"xqzhongl_name"] forKey:@"xqzhongl_name"];
            [dic setValue:[set stringForColumn:@"zhuyaopz"] forKey:@"zhuyaopz"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_id"] forKey:@"yangzhimoshi_id"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_name"] forKey:@"yangzhimoshi_name"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc"] forKey:@"is_sfxqyzc"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc_name"] forKey:@"is_sfxqyzc_name"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_id"] forKey:@"sqjiancedian_id"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_name"] forKey:@"sqjiancedian_name"];
            [dic setValue:[set stringForColumn:@"yangzhifs_id"] forKey:@"yangzhifs_id"];
            [dic setValue:[set stringForColumn:@"yangzhifs_name"] forKey:@"yangzhifs_name"];
            [dic setValue:[set stringForColumn:@"quanshe_id"] forKey:@"quanshe_id"];
            [dic setValue:[set stringForColumn:@"quanshe_name"] forKey:@"quanshe_name"];
            [dic setValue:[set stringForColumn:@"sheji_cunlan_num"] forKey:@"sheji_cunlan_num"];
            [dic setValue:[set stringForColumn:@"sheji_nianchulan_num"] forKey:@"sheji_nianchulan_num"];
            [dic setValue:[set stringForColumn:@"sheji_muchu_num"] forKey:@"sheji_muchu_num"];
            [dic setValue:[set stringForColumn:@"now_all_chunlan_num"] forKey:@"now_all_chunlan_num"];
            [dic setValue:[set stringForColumn:@"shangpin_chunlan_num"] forKey:@"shangpin_chunlan_num"];
            [dic setValue:[set stringForColumn:@"muchu_cunlan_num"] forKey:@"muchu_cunlan_num"];
            [dic setValue:[set stringForColumn:@"gongchu_chunlan_num"] forKey:@"gongchu_chunlan_num"];
            [dic setValue:[set stringForColumn:@"yangzhi_yongdi_mianji"] forKey:@"yangzhi_yongdi_mianji"];
            [dic setValue:[set stringForColumn:@"zhongchu_jianzhu_mianji"] forKey:@"zhongchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shangchu_jianzhu_mianji"] forKey:@"shangchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shifouazzxjk"] forKey:@"shifouazzxjk"];
            [dic setValue:[set stringForColumn:@"shifouanzxjiance"] forKey:@"shifouanzxjiance"];
            [dic setValue:[set stringForColumn:@"is_fenwuzhipai"] forKey:@"is_fenwuzhipai"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_id"] forKey:@"fenbianchuliliyong_id"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_name"] forKey:@"fenbianchuliliyong_name"];
            [dic setValue:[set stringForColumn:@"qingffs_id"] forKey:@"qingffs_id"];
            [dic setValue:[set stringForColumn:@"qingffs_name"] forKey:@"qingffs_name"];
            [dic setValue:[set stringForColumn:@"shifouysfl"] forKey:@"shifouysfl"];
            [dic setValue:[set stringForColumn:@"is_guyefenli"] forKey:@"is_guyefenli"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_id"] forKey:@"ganshifenlisheshi_id"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_name"] forKey:@"ganshifenlisheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_id"] forKey:@"ganfen_fajiaosheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_name"] forKey:@"ganfen_fajiaosheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_wufangyu"] forKey:@"ganfen_fajiaosheshi_wufangyu"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_youfangyu"] forKey:@"ganfen_fajiaosheshi_youfangyu"];
            [dic setValue:[set stringForColumn:@"paiwuxkz"] forKey:@"paiwuxkz"];
            [dic setValue:[set stringForColumn:@"paiwuxkzbh"] forKey:@"paiwuxkzbh"];
            [dic setValue:[set stringForColumn:@"is_wushuichuli"] forKey:@"is_wushuichuli"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_id"] forKey:@"wushui_lyfs_id"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_name"] forKey:@"wushui_lyfs_name"];
            [dic setValue:[set stringForColumn:@"is_paifang"] forKey:@"is_paifang"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_id"] forKey:@"paifangbiaoz_id"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_name"] forKey:@"paifangbiaoz_name"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli"] forKey:@"is_zhaoqichuli"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli_zhengchang"] forKey:@"is_zhaoqichuli_zhengchang"];
            [dic setValue:[set stringForColumn:@"zhaojichi_fang"] forKey:@"zhaojichi_fang"];
            [dic setValue:[set stringForColumn:@"zqccjly_id"] forKey:@"zqccjly_id"];
            [dic setValue:[set stringForColumn:@"zqccjly_name"] forKey:@"zqccjly_name"];
            [dic setValue:[set stringForColumn:@"jizhonggq"] forKey:@"jizhonggq"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_id"] forKey:@"zhaoyhtcs_id"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_name"] forKey:@"zhaoyhtcs_name"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num1"] forKey:@"zhaoyhtcs_num1"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num2"] forKey:@"zhaoyhtcs_num2"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num3"] forKey:@"zhaoyhtcs_num3"];
            [dic setValue:[set stringForColumn:@"chang_chuye_ge"] forKey:@"chang_chuye_ge"];
            [dic setValue:[set stringForColumn:@"chang_chuye_fang"] forKey:@"chang_chuye_fang"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_ge"] forKey:@"tianjian_chuye_ge"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_fang"] forKey:@"tianjian_chuye_fang"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_id"] forKey:@"ganfen_chucunsheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_name"] forKey:@"ganfen_chucunsheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_fy_num"] forKey:@"ganfen_chucunsheshi_fy_num"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_wfy_num"] forKey:@"ganfen_chucunsheshi_wfy_num"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd"] forKey:@"peitaoxnnmyd"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd_name"] forKey:@"peitaoxnnmyd_name"];
            [dic setValue:[set stringForColumn:@"xiaonnydmj"] forKey:@"xiaonnydmj"];
            [dic setValue:[set stringForColumn:@"xiaonzzwglmj"] forKey:@"xiaonzzwglmj"];
            [dic setValue:[set stringForColumn:@"is_yjfsc"] forKey:@"is_yjfsc"];
            [dic setValue:[set stringForColumn:@"is_yjfsc_num"] forKey:@"is_yjfsc_num"];
            [dic setValue:[set stringForColumn:@"qt_fwclsbmcjsl"] forKey:@"qt_fwclsbmcjsl"];
            [dic setValue:[set stringForColumn:@"is_peitaossccclys"] forKey:@"is_peitaossccclys"];
            [dic setValue:[set stringForColumn:@"liyonglv"] forKey:@"liyonglv"];
            [dic setValue:[set stringForColumn:@"sc_youjifei_zhbl"] forKey:@"sc_youjifei_zhbl"];
            [dic setValue:[set stringForColumn:@"is_tousu"] forKey:@"is_tousu"];
            [dic setValue:[set stringForColumn:@"huanplb_id"] forKey:@"huanplb_id"];
            [dic setValue:[set stringForColumn:@"huanplb_name"] forKey:@"huanplb_name"];
            [dic setValue:[set stringForColumn:@"santsgl_id"] forKey:@"santsgl_id"];
            [dic setValue:[set stringForColumn:@"santsgl_name"] forKey:@"santsgl_name"];
            [dic setValue:[set stringForColumn:@"is_hbclss"] forKey:@"is_hbclss"];
            [dic setValue:[set stringForColumn:@"is_hbclss_name"] forKey:@"is_hbclss_name"];
            [dic setValue:[set stringForColumn:@"huanbaosheshi"] forKey:@"huanbaosheshi"];
            [dic setValue:[set stringForColumn:@"huanbaobutie"] forKey:@"huanbaobutie"];
            [dic setValue:[set stringForColumn:@"remark"] forKey:@"remark"];
            [dic setValue:[set stringForColumn:@"xj_username"] forKey:@"xj_username"];
            [dic setValue:[set stringForColumn:@"xj_time"] forKey:@"xj_time"];
            [dic setValue:[set stringForColumn:@"qianming"] forKey:@"qianming"];
            [dic setValue:[set stringForColumn:@"remark1"] forKey:@"remark1"];
            [dic setValue:[set stringForColumn:@"remark2"] forKey:@"remark2"];
            
            [dic setValue:[set stringForColumn:@"is_weiqiang"] forKey:@"is_weiqiang"];
            [dic setValue:[set stringForColumn:@"is_zhuanzhishouyi"] forKey:@"is_zhuanzhishouyi"];
            [dic setValue:[set stringForColumn:@"yanjiusheng_shouyi_num"] forKey:@"yanjiusheng_shouyi_num"];
            [dic setValue:[set stringForColumn:@"benke_shouyi_num"] forKey:@"benke_shouyi_num"];
            [dic setValue:[set stringForColumn:@"dazhuan_shouyi_num"] forKey:@"dazhuan_shouyi_num"];
            [dic setValue:[set stringForColumn:@"is_jianzhi"] forKey:@"is_jianzhi"];
            [dic setValue:[set stringForColumn:@"shouyi_num"] forKey:@"shouyi_num"];
            [dic setValue:[set stringForColumn:@"all_user_num"] forKey:@"all_user_num"];
            [dic setValue:[set stringForColumn:@"yongtu_name"] forKey:@"yongtu_name"];
            [dic setValue:[set stringForColumn:@"is_fenkai"] forKey:@"is_fenkai"];
            [dic setValue:[set stringForColumn:@"geli_mianji"] forKey:@"geli_mianji"];
            [dic setValue:[set stringForColumn:@"shenghuo_mianji"] forKey:@"shenghuo_mianji"];
            [dic setValue:[set stringForColumn:@"xingzheng_mianji"] forKey:@"xingzheng_mianji"];
            [dic setValue:[set stringForColumn:@"is_gaoyugandao"] forKey:@"is_gaoyugandao"];
            [dic setValue:[set stringForColumn:@"is_tuzaichang"] forKey:@"is_tuzaichang"];
            [dic setValue:[set stringForColumn:@"is_jingruchangqu"] forKey:@"is_jingruchangqu"];
            [dic setValue:[set stringForColumn:@"is_chongxi"] forKey:@"is_chongxi"];
            [dic setValue:[set stringForColumn:@"is_sheshi"] forKey:@"is_sheshi"];
            [dic setValue:[set stringForColumn:@"is_zhongzhuan"] forKey:@"is_zhongzhuan"];
            [dic setValue:[set stringForColumn:@"is_quyu"] forKey:@"is_quyu"];
            [dic setValue:[set stringForColumn:@"is_xiaodusheshi"] forKey:@"is_xiaodusheshi"];
            [dic setValue:[set stringForColumn:@"is_wuhaihua"] forKey:@"is_wuhaihua"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi"] forKey:@"chuli_fangshi"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi_name"] forKey:@"chuli_fangshi_name"];
            [dic setValue:[set stringForColumn:@"is_tongdao"] forKey:@"is_tongdao"];
            [dic setValue:[set stringForColumn:@"is_meishusheshi"] forKey:@"is_meishusheshi"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov"] forKey:@"diaochudi_sprov"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov_name"] forKey:@"diaochudi_sprov_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity"] forKey:@"diaochudi_scity"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity_name"] forKey:@"diaochudi_scity_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_id"] forKey:@"diaochudi_qu_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_name"] forKey:@"diaochudi_qu_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_id"] forKey:@"diaochudi_zhen_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_name"] forKey:@"diaochudi_zhen_name"];
            
        }
    }];
    return dic;
}

- (void)updateYcYdSubmitStateWithFormID:(NSString *)formID state:(NSString *)state {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"UPDATE ycyd_info0515 SET state = ? WHERE form_id = ?", state, formID];
    }];
}

- (void)deleteYcYdInfoWithFormID:(NSString *)formID {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM ycyd_info0515 WHERE form_id = ?", formID];
    }];
}

- (BOOL)checkYcYdDraftExistWithUserID:(NSString *)userID formID:(NSString *)formID {
    __block BOOL exist = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE user_id = ? AND form_id = ? AND state = 1000", userID, formID];
        while ([set next]) {
            exist = YES;
        }
    }];
    return exist;
}

- (NSMutableArray *)searchYcYdDraftListWithUserID:(NSString *)userID {
    __block NSMutableArray *draftList = @[].mutableCopy;
    [_queue inDatabase:^(FMDatabase *db) {
//        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE user_id = ? AND (state = 1000 OR state = 2 OR state = 1 OR state = 0)", userID];
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE user_id = ? AND state = 1000", userID];
        while ([set next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[set stringForColumn:@"form_id"] forKey:@"farmcheck_id"];
            [dic setValue:[set stringForColumn:@"state"] forKey:@"state"];
            [dic setValue:[set stringForColumn:@"user_id"] forKey:@"user_id"];
            [dic setValue:[set stringForColumn:@"plat_code"] forKey:@"plat_code"];
            [dic setValue:[set stringForColumn:@"chang_name"] forKey:@"chang_name"];
            [dic setValue:[set stringForColumn:@"jianchang_time"] forKey:@"jianchang_time"];
            [dic setValue:[set stringForColumn:@"sprov"] forKey:@"sprov"];
            [dic setValue:[set stringForColumn:@"sprov_name"] forKey:@"sprov_name"];
            [dic setValue:[set stringForColumn:@"scity"] forKey:@"scity"];
            [dic setValue:[set stringForColumn:@"scity_name"] forKey:@"scity_name"];
            [dic setValue:[set stringForColumn:@"qu_id"] forKey:@"qu_id"];
            [dic setValue:[set stringForColumn:@"qu_name"] forKey:@"qu_name"];
            [dic setValue:[set stringForColumn:@"zhen_id"] forKey:@"zhen_id"];
            [dic setValue:[set stringForColumn:@"zhen_name"] forKey:@"zhen_name"];
            [dic setValue:[set stringForColumn:@"cun_id"] forKey:@"cun_id"];
            [dic setValue:[set stringForColumn:@"cun_name"] forKey:@"cun_name"];
            [dic setValue:[set stringForColumn:@"she_id"] forKey:@"she_id"];
            [dic setValue:[set stringForColumn:@"she_name"] forKey:@"she_name"];
            [dic setValue:[set stringForColumn:@"longitude"] forKey:@"longitude"];
            [dic setValue:[set stringForColumn:@"latitude"] forKey:@"latitude"];
            [dic setValue:[set stringForColumn:@"position_name"] forKey:@"position_name"];
            [dic setValue:[set stringForColumn:@"huanbao_beian"] forKey:@"huanbao_beian"];
            [dic setValue:[set stringForColumn:@"huanbao_beianbh"] forKey:@"huanbao_beianbh"];
            [dic setValue:[set stringForColumn:@"yangzhi_beian"] forKey:@"yangzhi_beian"];
            [dic setValue:[set stringForColumn:@"yangzhi_beianbh"] forKey:@"yangzhi_beianbh"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgz"] forKey:@"dongwu_fyhgz"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgzbh"] forKey:@"dongwu_fyhgzbh"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkz"] forKey:@"zhongchu_jyxkz"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkzbh"] forKey:@"zhongchu_jyxkzbh"];
            [dic setValue:[set stringForColumn:@"shehui_xydm"] forKey:@"shehui_xydm"];
            [dic setValue:[set stringForColumn:@"shehui_xydmbh"] forKey:@"shehui_xydmbh"];
            [dic setValue:[set stringForColumn:@"is_quanjing_picture"] forKey:@"is_quanjing_picture"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_id"] forKey:@"yangzhi_quyu_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_name"] forKey:@"yangzhi_quyu_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_id"] forKey:@"yangzhi_ydsp_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_name"] forKey:@"yangzhi_ydsp_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_id"] forKey:@"yangzhi_ydqs_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_name"] forKey:@"yangzhi_ydqs_name"];
            [dic setValue:[set stringForColumn:@"chang_fz_idcard"] forKey:@"chang_fz_idcard"];
            [dic setValue:[set stringForColumn:@"chang_fz_name"] forKey:@"chang_fz_name"];
            [dic setValue:[set stringForColumn:@"chang_tel"] forKey:@"chang_tel"];
            [dic setValue:[set stringForColumn:@"chang_phone"] forKey:@"chang_phone"];
            [dic setValue:[set stringForColumn:@"operatorList"] forKey:@"operatorList"];
            [dic setValue:[set stringForColumn:@"scyxzt_id"] forKey:@"scyxzt_id"];
            [dic setValue:[set stringForColumn:@"scyxzt_name"] forKey:@"scyxzt_name"];
            [dic setValue:[set stringForColumn:@"zhengzhinianxian"] forKey:@"zhengzhinianxian"];
            [dic setValue:[set stringForColumn:@"shutdown_status"] forKey:@"shutdown_status"];
            [dic setValue:[set stringForColumn:@"shutdown_time"] forKey:@"shutdown_time"];
            [dic setValue:[set stringForColumn:@"plan_shutdown_time"] forKey:@"plan_shutdown_time"];
            [dic setValue:[set stringForColumn:@"xqzhongl_id"] forKey:@"xqzhongl_id"];
            [dic setValue:[set stringForColumn:@"xqzhongl_name"] forKey:@"xqzhongl_name"];
            [dic setValue:[set stringForColumn:@"zhuyaopz"] forKey:@"zhuyaopz"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_id"] forKey:@"yangzhimoshi_id"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_name"] forKey:@"yangzhimoshi_name"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc"] forKey:@"is_sfxqyzc"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc_name"] forKey:@"is_sfxqyzc_name"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_id"] forKey:@"sqjiancedian_id"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_name"] forKey:@"sqjiancedian_name"];
            [dic setValue:[set stringForColumn:@"yangzhifs_id"] forKey:@"yangzhifs_id"];
            [dic setValue:[set stringForColumn:@"yangzhifs_name"] forKey:@"yangzhifs_name"];
            [dic setValue:[set stringForColumn:@"quanshe_id"] forKey:@"quanshe_id"];
            [dic setValue:[set stringForColumn:@"quanshe_name"] forKey:@"quanshe_name"];
            [dic setValue:[set stringForColumn:@"sheji_cunlan_num"] forKey:@"sheji_cunlan_num"];
            [dic setValue:[set stringForColumn:@"sheji_nianchulan_num"] forKey:@"sheji_nianchulan_num"];
            [dic setValue:[set stringForColumn:@"sheji_muchu_num"] forKey:@"sheji_muchu_num"];
            [dic setValue:[set stringForColumn:@"now_all_chunlan_num"] forKey:@"now_all_chunlan_num"];
            [dic setValue:[set stringForColumn:@"shangpin_chunlan_num"] forKey:@"shangpin_chunlan_num"];
            [dic setValue:[set stringForColumn:@"muchu_cunlan_num"] forKey:@"muchu_cunlan_num"];
            [dic setValue:[set stringForColumn:@"gongchu_chunlan_num"] forKey:@"gongchu_chunlan_num"];
            [dic setValue:[set stringForColumn:@"yangzhi_yongdi_mianji"] forKey:@"yangzhi_yongdi_mianji"];
            [dic setValue:[set stringForColumn:@"zhongchu_jianzhu_mianji"] forKey:@"zhongchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shangchu_jianzhu_mianji"] forKey:@"shangchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shifouazzxjk"] forKey:@"shifouazzxjk"];
            [dic setValue:[set stringForColumn:@"shifouanzxjiance"] forKey:@"shifouanzxjiance"];
            [dic setValue:[set stringForColumn:@"is_fenwuzhipai"] forKey:@"is_fenwuzhipai"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_id"] forKey:@"fenbianchuliliyong_id"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_name"] forKey:@"fenbianchuliliyong_name"];
            [dic setValue:[set stringForColumn:@"qingffs_id"] forKey:@"qingffs_id"];
            [dic setValue:[set stringForColumn:@"qingffs_name"] forKey:@"qingffs_name"];
            [dic setValue:[set stringForColumn:@"shifouysfl"] forKey:@"shifouysfl"];
            [dic setValue:[set stringForColumn:@"is_guyefenli"] forKey:@"is_guyefenli"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_id"] forKey:@"ganshifenlisheshi_id"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_name"] forKey:@"ganshifenlisheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_id"] forKey:@"ganfen_fajiaosheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_name"] forKey:@"ganfen_fajiaosheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_wufangyu"] forKey:@"ganfen_fajiaosheshi_wufangyu"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_youfangyu"] forKey:@"ganfen_fajiaosheshi_youfangyu"];
            [dic setValue:[set stringForColumn:@"paiwuxkz"] forKey:@"paiwuxkz"];
            [dic setValue:[set stringForColumn:@"paiwuxkzbh"] forKey:@"paiwuxkzbh"];
            [dic setValue:[set stringForColumn:@"is_wushuichuli"] forKey:@"is_wushuichuli"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_id"] forKey:@"wushui_lyfs_id"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_name"] forKey:@"wushui_lyfs_name"];
            [dic setValue:[set stringForColumn:@"is_paifang"] forKey:@"is_paifang"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_id"] forKey:@"paifangbiaoz_id"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_name"] forKey:@"paifangbiaoz_name"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli"] forKey:@"is_zhaoqichuli"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli_zhengchang"] forKey:@"is_zhaoqichuli_zhengchang"];
            [dic setValue:[set stringForColumn:@"zhaojichi_fang"] forKey:@"zhaojichi_fang"];
            [dic setValue:[set stringForColumn:@"zqccjly_id"] forKey:@"zqccjly_id"];
            [dic setValue:[set stringForColumn:@"zqccjly_name"] forKey:@"zqccjly_name"];
            [dic setValue:[set stringForColumn:@"jizhonggq"] forKey:@"jizhonggq"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_id"] forKey:@"zhaoyhtcs_id"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_name"] forKey:@"zhaoyhtcs_name"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num1"] forKey:@"zhaoyhtcs_num1"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num2"] forKey:@"zhaoyhtcs_num2"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num3"] forKey:@"zhaoyhtcs_num3"];
            [dic setValue:[set stringForColumn:@"chang_chuye_ge"] forKey:@"chang_chuye_ge"];
            [dic setValue:[set stringForColumn:@"chang_chuye_fang"] forKey:@"chang_chuye_fang"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_ge"] forKey:@"tianjian_chuye_ge"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_fang"] forKey:@"tianjian_chuye_fang"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_id"] forKey:@"ganfen_chucunsheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_name"] forKey:@"ganfen_chucunsheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_fy_num"] forKey:@"ganfen_chucunsheshi_fy_num"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_wfy_num"] forKey:@"ganfen_chucunsheshi_wfy_num"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd"] forKey:@"peitaoxnnmyd"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd_name"] forKey:@"peitaoxnnmyd_name"];
            [dic setValue:[set stringForColumn:@"xiaonnydmj"] forKey:@"xiaonnydmj"];
            [dic setValue:[set stringForColumn:@"xiaonzzwglmj"] forKey:@"xiaonzzwglmj"];
            [dic setValue:[set stringForColumn:@"is_yjfsc"] forKey:@"is_yjfsc"];
            [dic setValue:[set stringForColumn:@"is_yjfsc_num"] forKey:@"is_yjfsc_num"];
            [dic setValue:[set stringForColumn:@"qt_fwclsbmcjsl"] forKey:@"qt_fwclsbmcjsl"];
            [dic setValue:[set stringForColumn:@"is_peitaossccclys"] forKey:@"is_peitaossccclys"];
            [dic setValue:[set stringForColumn:@"liyonglv"] forKey:@"liyonglv"];
            [dic setValue:[set stringForColumn:@"sc_youjifei_zhbl"] forKey:@"sc_youjifei_zhbl"];
            [dic setValue:[set stringForColumn:@"is_tousu"] forKey:@"is_tousu"];
            [dic setValue:[set stringForColumn:@"huanplb_id"] forKey:@"huanplb_id"];
            [dic setValue:[set stringForColumn:@"huanplb_name"] forKey:@"huanplb_name"];
            [dic setValue:[set stringForColumn:@"santsgl_id"] forKey:@"santsgl_id"];
            [dic setValue:[set stringForColumn:@"santsgl_name"] forKey:@"santsgl_name"];
            [dic setValue:[set stringForColumn:@"is_hbclss"] forKey:@"is_hbclss"];
            [dic setObject:[set stringForColumn:@"is_hbclss_name"] forKey:@"is_hbclss_name"];
            [dic setValue:[set stringForColumn:@"huanbaosheshi"] forKey:@"huanbaosheshi"];
            [dic setValue:[set stringForColumn:@"huanbaobutie"] forKey:@"huanbaobutie"];
            [dic setValue:[set stringForColumn:@"remark"] forKey:@"remark"];
            [dic setValue:[set stringForColumn:@"xj_username"] forKey:@"xj_username"];
            [dic setValue:[set stringForColumn:@"xj_time"] forKey:@"xj_time"];
            [dic setValue:[set stringForColumn:@"qianming"] forKey:@"qianming"];
            [dic setValue:[set stringForColumn:@"remark1"] forKey:@"remark1"];
            [dic setValue:[set stringForColumn:@"remark2"] forKey:@"remark2"];
            
            [dic setValue:[set stringForColumn:@"is_weiqiang"] forKey:@"is_weiqiang"];
            [dic setValue:[set stringForColumn:@"is_zhuanzhishouyi"] forKey:@"is_zhuanzhishouyi"];
            [dic setValue:[set stringForColumn:@"yanjiusheng_shouyi_num"] forKey:@"yanjiusheng_shouyi_num"];
            [dic setValue:[set stringForColumn:@"benke_shouyi_num"] forKey:@"benke_shouyi_num"];
            [dic setValue:[set stringForColumn:@"dazhuan_shouyi_num"] forKey:@"dazhuan_shouyi_num"];
            [dic setValue:[set stringForColumn:@"is_jianzhi"] forKey:@"is_jianzhi"];
            [dic setValue:[set stringForColumn:@"shouyi_num"] forKey:@"shouyi_num"];
            [dic setValue:[set stringForColumn:@"all_user_num"] forKey:@"all_user_num"];
            [dic setValue:[set stringForColumn:@"yongtu_name"] forKey:@"yongtu_name"];
            [dic setValue:[set stringForColumn:@"is_fenkai"] forKey:@"is_fenkai"];
            [dic setValue:[set stringForColumn:@"geli_mianji"] forKey:@"geli_mianji"];
            [dic setValue:[set stringForColumn:@"shenghuo_mianji"] forKey:@"shenghuo_mianji"];
            [dic setValue:[set stringForColumn:@"xingzheng_mianji"] forKey:@"xingzheng_mianji"];
            [dic setValue:[set stringForColumn:@"is_gaoyugandao"] forKey:@"is_gaoyugandao"];
            [dic setValue:[set stringForColumn:@"is_tuzaichang"] forKey:@"is_tuzaichang"];
            [dic setValue:[set stringForColumn:@"is_jingruchangqu"] forKey:@"is_jingruchangqu"];
            [dic setValue:[set stringForColumn:@"is_chongxi"] forKey:@"is_chongxi"];
            [dic setValue:[set stringForColumn:@"is_sheshi"] forKey:@"is_sheshi"];
            [dic setValue:[set stringForColumn:@"is_zhongzhuan"] forKey:@"is_zhongzhuan"];
            [dic setValue:[set stringForColumn:@"is_quyu"] forKey:@"is_quyu"];
            [dic setValue:[set stringForColumn:@"is_xiaodusheshi"] forKey:@"is_xiaodusheshi"];
            [dic setValue:[set stringForColumn:@"is_wuhaihua"] forKey:@"is_wuhaihua"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi"] forKey:@"chuli_fangshi"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi_name"] forKey:@"chuli_fangshi_name"];
            [dic setValue:[set stringForColumn:@"is_tongdao"] forKey:@"is_tongdao"];
            [dic setValue:[set stringForColumn:@"is_meishusheshi"] forKey:@"is_meishusheshi"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov"] forKey:@"diaochudi_sprov"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov_name"] forKey:@"diaochudi_sprov_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity"] forKey:@"diaochudi_scity"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity_name"] forKey:@"diaochudi_scity_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_id"] forKey:@"diaochudi_qu_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_name"] forKey:@"diaochudi_qu_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_id"] forKey:@"diaochudi_zhen_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_name"] forKey:@"diaochudi_zhen_name"];
            
            [draftList addObject:dic];
        }
    }];
    return draftList;
}
/**
 查询所有表单
 */
- (NSMutableArray *)searchYcYdAllListWithUserID:(NSString *)userID {
    __block NSMutableArray *draftList = @[].mutableCopy;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_info0515 WHERE user_id = ? ", userID];
        while ([set next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[set stringForColumn:@"form_id"] forKey:@"farmcheck_id"];
            [dic setValue:[set stringForColumn:@"state"] forKey:@"state"];
            [dic setValue:[set stringForColumn:@"user_id"] forKey:@"user_id"];
            [dic setValue:[set stringForColumn:@"plat_code"] forKey:@"plat_code"];
            [dic setValue:[set stringForColumn:@"chang_name"] forKey:@"chang_name"];
            [dic setValue:[set stringForColumn:@"jianchang_time"] forKey:@"jianchang_time"];
            [dic setValue:[set stringForColumn:@"sprov"] forKey:@"sprov"];
            [dic setValue:[set stringForColumn:@"sprov_name"] forKey:@"sprov_name"];
            [dic setValue:[set stringForColumn:@"scity"] forKey:@"scity"];
            [dic setValue:[set stringForColumn:@"scity_name"] forKey:@"scity_name"];
            [dic setValue:[set stringForColumn:@"qu_id"] forKey:@"qu_id"];
            [dic setValue:[set stringForColumn:@"qu_name"] forKey:@"qu_name"];
            [dic setValue:[set stringForColumn:@"zhen_id"] forKey:@"zhen_id"];
            [dic setValue:[set stringForColumn:@"zhen_name"] forKey:@"zhen_name"];
            [dic setValue:[set stringForColumn:@"cun_id"] forKey:@"cun_id"];
            [dic setValue:[set stringForColumn:@"cun_name"] forKey:@"cun_name"];
            [dic setValue:[set stringForColumn:@"she_id"] forKey:@"she_id"];
            [dic setValue:[set stringForColumn:@"she_name"] forKey:@"she_name"];
            [dic setValue:[set stringForColumn:@"longitude"] forKey:@"longitude"];
            [dic setValue:[set stringForColumn:@"latitude"] forKey:@"latitude"];
            [dic setValue:[set stringForColumn:@"position_name"] forKey:@"position_name"];
            [dic setValue:[set stringForColumn:@"huanbao_beian"] forKey:@"huanbao_beian"];
            [dic setValue:[set stringForColumn:@"huanbao_beianbh"] forKey:@"huanbao_beianbh"];
            [dic setValue:[set stringForColumn:@"yangzhi_beian"] forKey:@"yangzhi_beian"];
            [dic setValue:[set stringForColumn:@"yangzhi_beianbh"] forKey:@"yangzhi_beianbh"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgz"] forKey:@"dongwu_fyhgz"];
            [dic setValue:[set stringForColumn:@"dongwu_fyhgzbh"] forKey:@"dongwu_fyhgzbh"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkz"] forKey:@"zhongchu_jyxkz"];
            [dic setValue:[set stringForColumn:@"zhongchu_jyxkzbh"] forKey:@"zhongchu_jyxkzbh"];
            [dic setValue:[set stringForColumn:@"shehui_xydm"] forKey:@"shehui_xydm"];
            [dic setValue:[set stringForColumn:@"shehui_xydmbh"] forKey:@"shehui_xydmbh"];
            [dic setValue:[set stringForColumn:@"is_quanjing_picture"] forKey:@"is_quanjing_picture"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_id"] forKey:@"yangzhi_quyu_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_quyu_name"] forKey:@"yangzhi_quyu_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_id"] forKey:@"yangzhi_ydsp_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydsp_name"] forKey:@"yangzhi_ydsp_name"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_id"] forKey:@"yangzhi_ydqs_id"];
            [dic setValue:[set stringForColumn:@"yangzhi_ydqs_name"] forKey:@"yangzhi_ydqs_name"];
            [dic setValue:[set stringForColumn:@"chang_fz_idcard"] forKey:@"chang_fz_idcard"];
            [dic setValue:[set stringForColumn:@"chang_fz_name"] forKey:@"chang_fz_name"];
            [dic setValue:[set stringForColumn:@"chang_tel"] forKey:@"chang_tel"];
            [dic setValue:[set stringForColumn:@"chang_phone"] forKey:@"chang_phone"];
            [dic setValue:[set stringForColumn:@"operatorList"] forKey:@"operatorList"];
            [dic setValue:[set stringForColumn:@"scyxzt_id"] forKey:@"scyxzt_id"];
            [dic setValue:[set stringForColumn:@"scyxzt_name"] forKey:@"scyxzt_name"];
            [dic setValue:[set stringForColumn:@"zhengzhinianxian"] forKey:@"zhengzhinianxian"];
            [dic setValue:[set stringForColumn:@"shutdown_status"] forKey:@"shutdown_status"];
            [dic setValue:[set stringForColumn:@"shutdown_time"] forKey:@"shutdown_time"];
            [dic setValue:[set stringForColumn:@"plan_shutdown_time"] forKey:@"plan_shutdown_time"];
            [dic setValue:[set stringForColumn:@"xqzhongl_id"] forKey:@"xqzhongl_id"];
            [dic setValue:[set stringForColumn:@"xqzhongl_name"] forKey:@"xqzhongl_name"];
            [dic setValue:[set stringForColumn:@"zhuyaopz"] forKey:@"zhuyaopz"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_id"] forKey:@"yangzhimoshi_id"];
            [dic setValue:[set stringForColumn:@"yangzhimoshi_name"] forKey:@"yangzhimoshi_name"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc"] forKey:@"is_sfxqyzc"];
            [dic setValue:[set stringForColumn:@"is_sfxqyzc_name"] forKey:@"is_sfxqyzc_name"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_id"] forKey:@"sqjiancedian_id"];
            [dic setValue:[set stringForColumn:@"sqjiancedian_name"] forKey:@"sqjiancedian_name"];
            [dic setValue:[set stringForColumn:@"yangzhifs_id"] forKey:@"yangzhifs_id"];
            [dic setValue:[set stringForColumn:@"yangzhifs_name"] forKey:@"yangzhifs_name"];
            [dic setValue:[set stringForColumn:@"quanshe_id"] forKey:@"quanshe_id"];
            [dic setValue:[set stringForColumn:@"quanshe_name"] forKey:@"quanshe_name"];
            [dic setValue:[set stringForColumn:@"sheji_cunlan_num"] forKey:@"sheji_cunlan_num"];
            [dic setValue:[set stringForColumn:@"sheji_nianchulan_num"] forKey:@"sheji_nianchulan_num"];
            [dic setValue:[set stringForColumn:@"sheji_muchu_num"] forKey:@"sheji_muchu_num"];
            [dic setValue:[set stringForColumn:@"now_all_chunlan_num"] forKey:@"now_all_chunlan_num"];
            [dic setValue:[set stringForColumn:@"shangpin_chunlan_num"] forKey:@"shangpin_chunlan_num"];
            [dic setValue:[set stringForColumn:@"muchu_cunlan_num"] forKey:@"muchu_cunlan_num"];
            [dic setValue:[set stringForColumn:@"gongchu_chunlan_num"] forKey:@"gongchu_chunlan_num"];
            [dic setValue:[set stringForColumn:@"yangzhi_yongdi_mianji"] forKey:@"yangzhi_yongdi_mianji"];
            [dic setValue:[set stringForColumn:@"zhongchu_jianzhu_mianji"] forKey:@"zhongchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shangchu_jianzhu_mianji"] forKey:@"shangchu_jianzhu_mianji"];
            [dic setValue:[set stringForColumn:@"shifouazzxjk"] forKey:@"shifouazzxjk"];
            [dic setValue:[set stringForColumn:@"shifouanzxjiance"] forKey:@"shifouanzxjiance"];
            [dic setValue:[set stringForColumn:@"is_fenwuzhipai"] forKey:@"is_fenwuzhipai"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_id"] forKey:@"fenbianchuliliyong_id"];
            [dic setValue:[set stringForColumn:@"fenbianchuliliyong_name"] forKey:@"fenbianchuliliyong_name"];
            [dic setValue:[set stringForColumn:@"qingffs_id"] forKey:@"qingffs_id"];
            [dic setValue:[set stringForColumn:@"qingffs_name"] forKey:@"qingffs_name"];
            [dic setValue:[set stringForColumn:@"shifouysfl"] forKey:@"shifouysfl"];
            [dic setValue:[set stringForColumn:@"is_guyefenli"] forKey:@"is_guyefenli"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_id"] forKey:@"ganshifenlisheshi_id"];
            [dic setValue:[set stringForColumn:@"ganshifenlisheshi_name"] forKey:@"ganshifenlisheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_id"] forKey:@"ganfen_fajiaosheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_name"] forKey:@"ganfen_fajiaosheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_wufangyu"] forKey:@"ganfen_fajiaosheshi_wufangyu"];
            [dic setValue:[set stringForColumn:@"ganfen_fajiaosheshi_youfangyu"] forKey:@"ganfen_fajiaosheshi_youfangyu"];
            [dic setValue:[set stringForColumn:@"paiwuxkz"] forKey:@"paiwuxkz"];
            [dic setValue:[set stringForColumn:@"paiwuxkzbh"] forKey:@"paiwuxkzbh"];
            [dic setValue:[set stringForColumn:@"is_wushuichuli"] forKey:@"is_wushuichuli"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_id"] forKey:@"wushui_lyfs_id"];
            [dic setValue:[set stringForColumn:@"wushui_lyfs_name"] forKey:@"wushui_lyfs_name"];
            [dic setValue:[set stringForColumn:@"is_paifang"] forKey:@"is_paifang"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_id"] forKey:@"paifangbiaoz_id"];
            [dic setValue:[set stringForColumn:@"paifangbiaoz_name"] forKey:@"paifangbiaoz_name"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli"] forKey:@"is_zhaoqichuli"];
            [dic setValue:[set stringForColumn:@"is_zhaoqichuli_zhengchang"] forKey:@"is_zhaoqichuli_zhengchang"];
            [dic setValue:[set stringForColumn:@"zhaojichi_fang"] forKey:@"zhaojichi_fang"];
            [dic setValue:[set stringForColumn:@"zqccjly_id"] forKey:@"zqccjly_id"];
            [dic setValue:[set stringForColumn:@"zqccjly_name"] forKey:@"zqccjly_name"];
            [dic setValue:[set stringForColumn:@"jizhonggq"] forKey:@"jizhonggq"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_id"] forKey:@"zhaoyhtcs_id"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_name"] forKey:@"zhaoyhtcs_name"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num1"] forKey:@"zhaoyhtcs_num1"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num2"] forKey:@"zhaoyhtcs_num2"];
            [dic setValue:[set stringForColumn:@"zhaoyhtcs_num3"] forKey:@"zhaoyhtcs_num3"];
            [dic setValue:[set stringForColumn:@"chang_chuye_ge"] forKey:@"chang_chuye_ge"];
            [dic setValue:[set stringForColumn:@"chang_chuye_fang"] forKey:@"chang_chuye_fang"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_ge"] forKey:@"tianjian_chuye_ge"];
            [dic setValue:[set stringForColumn:@"tianjian_chuye_fang"] forKey:@"tianjian_chuye_fang"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_id"] forKey:@"ganfen_chucunsheshi_id"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_name"] forKey:@"ganfen_chucunsheshi_name"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_fy_num"] forKey:@"ganfen_chucunsheshi_fy_num"];
            [dic setValue:[set stringForColumn:@"ganfen_chucunsheshi_wfy_num"] forKey:@"ganfen_chucunsheshi_wfy_num"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd"] forKey:@"peitaoxnnmyd"];
            [dic setValue:[set stringForColumn:@"peitaoxnnmyd_name"] forKey:@"peitaoxnnmyd_name"];
            [dic setValue:[set stringForColumn:@"xiaonnydmj"] forKey:@"xiaonnydmj"];
            [dic setValue:[set stringForColumn:@"xiaonzzwglmj"] forKey:@"xiaonzzwglmj"];
            [dic setValue:[set stringForColumn:@"is_yjfsc"] forKey:@"is_yjfsc"];
            [dic setValue:[set stringForColumn:@"is_yjfsc_num"] forKey:@"is_yjfsc_num"];
            [dic setValue:[set stringForColumn:@"qt_fwclsbmcjsl"] forKey:@"qt_fwclsbmcjsl"];
            [dic setValue:[set stringForColumn:@"is_peitaossccclys"] forKey:@"is_peitaossccclys"];
            [dic setValue:[set stringForColumn:@"liyonglv"] forKey:@"liyonglv"];
            [dic setValue:[set stringForColumn:@"sc_youjifei_zhbl"] forKey:@"sc_youjifei_zhbl"];
            [dic setValue:[set stringForColumn:@"is_tousu"] forKey:@"is_tousu"];
            [dic setValue:[set stringForColumn:@"huanplb_id"] forKey:@"huanplb_id"];
            [dic setValue:[set stringForColumn:@"huanplb_name"] forKey:@"huanplb_name"];
            [dic setValue:[set stringForColumn:@"santsgl_id"] forKey:@"santsgl_id"];
            [dic setValue:[set stringForColumn:@"santsgl_name"] forKey:@"santsgl_name"];
            [dic setValue:[set stringForColumn:@"is_hbclss"] forKey:@"is_hbclss"];
            [dic setObject:[set stringForColumn:@"is_hbclss_name"] forKey:@"is_hbclss_name"];
            [dic setValue:[set stringForColumn:@"huanbaosheshi"] forKey:@"huanbaosheshi"];
            [dic setValue:[set stringForColumn:@"huanbaobutie"] forKey:@"huanbaobutie"];
            [dic setValue:[set stringForColumn:@"remark"] forKey:@"remark"];
            [dic setValue:[set stringForColumn:@"xj_username"] forKey:@"xj_username"];
            [dic setValue:[set stringForColumn:@"xj_time"] forKey:@"xj_time"];
            [dic setValue:[set stringForColumn:@"qianming"] forKey:@"qianming"];
            [dic setValue:[set stringForColumn:@"remark1"] forKey:@"remark1"];
            [dic setValue:[set stringForColumn:@"remark2"] forKey:@"remark2"];
            
            [dic setValue:[set stringForColumn:@"is_weiqiang"] forKey:@"is_weiqiang"];
            [dic setValue:[set stringForColumn:@"is_zhuanzhishouyi"] forKey:@"is_zhuanzhishouyi"];
            [dic setValue:[set stringForColumn:@"yanjiusheng_shouyi_num"] forKey:@"yanjiusheng_shouyi_num"];
            [dic setValue:[set stringForColumn:@"benke_shouyi_num"] forKey:@"benke_shouyi_num"];
            [dic setValue:[set stringForColumn:@"dazhuan_shouyi_num"] forKey:@"dazhuan_shouyi_num"];
            [dic setValue:[set stringForColumn:@"is_jianzhi"] forKey:@"is_jianzhi"];
            [dic setValue:[set stringForColumn:@"shouyi_num"] forKey:@"shouyi_num"];
            [dic setValue:[set stringForColumn:@"all_user_num"] forKey:@"all_user_num"];
            [dic setValue:[set stringForColumn:@"yongtu_name"] forKey:@"yongtu_name"];
            [dic setValue:[set stringForColumn:@"is_fenkai"] forKey:@"is_fenkai"];
            [dic setValue:[set stringForColumn:@"geli_mianji"] forKey:@"geli_mianji"];
            [dic setValue:[set stringForColumn:@"shenghuo_mianji"] forKey:@"shenghuo_mianji"];
            [dic setValue:[set stringForColumn:@"xingzheng_mianji"] forKey:@"xingzheng_mianji"];
            [dic setValue:[set stringForColumn:@"is_gaoyugandao"] forKey:@"is_gaoyugandao"];
            [dic setValue:[set stringForColumn:@"is_tuzaichang"] forKey:@"is_tuzaichang"];
            [dic setValue:[set stringForColumn:@"is_jingruchangqu"] forKey:@"is_jingruchangqu"];
            [dic setValue:[set stringForColumn:@"is_chongxi"] forKey:@"is_chongxi"];
            [dic setValue:[set stringForColumn:@"is_sheshi"] forKey:@"is_sheshi"];
            [dic setValue:[set stringForColumn:@"is_zhongzhuan"] forKey:@"is_zhongzhuan"];
            [dic setValue:[set stringForColumn:@"is_quyu"] forKey:@"is_quyu"];
            [dic setValue:[set stringForColumn:@"is_xiaodusheshi"] forKey:@"is_xiaodusheshi"];
            [dic setValue:[set stringForColumn:@"is_wuhaihua"] forKey:@"is_wuhaihua"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi"] forKey:@"chuli_fangshi"];
            [dic setValue:[set stringForColumn:@"chuli_fangshi_name"] forKey:@"chuli_fangshi_name"];
            [dic setValue:[set stringForColumn:@"is_tongdao"] forKey:@"is_tongdao"];
            [dic setValue:[set stringForColumn:@"is_meishusheshi"] forKey:@"is_meishusheshi"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov"] forKey:@"diaochudi_sprov"];
            [dic setValue:[set stringForColumn:@"diaochudi_sprov_name"] forKey:@"diaochudi_sprov_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity"] forKey:@"diaochudi_scity"];
            [dic setValue:[set stringForColumn:@"diaochudi_scity_name"] forKey:@"diaochudi_scity_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_id"] forKey:@"diaochudi_qu_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_qu_name"] forKey:@"diaochudi_qu_name"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_id"] forKey:@"diaochudi_zhen_id"];
            [dic setValue:[set stringForColumn:@"diaochudi_zhen_name"] forKey:@"diaochudi_zhen_name"];
            
            [draftList addObject:dic];
        }
    }];
    return draftList;
}

#pragma mark - File

- (void)addYcYdFileWithFormID:(NSString *)formID
                     file_url:(NSString *)file_url
                    file_name:(NSString *)file_name
                     pic_name:(NSString *)pic_name
                    file_type:(NSString *)file_type
                    file_code:(NSString *)file_code
                    file_data:(NSString *)file_data
                      remark1:(NSString *)remark1
                      remark2:(NSString *)remark2 {
    if ([self checkFileExistWithFormID:formID file_name:file_name]) {
        [_queue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:@"UPDATE ycyd_filelist SET file_url = ? WHERE form_id = ? AND file_name = ?", file_url, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET file_name = ? WHERE form_id = ? AND file_name = ?", file_name, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET pic_name = ? WHERE form_id = ? AND file_name = ?", pic_name, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET file_type = ? WHERE form_id = ? AND file_name = ?", file_type, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET file_code = ? WHERE form_id = ? AND file_name = ?", file_code, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET file_data = ? WHERE form_id = ? AND file_name = ?", file_data, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET remark1 = ? WHERE form_id = ? AND file_name = ?", remark1, formID, file_name];
            [db executeUpdate:@"UPDATE ycyd_filelist SET remark2 = ? WHERE form_id = ? AND file_name = ?", remark2, formID, file_name];
        }];
    }else {
        [_queue inDatabase:^(FMDatabase *db) {
            NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO ycyd_filelist(form_id, file_url, file_name, pic_name, file_type, file_code, file_data, remark1, remark2) VALUES(\'%@\', \'%@\', \'%@\', \'%@\', \'%@\', \'%@\', \'%@\', \'%@\', \'%@\')", formID, file_url, file_name, pic_name, file_type, file_code, file_data, remark1, remark2];
            BOOL success = [db executeUpdate:sqlStr];
            if (success) {
                NSLog(@"success");
            }else {
                NSLog(@"fail");
            }
        }];
    }
}

- (BOOL)checkFileExistWithFormID:(NSString *)formID file_name:(NSString *)file_name {
    __block BOOL exist = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_filelist WHERE form_id = ? AND file_name = ?", formID, file_name];
        while ([set next]) {
            exist = YES;
        }
    }];
    return exist;
}

- (NSMutableArray *)searchYcYdFileListWithFormID:(NSString *)formID {
    __block NSMutableArray *fileList = @[].mutableCopy;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"SELECT * FROM ycyd_filelist WHERE form_id = ?", formID];
        while ([set next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[set stringForColumn:@"form_id"] forKey:@"form_id"];
            [dic setValue:[set stringForColumn:@"file_url"] forKey:@"file_url"];
            [dic setValue:[set stringForColumn:@"file_name"] forKey:@"file_name"];
            [dic setValue:[set stringForColumn:@"pic_name"] forKey:@"pic_name"];
            [dic setValue:[set stringForColumn:@"file_type"] forKey:@"file_type"];
            [dic setValue:[set stringForColumn:@"file_code"] forKey:@"file_code"];
            [dic setValue:[set stringForColumn:@"file_data"] forKey:@"file_data"];
            [dic setValue:[set stringForColumn:@"remark1"] forKey:@"remark1"];
            [dic setValue:[set stringForColumn:@"remark2"] forKey:@"remark2"];
            [fileList addObject:dic];
        }
    }];
    return fileList;
}

- (void)deleteOtherImagesWithFormID:(NSString *)formID {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM ycyd_filelist WHERE form_id = ? AND file_type = 2", formID];
    }];
}

- (void)deleteJuanSheImagesWithFormID:(NSString *)formID {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM ycyd_filelist WHERE form_id = ? AND file_type = 0", formID];
    }];
}
/**
 删除粪污有无直排
 */
- (void)deleteFWYWZPImagesWithFormID:(NSString *)formID {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM ycyd_filelist WHERE form_id = ? AND file_type = 3", formID];
    }];
}

- (void)deleteYcYdFileListWithFormID:(NSString *)formID {
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"DELETE FROM ycyd_filelist WHERE form_id = ?", formID];
    }];
}

@end
