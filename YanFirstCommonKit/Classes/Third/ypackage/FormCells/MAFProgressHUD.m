//
//  MAFProgressHUD.m
//  MAF
//
//  Created by victor on 14-3-19.
//  Copyright (c) 2014年 ctnq. All rights reserved.
//

#import "MAFProgressHUD.h"
#import "MBProgressHUD.h"

@interface MAFProgressHUD ()

@property(nonatomic,retain)UIView *view;

+ (MAFProgressHUD *)shareMAFProgressHUD;

@end

static MAFProgressHUD *progressHUD;

@implementation MAFProgressHUD

+ (MAFProgressHUD *)shareMAFProgressHUD
{
    
    if (progressHUD == nil) {
        
        progressHUD = [[MAFProgressHUD alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        progressHUD.backgroundColor = [UIColor clearColor];
        
        progressHUD.view = [[UIView alloc] initWithFrame:progressHUD.frame];
        progressHUD.view.backgroundColor = [UIColor clearColor];
        [progressHUD addSubview:progressHUD.view];
    }
    return progressHUD;
}

+ (void)showHUDlabelMessage:(NSString*)message
{    
    MAFProgressHUD *progressHUD = [MAFProgressHUD shareMAFProgressHUD];
     dispatch_async(dispatch_get_main_queue(), ^{
        [progressHUD makeKeyAndVisible];
        progressHUD.hidden = NO;
        [MBProgressHUD showHUDAddedTo:progressHUD.view animated:YES labelMessage:message];
     });
}


+ (void)hide
{
    MAFProgressHUD *progressHUD = [MAFProgressHUD shareMAFProgressHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        
         [MBProgressHUD hideAllHUDsForView:progressHUD.view animated:YES];
        [progressHUD resignKeyWindow];
        progressHUD.hidden = YES;
    });
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

            }
    return self;
}

@end
