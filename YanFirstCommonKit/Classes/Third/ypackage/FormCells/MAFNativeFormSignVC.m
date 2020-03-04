//
//  MAFNativeFormSignVC.m
//  MAF
//
//  Created by wang k on 2017/9/20.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeFormSignVC.h"
#import "MAFNativeFormSignView.h"
#import "UIView+YYAdd.h"
#import "Masonry.h"
#import "UIImage+AN.h"

#define IMAGED(name) [UIImage imageNamed:name]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)    //屏幕高度

#define kStatusBarHeight (iOS11Later ? ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom>0 ? 44 : 20):[[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavBarHeight 44.0
#define kMainBottomHeight (@available(iOS 11.0, *)?([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom>0?83:49):([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49))
#define kMainTopHeight (kStatusBarHeight + kNavBarHeight)

@interface MAFNativeFormSignVC ()
@property (nonatomic, strong) MAFNativeFormSignView *signView;
@property (nonatomic, assign) NSInteger control;
@property (nonatomic, strong) UIBezierPath *beizerPath;
@end

@implementation MAFNativeFormSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItems];
    self.view.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    _signView = [[MAFNativeFormSignView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_HEIGHT - 80)];
    _signView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_signView];
    
    CGFloat btn_w = self.view.width / 6;
    UIButton *submitBtn = [[UIButton alloc] init];//WithFrame:CGRectMake(12, _signView.bottom + 15, btn_w, 40)];
    submitBtn.layer.cornerRadius = 2.0f;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [submitBtn setBackgroundColor:UIColorFromRGB(0x78af3c)];
    submitBtn.layer.cornerRadius = 3;
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(self.signView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    UIButton *cleanBtn = [[UIButton alloc] init];//WithFrame:CGRectMake(submitBtn.right + 20, submitBtn.top, btn_w, submitBtn.height)];
    cleanBtn.layer.cornerRadius = 2.0f;
    [cleanBtn setTitle:@"清除" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cleanBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [cleanBtn setBackgroundColor:UIColorFromRGB(0xec8d2e)];
    cleanBtn.layer.cornerRadius = 3;
    [cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.signView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

// 设置导航字体大小
#define NAVIGATION_FONT_SIZE 18

- (void)creatNavItems {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:IMAGED(@"MAF_NavBack") forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 25)];
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"手写签名";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:NAVIGATION_FONT_SIZE];
    self.navigationItem.titleView = titleLabel;
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

///设置导航颜色       --- 同样是全局色系
#define NAVIGATION_BACKGROUND_COLOR [UIColor colorWithRed:135.0/255.0 green:190.0/255.0 blue:26.0/255.0 alpha:1.0]

#pragma mark - Action

- (void)submitAction {
    
    UIImage *signImage = [_signView getSignatureImage];
    signImage = [signImage imageByScalingToSize:self.signView.frame.size];
    
    if (signImage) {
        if (_delegate && [_delegate respondsToSelector:@selector(didFinishSignWithImage:inViewController:)]) {
            
            [_delegate didFinishSignWithImage:signImage inViewController:self];
            [self dismiss];
        }
    }else{
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请绘制签名" preferredStyle:UIAlertControllerStyleAlert];;
        UIAlertAction * cacel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertView addAction:cacel];

        [cacel setValue:NAVIGATION_BACKGROUND_COLOR forKey:@"titleTextColor"];

        
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
    
}

- (void)cleanAction {
    [_signView clearSignature];
}

@end
