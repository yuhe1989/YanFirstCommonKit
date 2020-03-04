//
//  MAFYcYdYMDDatePicker.m
//  MAF
//
//  Created by 高赛 on 2018/3/23.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdYMDDatePicker.h"
#import "UIView+Uitls.h"
#import "UIColor+AN.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface MAFYcYdYMDDatePicker ()

@property (nonatomic, strong) UIView *blackBG;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIDatePicker *datePickerView;

@end

@implementation MAFYcYdYMDDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
}

- (UIDatePicker *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, self.width, _contentView.height - 40)];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _datePickerView;
}
- (void)setSubView {
    _blackBG = [[UIView alloc] initWithFrame:self.bounds];
    _blackBG.backgroundColor = RGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_blackBG addGestureRecognizer:tap];
    [self addSubview:_blackBG];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 250, self.width, 250)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 0, self.width / 2 - 12, 40)];
    cancleBtn.tag = 0;
    [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_contentView addSubview:cancleBtn];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 2, 0, self.width / 2 - 12, 40)];
    sureBtn.tag = 1;
    [sureBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_contentView addSubview:sureBtn];
    
    
    [self.contentView addSubview:self.datePickerView];
}

- (void)setType:(NSString *)type {
    _type = type;
    if ([self.type isEqualToString:@"max"]) {
        [self.datePickerView removeFromSuperview];
        self.datePickerView = nil;
        self.datePickerView.maximumDate = [NSDate date];
        [self.contentView addSubview:self.datePickerView];
    } else if ([self.type isEqualToString:@"min"]) {
        [self.datePickerView removeFromSuperview];
        self.datePickerView = nil;
        self.datePickerView.minimumDate = [NSDate date];
        [self.contentView addSubview:self.datePickerView];
    }
}

- (void)dismiss {
    if (self.delegate && [self.delegate respondsToSelector:@selector(hiddenYMDDatePicker)]) {
        [self.delegate hiddenYMDDatePicker];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            _blackBG.alpha = 0;
            _contentView.transform = CGAffineTransformMakeTranslation(0, _contentView.height);
        } completion:^(BOOL finished) {
            _contentView.transform = CGAffineTransformIdentity;
            [self removeFromSuperview];
        }];        
    }
}
- (void)btnAction {
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectYMDDateWithStr:withDatePicker:)]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateStr = [formatter stringFromDate:self.datePickerView.date];
        [self.delegate didSelectYMDDateWithStr:dateStr withDatePicker:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
