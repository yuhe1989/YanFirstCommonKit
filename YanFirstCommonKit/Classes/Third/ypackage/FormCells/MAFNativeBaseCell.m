//
//  MAFNativeBaseCell.m
//  MAF
//
//  Created by 高赛 on 2017/9/4.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeBaseCell.h"
#import "UIView+YYAdd.h"
#import "Masonry/Masonry.h"
#import "UIColor+AN.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)      //屏幕宽度
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MAFNativeBaseCell

/**
 *  左边标题
 */
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24 - 170, 50)];
        _leftTitleLabel.font = [UIFont systemFontOfSize:17];
        _leftTitleLabel.numberOfLines = 2;
        _leftTitleLabel.adjustsFontSizeToFitWidth = YES;
        _leftTitleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTitleTap)];
        [_leftTitleLabel addGestureRecognizer:tap];
    }
    return _leftTitleLabel;
}



//左边标题1
- (UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:17];
        _titleLable.userInteractionEnabled = YES;
        _titleLable.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLable.numberOfLines = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTitleTap)];
        [_leftTitleLabel addGestureRecognizer:tap];
    }
    return _titleLable;
}

//右边文字
- (UILabel *)rightLable{
    if (!_rightLable) {
        _rightLable = [[UILabel alloc] init];
        _rightLable.font = [UIFont systemFontOfSize:17];
        _rightLable.userInteractionEnabled = YES;
        _rightLable.lineBreakMode = NSLineBreakByWordWrapping;
        _rightLable.textAlignment = NSTextAlignmentRight;
        _rightLable.numberOfLines = 0;
    }
    return _rightLable;
}


/**
 *  文字输入框
 */
- (UITextField *)textField {
    if (!_textField) {
        //        CGFloat x = CGRectGetMaxX(self.leftTitleLabel.frame);
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 100 - 24 - 5, 50)];
        _textField.font = [UIFont systemFontOfSize:17];
        _textField.placeholder = @"请填写";
        _textField.textColor = [UIColor colorWithHexString:@"#333333"];
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
        [_textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _textField;
}
/**
 *  数字输入框
 */
- (UITextField *)numberField {
    if (!_numberField) {
        _numberField = [[UITextField alloc] initWithFrame:CGRectMake(235 + 5 + 12, 0, SCREEN_WIDTH - 235 - 24 - 5, 50)];
        _numberField.font = [UIFont systemFontOfSize:17];
        _numberField.placeholder = @"0";
        _numberField.textColor = [UIColor colorWithHexString:@"#333333"];
        _numberField.textAlignment = NSTextAlignmentRight;
        _numberField.keyboardType = UIKeyboardTypeDecimalPad;
        [_numberField addTarget:self action:@selector(textFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _numberField;
}
/**
 *  选择按钮
 */
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        CGFloat x = CGRectGetMaxX(self.leftTitleLabel.frame);
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(140, 0, SCREEN_WIDTH - 140 - 24 - 5, 50);
        _selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.titleLabel.numberOfLines = 0;
    }
    return _selectBtn;
}
/**
 *  文本输入视图
 */
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(25, 50, SCREEN_WIDTH - 50, 80)];
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.textColor = [UIColor colorWithHexString:@"#333333"];
        _textView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        _textView.layer.borderWidth = 0.5f;
    }
    return _textView;
}
/**
 *  单选视图
 */
- (UIView *)singleView {
    if (!_singleView) {
        CGFloat width = 170;
        _singleView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - width - 12, 0, width, 50)];
        
        _yesImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(0, 16, 18, 18)];
        [_yesImg setImage:[UIImage imageNamed:@"FY_SelectCircle_Yes"]];
        
        _yesLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(_yesImg.right, 0, 50, 50)];
        _yesLabel.text = @"是";
        _yesLabel.font = [UIFont systemFontOfSize:16];
        _yesLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _yesLabel.textAlignment = NSTextAlignmentCenter;
        
        _yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _yesBtn.frame = CGRectMake(0, 0, _yesImg.width + _yesLabel.width, 50);
        [_yesBtn addTarget:self action:@selector(clickYesBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        _noImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(_yesBtn.right, 16, 18, 18)];
        [_noImg setImage:[UIImage imageNamed:@"FY_SelectCircle_No"]];
        
        _noLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(_noImg.right, 0, width - _noImg.right, 50)];
        _noLabel.text = @"否";
        _noLabel.font = [UIFont systemFontOfSize:16];
        _noLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noLabel.textAlignment = NSTextAlignmentCenter;
        
        _noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _noBtn.frame = CGRectMake(_noImg.left, 0, _noImg.width + _noLabel.width, 50);
        [_noBtn addTarget:self action:@selector(clickNoBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [_singleView addSubview:_noLabel];
        [_noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.singleView.mas_right).offset(-8);
            make.centerY.mas_equalTo(self.singleView.mas_centerY);
        }];
        
        [_singleView addSubview:_noImg];
        [_noImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.noLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.singleView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
       
        [_singleView addSubview:_noBtn];
        [_noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.noImg.mas_left);
            make.top.mas_equalTo(self.singleView.mas_top);
            make.bottom.mas_equalTo(self.singleView.mas_bottom);
            make.right.mas_equalTo(self.noLabel.mas_right);
        }];
        
        
        [_singleView addSubview:_yesLabel];
        [_yesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.noImg.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.singleView.mas_centerY);
        }];
        
        [_singleView addSubview:_yesImg];
        [_yesImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.yesLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.singleView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [_singleView addSubview:_yesBtn];
        [_yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.yesImg.mas_left);
            make.top.mas_equalTo(self.singleView.mas_top);
            make.bottom.mas_equalTo(self.singleView.mas_bottom);
            make.right.mas_equalTo(self.yesLabel.mas_right);
        }];
        
       
        
    }
    return _singleView;
}

/**
 *  单选视图
 */
- (UIView *)singleView1 {
    if (!_singleView1) {
        CGFloat width = 170;
        _singleView1 = [[UIView alloc] init];
        
        _yesImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(0, 16, 18, 18)];
        [_yesImg setImage:[UIImage imageNamed:@"FY_SelectCircle_Yes"]];
        
        _yesLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(_yesImg.right, 0, 50, 50)];
        _yesLabel.text = @"是";
        _yesLabel.font = [UIFont systemFontOfSize:16];
        _yesLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _yesLabel.textAlignment = NSTextAlignmentCenter;
        
        _yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _yesBtn.frame = CGRectMake(0, 0, _yesImg.width + _yesLabel.width, 50);
        [_yesBtn addTarget:self action:@selector(clickYesBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        _noImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(_yesBtn.right, 16, 18, 18)];
        [_noImg setImage:[UIImage imageNamed:@"FY_SelectCircle_No"]];
        
        _noLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(_noImg.right, 0, width - _noImg.right, 50)];
        _noLabel.text = @"否";
        _noLabel.font = [UIFont systemFontOfSize:16];
        _noLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noLabel.textAlignment = NSTextAlignmentCenter;
        
        _noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _noBtn.frame = CGRectMake(_noImg.left, 0, _noImg.width + _noLabel.width, 50);
        [_noBtn addTarget:self action:@selector(clickNoBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [_singleView1 addSubview:_noLabel];
        [_noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.singleView1.mas_right).offset(-8);
            make.centerY.mas_equalTo(self.singleView1.mas_centerY);
        }];
        
        [_singleView1 addSubview:_noImg];
        [_noImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.noLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.singleView1.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [_singleView1 addSubview:_noBtn];
        [_noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.noImg.mas_left);
            make.top.mas_equalTo(self.singleView1.mas_top);
            make.bottom.mas_equalTo(self.singleView1.mas_bottom);
            make.right.mas_equalTo(self.noLabel.mas_right);
        }];
        
        
        [_singleView1 addSubview:_yesLabel];
        [_yesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.noImg.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.singleView1.mas_centerY);
        }];
        
        [_singleView1 addSubview:_yesImg];
        [_yesImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.yesLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(self.singleView1.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(18, 18));
        }];
        
        [_singleView1 addSubview:_yesBtn];
        [_yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.yesImg.mas_left);
            make.top.mas_equalTo(self.singleView1.mas_top);
            make.bottom.mas_equalTo(self.singleView1.mas_bottom);
            make.right.mas_equalTo(self.yesLabel.mas_right);
        }];
        
        
        
    }
    return _singleView1;
}

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  签名
 */
- (UIImageView *)signImageView {
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENWIDTH)];
        _signImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _signImageView;
}
/**
 *  箭头
 */
- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 24, (50 - 12) / 2, 12, 12)];
        _arrowImg.image = [UIImage imageNamed:@"work_rightjiantou"];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg;
}
/**
 单位label
 */
- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 24, 0, 12, 50)];
        _unitLabel.text = @"";
        _unitLabel.textColor = UIColorFromRGB(0x666666);
        _unitLabel.font = [UIFont systemFontOfSize:14];
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.hidden = YES;
    }
    return _unitLabel;
}
- (UILabel *)multiLineLabel {
    if (!_multiLineLabel) {
        _multiLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 45, SCREENWIDTH - 24, 20)];
        _multiLineLabel.numberOfLines = 0;
        _multiLineLabel.textColor = UIColorFromRGB(0x333333);
        _multiLineLabel.font = [UIFont systemFontOfSize:17.0f];
        _multiLineLabel.userInteractionEnabled = YES;
    }
    return _multiLineLabel;
}

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _showArrowImg = YES;
    }
    return self;
}
/**
 *  初始化空白cell类发方法
 */
+ (instancetype)nativeBaseBlankCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    MAFNativeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
/**
 *  初始化cell 根据indexPage布局右边控件
 */
- (void)initSubViewAndIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)identifier {
    
}
- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    //    self.leftTitleLabel.text = title;
    self.leftTitleLabel.attributedText = [self attributeStringWith:title];
    self.titleLable.attributedText = [self attributeStringWith:title];
    //    CGFloat titleWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]} context:nil].size.width;
    //    self.leftTitleLabel.width = titleWidth;
    
    //    CGFloat x = CGRectGetMaxX(self.leftTitleLabel.frame);
    if ([title isEqualToString:@"配套建设粪便污水贮存、处理、利用设施是否通过当地县级畜牧和环保部门验收(选填)"]) {
        self.leftTitleLabel.font = [UIFont systemFontOfSize:12];
    } else {
        self.leftTitleLabel.font = [UIFont systemFontOfSize:17];
    }
    if (_showArrowImg) {
        _textField.frame = CGRectMake(100, 0, SCREENWIDTH - 100 - 24 - 5, 50);
    }else {
        _textField.frame = CGRectMake(100, 0, SCREENWIDTH - 100 - 5 - 12, 50);
    }
    self.arrowImg.hidden = !_showArrowImg;
    //    _selectBtn.frame = CGRectMake(x + 5, 0, SCREENWIDTH - x - 24 - 10, 50);
}

-(void)setIntroduceString:(NSString *)introduceString{
    if (_introduceString != introduceString) {
        _introduceString = introduceString;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    if (_indexPath != indexPath) {
        _indexPath = indexPath;
    }
}
- (void)setTextPlaceholder:(NSString *)textPlaceholder {
    if (_textPlaceholder != textPlaceholder) {
        _textPlaceholder = textPlaceholder;
    }
}
#pragma mark 为了消除警告,在子类中要重写该方法
- (void)textFieldEndEdit:(UITextField *)textField {
    
}
- (void)textFieldBeginEdit:(UITextField *)textField {
    
}
- (void)clickSelectBtn {
    
}
- (void)clickYesBtn {
    
}
- (void)clickNoBtn {
    
}
- (void)leftTitleTap{
    
}
- (NSAttributedString *)attributeStringWith:(NSString *)string {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@"*"];
    if (range.location != NSNotFound) {
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, 1)];
        if (self.introduceString.length) {
            [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length - 1)];
            [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x003A8C) range:NSMakeRange(0, string.length - 1)];
        }
    }else{
        if (self.introduceString.length) {
            [attStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length - 1)];
            [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x003A8C) range:NSMakeRange(0, string.length - 1)];
        }
    }
    return attStr;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
