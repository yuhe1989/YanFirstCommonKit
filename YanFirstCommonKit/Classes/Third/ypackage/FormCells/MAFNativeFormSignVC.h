//
//  MAFNativeFormSignVC.h
//  MAF
//
//  Created by wang k on 2017/9/20.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAFNativeFormSignVC;
@protocol NativeFormSignDelegate <NSObject>
@optional

- (void)didFinishSignWithImage:(UIImage *)image inViewController:(MAFNativeFormSignVC *)vc;

@end

@interface MAFNativeFormSignVC : UIViewController

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id <NativeFormSignDelegate>delegate;

@end
