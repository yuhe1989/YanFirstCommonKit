//
//  MAFDataPickerView.m
//  NineFromObject
//
//  Created by joy 尹 on 2019/12/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "MAFDataPickerView.h"
#import "UIView+Uitls.h"
#import "UIColor+AN.h"

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface MAFDataPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *blackBG;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation MAFDataPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
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
    [cancleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_contentView addSubview:cancleBtn];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 2, 0, self.width / 2 - 12, 40)];
    sureBtn.tag = 1;
    [sureBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [_contentView addSubview:sureBtn];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.width, _contentView.height - 40)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [_contentView addSubview:_pickerView];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow != nil) {
        _blackBG.alpha = 0;
        _contentView.transform = CGAffineTransformMakeTranslation(0, _contentView.height);
        [UIView animateWithDuration:0.2f animations:^{
            _blackBG.alpha = 1;
            _contentView.transform = CGAffineTransformIdentity;
        }];
    }
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

#pragma mark - UIPickerViewDelegate && DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _dataArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    MAFPickerDataModel *model = _dataArr[row];
    return model.dict_name;
}

#pragma mark - Action

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 0) {
        [self dismiss];
    }else {
        [self dismiss];
        MAFPickerDataModel *model = [_dataArr objectAtIndex:[_pickerView selectedRowInComponent:0]];
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectModel:inView:indexPath:)]) {
            [_delegate didSelectModel:model inView:self indexPath:self.indexPath];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectModel:inView:)]) {
            [_delegate didSelectModel:model inView:self];
        }
    }
}

#pragma mark - Setter

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [_pickerView reloadAllComponents];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}


@end
