//
//  UIImage+AN.h
//  ACE
//
//  Created by Eric on 15/6/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AN)

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/**
 *  通过颜色生成纯色图片
 */
+ (UIImage *)imageCreateFromColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  通过url获取图片
 */
+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (UIImage *)originImageWithName:(NSString *)name;

- (UIImage *)circleImage;


/**
 给图片添加文字水印

 @param image img
 @param text 文字
 @param point point
 @param attributed attributed
 @return image
 */
+ (UIImage *)pp_WaterImageWithImage:(UIImage *)image text:(NSString *)text textRect:(CGRect)rect attributedString:(NSDictionary * )attributed;

@end
