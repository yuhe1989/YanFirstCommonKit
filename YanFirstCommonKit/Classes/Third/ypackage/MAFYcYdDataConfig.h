//
//  MAFYcYdDataConfig.h
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFYcYdDataConfig : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getDataWithType:(NSString *)type;

@end
