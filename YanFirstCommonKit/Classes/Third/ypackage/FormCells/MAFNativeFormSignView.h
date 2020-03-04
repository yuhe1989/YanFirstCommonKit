//
//  MAFNativeFormSignView.h
//  MAF
//
//  Created by wang k on 2017/9/20.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAFNativeFormSignView : UIView
/**
 * 获取签名图片
 */
- (UIImage *)getSignatureImage;
/**
 * 清除签名
 */
- (void)clearSignature;

@end
