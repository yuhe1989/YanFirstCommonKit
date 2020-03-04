//
//  MAFProgressHUD.h
//  MAF
//
//  Created by victor on 14-3-19.
//  Copyright (c) 2014年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAFProgressHUD : UIWindow

+ (void)showHUDlabelMessage:(NSString*)message;
+ (void)hide;

@end
