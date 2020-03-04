//
//  UIFont+Custom.h
//  Help
//
//  Created by 123 on 15-6-26.
//  Copyright (c) 2015年 小Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Custom)


/**
 *  设置字体样式以及大小
 */
+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;

/**
 通过网络链接，动态读取本地字体文件
 */
+ (UIFont *)fontWithTTFAtPath:(NSString *)path size:(CGFloat)size;
/**
 通过路径，动态读取本地字体文件
 */
+ (UIFont *)fontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size;


@end
