//
//  LayoutHeader.h
//  NineFromObject
//
//  Created by joy 尹 on 2019/12/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#ifndef LayoutHeader_h
#define LayoutHeader_h

#define KScreenHeight       [UIScreen mainScreen].bounds.size.height
#define KScreenWidth        [UIScreen mainScreen].bounds.size.width

#define kStatusBarHeight (iOS11Later ? ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom>0 ? 44 : 20):[[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavBarHeight 44.0
#define kMainBottomHeight (@available(iOS 11.0, *)?([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom>0?83:49):([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49))
#define kMainTopHeight (kStatusBarHeight + kNavBarHeight)
//屏幕高
#define HEIGHT   [UIScreen mainScreen].bounds.size.height
//导航栏的高
#define SafeAreaTopHeight (HEIGHT == 812.0 ? 88 : 64)
//tabbar高度
#define tabbarBottonHeight (HEIGHT == 812.0 ? 88 : 44)


#define iOS8Later         ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later         ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later       ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS10Later        ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later        ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)


#endif /* LayoutHeader_h */
