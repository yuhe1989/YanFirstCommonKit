//
//  MAFYcYdYMDDatePicker.h
//  MAF
//
//  Created by 高赛 on 2018/3/23.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAFYcYdYMDDatePicker;
@protocol MAFYcYdYMDDatePickerDelegate <NSObject>

- (void)didSelectYMDDateWithStr:(NSString *)dateStr withDatePicker:(MAFYcYdYMDDatePicker *)datePicker;

- (void)hiddenYMDDatePicker;

@end

@interface MAFYcYdYMDDatePicker : UIView

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) id<MAFYcYdYMDDatePickerDelegate> delegate;


@end
