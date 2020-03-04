//
//  UIColor+HexStringColor.h
//  MAF
//
//  Created by 王涛 on 16/11/23.
//  Copyright © 2016年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexStringColor)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat )alpha;

@end
