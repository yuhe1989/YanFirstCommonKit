//
//  MAFYcYdMulitiSelectVC.h
//  MAF
//
//  Created by 高赛 on 2018/3/27.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MultiSelectBlock)(NSArray *models, NSString *zhaoyhtcs_num1, NSString *zhaoyhtcs_num2, NSString *zhaoyhtcs_num3);

@interface MAFYcYdMulitiSelectVC : UIViewController

@property (nonatomic, copy) NSString *navTitle;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) MultiSelectBlock multiSelectBlock;

@property (nonatomic, strong) NSMutableArray *selectedModels;

@property (nonatomic, assign) BOOL isZhaoYe;

@property (nonatomic, assign) BOOL isWSLYFS;

@property (nonatomic, assign) BOOL isFBCLLYMS;

//粪水潜水泵
@property (nonatomic, copy) NSString *zhaoyhtcs_num1;
//硬管及田间沼液池
@property (nonatomic, copy) NSString *zhaoyhtcs_num2;
//沼液车
@property (nonatomic, copy) NSString *zhaoyhtcs_num3;

@end
