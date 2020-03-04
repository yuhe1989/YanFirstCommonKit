//
//  MAFPickerDataModel.m
//  NineFromObject
//
//  Created by joy 尹 on 2019/12/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "MAFPickerDataModel.h"

@implementation MAFPickerDataModel


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
