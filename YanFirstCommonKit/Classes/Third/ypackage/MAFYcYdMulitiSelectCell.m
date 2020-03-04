//
//  MAFYcYdMulitiSelectCell.m
//  MAF
//
//  Created by 高赛 on 2018/3/27.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdMulitiSelectCell.h"
#import "UIView+YYAdd.h"
#import "UIView+Uitls.h"

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface MAFYcYdMulitiSelectCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *markIcon;

@property (nonatomic, strong) UILabel *unitLabel;

@end

@implementation MAFYcYdMulitiSelectCell

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 24 , 0, 12, 50)];
        _unitLabel.text = @"";
        _unitLabel.textColor = UIColorFromRGB(0x666666);
        _unitLabel.font = [UIFont systemFontOfSize:14];
        _unitLabel.textAlignment = NSTextAlignmentRight;
    }
    return _unitLabel;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.unitLabel.x - 55, 10, 50, 30)];
        _textField.placeholder = @"请输入";
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.textAlignment = NSTextAlignmentRight;
        [_textField addTarget:self action:@selector(textFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _textField;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    MAFYcYdMulitiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MAFYcYdMulitiSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        _is_select = NO;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, SCREENWIDTH - 37 - 12, 50)];
    _titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _titleLabel.textColor = UIColorFromRGB(0x333333);
    [self addSubview:_titleLabel];
    
    _markIcon = [[UIButton alloc] initWithFrame:CGRectMake(12, 15, 20, 20)];
    [_markIcon setImage:[UIImage imageNamed:@"FY_SelectBox_No"] forState:UIControlStateNormal];
    [_markIcon addTarget:self action:@selector(clickMarkIconBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_markIcon];
}
- (void)setIs_select:(BOOL)is_select {
    _is_select = is_select;
    if (is_select) {
        [_markIcon setImage:[UIImage imageNamed:@"FY_SelectBox_Yes"] forState:UIControlStateNormal];
    }else {
        [_markIcon setImage:[UIImage imageNamed:@"FY_SelectBox_No"] forState:UIControlStateNormal];
    }
}
- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (void)setDictId:(NSString *)dictId {
    _dictId = dictId;
    if ([dictId isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"]) {
        self.unitLabel.text = @"台";
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
    } else if ([dictId isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"]) {
        self.unitLabel.text = @"米";
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
    } else if ([dictId isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"]) {
        self.unitLabel.text = @"个";
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
    }
}
- (void)setNum:(NSString *)num {
    if ([self.dictId isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"]) {
        self.textField.text = num;
    } else if ([self.dictId isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"]) {
        self.textField.text = num;
    } else if ([self.dictId isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"]) {
        self.textField.text = num;
    } else {
        self.textField.text = @"";
    }
}
- (void)textFieldEndEdit:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldEndEditWithStr:withDictID:)]) {
        [self.delegate textFieldEndEditWithStr:self.textField.text withDictID:self.dictId];
    }
}

//- (void)setNum:(NSString *)num {
//    _num = num;
//    self.textField.text = num;
//}

- (void)clickMarkIconBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImgBtnWithIndexPath:)]) {
        [self.delegate clickImgBtnWithIndexPath:self.indexPath];
    }
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
