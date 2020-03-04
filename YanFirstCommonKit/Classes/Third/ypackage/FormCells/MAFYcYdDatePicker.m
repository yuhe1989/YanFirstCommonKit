//
//  MAFYcYdDatePicker.m
//  MAF
//
//  Created by 高赛 on 2018/3/23.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdDatePicker.h"
#import "MAFExpDate.h"
#import "UIColor+AN.h"
#import "UIView+Uitls.h"

#define CURRENTTIME6_YEAR [MAFExpDate getYearDate]
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define CURRENTTIME7_MONTH [MAFExpDate getMonthDate]

@interface MAFYcYdDatePicker ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *blackBG;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *datePickerView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MAFYcYdDatePicker

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        NSMutableArray *yearArr = [NSMutableArray array];
        NSString *year = CURRENTTIME6_YEAR;
        for (int i = [year intValue]; i >= 1980; i--) {
            [yearArr addObject:[NSString stringWithFormat:@"%d", i]];
        }
        NSMutableArray *monthArr = [NSMutableArray array];
        for (int i = 1; i <= 12; i++) {
            [monthArr addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _dataArr = [NSMutableArray arrayWithObjects:yearArr, @[@"年"], monthArr, @[@"月"], nil];
    }
    return _dataArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
    }
    return self;
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
    
    _datePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.width, _contentView.height - 40)];
    _datePickerView.delegate = self;
    _datePickerView.dataSource = self;
    [_contentView addSubview:_datePickerView];
    NSString *year = CURRENTTIME7_MONTH;
    [_datePickerView selectRow:[year intValue]-1 inComponent:2 animated:NO];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArr.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSMutableArray *arr = self.dataArr[component];
    return arr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSMutableArray *arr = self.dataArr[component];
    return arr[row];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2f animations:^{
        _blackBG.alpha = 0;
        _contentView.transform = CGAffineTransformMakeTranslation(0, _contentView.height);
    } completion:^(BOOL finished) {
        _contentView.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
    }];
}
- (void)btnAction {
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectDateWithStr:withDatePicker:)]) {
        NSArray *yearArr = self.dataArr[0];
        NSString *year = yearArr[[self.datePickerView selectedRowInComponent:0]];
        NSArray *monthArr = self.dataArr[2];
        NSString *month = monthArr[[self.datePickerView selectedRowInComponent:2]];
        NSString *str = [NSString stringWithFormat:@"%@年%@月", year, month];
        [self.delegate didSelectDateWithStr:str withDatePicker:self];
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
