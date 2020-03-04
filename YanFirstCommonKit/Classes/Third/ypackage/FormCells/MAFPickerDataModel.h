//
//  MAFPickerDataModel.h
//  NineFromObject
//
//  Created by joy 尹 on 2019/12/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAFPickerDataModel : NSObject

@property (nonatomic, strong) NSString *dict_id;

@property (nonatomic, strong) NSString *dict_name;

@property (nonatomic, assign) BOOL is_select;

- (instancetype)initWithId:(NSString *)dict_id
                      name:(NSString *)dict_name;

@end

NS_ASSUME_NONNULL_END
