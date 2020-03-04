//
//  MAFYcYdDataModel.h
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MAFYcYdDataModel : NSObject

@property (nonatomic, strong) NSString *dict_id;

@property (nonatomic, strong) NSString *dict_name;

@property (nonatomic, assign) BOOL is_select;

- (instancetype)initWithId:(NSString *)dict_id
                      name:(NSString *)dict_name;

@end
