//
//  MAFAddressModel.h
//  NineFromObject
//
//  Created by joy 尹 on 2019/12/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAFAddressModel : NSObject

@property (nonatomic, copy) NSString *area_code; // 地区code
@property (nonatomic, copy) NSString *area_name; // 地区名称
@property (nonatomic, copy) NSString *area_parentcode; // 上级节点
@property (nonatomic, copy) NSString *isLeaf; // 是否叶子节点:0否;1是
@property (nonatomic, copy) NSString *leafs; // 下级节点数MAF
@property (nonatomic, copy) NSString *level; // 地区级别：0中国；1省(直辖市)；2市；3区(县)；4乡镇；5村

@end

NS_ASSUME_NONNULL_END
