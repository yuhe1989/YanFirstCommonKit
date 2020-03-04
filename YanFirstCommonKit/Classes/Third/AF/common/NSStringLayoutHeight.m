//
//  NSStringLayoutHeight.m
//  MAF
//
//  Created by joy 尹 on 2019/11/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "NSStringLayoutHeight.h"

@implementation NSStringLayoutHeight

+ (CGFloat)heightFromString:(NSString*)text withFont:(UIFont*)font constraintToWidth:(CGFloat)width
{
    if (text && font) {
        CGRect rect  = [text boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        
        return rect.size.height+24;//14 是lable居上下的距离
    }
    return 0;
}

//

@end
