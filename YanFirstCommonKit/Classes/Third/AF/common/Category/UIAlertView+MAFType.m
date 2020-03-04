//
//  UIAlertView+MAFType.m
//  MAF
//
//  Created by 崔祥莉 on 2019/4/11.
//  Copyright © 2019年 ctnq. All rights reserved.
//

#import "UIAlertView+MAFType.h"
#import <objc/runtime.h>

static const void *classNameKey = &classNameKey;

@implementation UIAlertView (MAFType)

-(void)setType:(NSString *)type{
    objc_setAssociatedObject(self, classNameKey, type,  OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)type{
    return  objc_getAssociatedObject(self, classNameKey);
}

@end
