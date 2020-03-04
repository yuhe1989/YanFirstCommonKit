//
//  MAFYcYdDataModel.m
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdDataModel.h"

@implementation MAFYcYdDataModel

- (instancetype)initWithId:(NSString *)dict_id
                      name:(NSString *)dict_name {
    self = [super init];
    if (self) {
        _dict_id = dict_id;
        _dict_name = dict_name;
    }
    return self;
}

@end
