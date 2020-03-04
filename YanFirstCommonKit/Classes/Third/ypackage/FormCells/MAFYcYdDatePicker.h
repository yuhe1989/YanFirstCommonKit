//
//  MAFYcYdDatePicker.h
//  MAF
//
//  Created by 高赛 on 2018/3/23.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAFYcYdDatePicker;
@protocol MAFYcYdDatePickerDelegate <NSObject>

- (void)didSelectDateWithStr:(NSString *)dateStr withDatePicker:(MAFYcYdDatePicker *)datePicker;

@end

@interface MAFYcYdDatePicker : UIView

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) id<MAFYcYdDatePickerDelegate> delegate;


@end
