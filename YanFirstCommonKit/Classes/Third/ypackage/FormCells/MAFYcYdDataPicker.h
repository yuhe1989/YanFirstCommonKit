//
//  MAFYcYdDataPicker.h
//  MAF
//
//  Created by wang k on 2018/3/5.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAFYcYdDataModel.h"

@class MAFYcYdDataPicker;
@protocol MAFYcYdDataPickerDelegate <NSObject>
@optional

- (void)didSelectModel:(MAFYcYdDataModel *)model inView:(MAFYcYdDataPicker *)picker;

- (void)didSelectString:(NSString *)string inView:(MAFYcYdDataPicker *)picker;

@end

@interface MAFYcYdDataPicker : UIView

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) id <MAFYcYdDataPickerDelegate>delegate;

@end
