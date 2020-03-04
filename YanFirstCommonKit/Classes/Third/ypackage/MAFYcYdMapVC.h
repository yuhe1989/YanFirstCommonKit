//
//  MAFYcYdMapVC.h
//  MAF
//
//  Created by wang k on 2017/8/17.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myBlock)(NSString *name, NSString *latitude, NSString *longitude);

@interface MAFYcYdMapVC : UIViewController

@property (nonatomic, copy) myBlock selectBlock;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) BOOL isNetWork;

@property (nonatomic, copy) NSString *farmcheck_id;

@end
