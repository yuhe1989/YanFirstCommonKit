//
//  NSStringLayoutHeight.h
//  MAF
//
//  Created by joy 尹 on 2019/11/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSStringLayoutHeight : NSObject

+ (CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
