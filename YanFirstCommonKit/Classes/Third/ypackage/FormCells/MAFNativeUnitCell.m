//
//  MAFNativeUnitCell.m
//  MAF
//
//  Created by 高赛 on 2018/2/26.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFNativeUnitCell.h"
#import "UIColor+AN.h"
#import "UIView+Uitls.h"

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface MAFNativeUnitCell()

@property (nonatomic, strong) UITextField *unitField;
@property (nonatomic, copy) NSString *unitStr;

@end

@implementation MAFNativeUnitCell
- (UITextField *)unitField {
    if (!_unitField) {
        CGFloat x = CGRectGetMaxX(self.leftTitleLabel.frame);
        _unitField = [[UITextField alloc] initWithFrame:CGRectMake(x + 5, 0, SCREENWIDTH - x - 24 - 10, 50)];
        _unitField.font = [UIFont systemFontOfSize:17];
        _unitField.placeholder = @"请填写";
        _unitField.textColor = [UIColor colorWithHexString:@"#333333"];
        _unitField.textAlignment = NSTextAlignmentRight;
        [_unitField addTarget:self action:@selector(textFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
        [_unitField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _unitField;
}

/**
 *  初始化cell类发方法带单位
 */
+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath withUnitStr:(NSString *)unitStr {
    MAFNativeUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeUnitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier withUnitStr:unitStr];
    }
    [cell setUnitViewWithUnitStr:unitStr];
    return cell;
}
/**
 *  初始化cell 根据indexPage布局右边控件
 */
- (void)initSubViewAndIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)identifier withUnitStr:(NSString *)unitStr{
    [self.contentView addSubview:self.leftTitleLabel];
    self.indexPath = indexPath;
}
- (void)setUnitViewWithUnitStr:(NSString *)unitStr {
    [self.unitLabel removeFromSuperview];
    [self.unitField removeFromSuperview];
    
    self.unitLabel.hidden = NO;
    self.unitLabel.text = unitStr;
    self.unitLabel.userInteractionEnabled = YES;
    [self.unitLabel sizeToFit];
    self.unitLabel.x = SCREENWIDTH - 12 - self.unitLabel.width;
    self.unitLabel.height = 50;
    self.unitStr = unitStr;
    CGFloat x = 112;
    self.unitField.frame = CGRectMake(x + 5, 0, SCREENWIDTH - x - 10 - 12 - self.unitLabel.width, 50);
    [self.contentView addSubview:self.unitLabel];
    self.arrowImg.hidden = YES;
    self.unitField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.contentView addSubview:self.unitField];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.unitLabel addGestureRecognizer:tap];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    if ([self.type isEqualToString:@"detail"]) {
        self.unitField.enabled = NO;
        self.unitLabel.userInteractionEnabled = NO;
    } else {
        self.unitField.enabled = YES;
        self.unitLabel.userInteractionEnabled = YES;
    }
    if (self.textPlaceholder == nil || [self.textPlaceholder isEqualToString:@""]) {
        
    } else {
        self.unitField.placeholder = self.textPlaceholder;
    }
    if ([self.unitStr isEqualToString:@"头/只/羽"] || [self.unitStr isEqualToString:@"个"] || [self.unitStr isEqualToString:@"栋"] || [self.unitStr isEqualToString:@"口"]|| [self.unitStr isEqualToString:@"尾"] || [self.unitStr isEqualToString:@"台"] || [self.unitStr isEqualToString:@"次"] || [self.unitStr isEqualToString:@"人"] || [self.unitStr isEqualToString:@"头"] || [self.unitStr isEqualToString:@"头/只/群"] || [self.unitStr isEqualToString:@"头/只"] || [self.unitStr isEqualToString:@"袋"]) {
        self.unitField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.unitField.keyboardType = UIKeyboardTypeDecimalPad;
    }
}
- (void)textFieldEndEdit:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellTextCellTextEndingWith:withIndexPath:)]) {
        if ([textField.text isEqualToString:@""]) {
            if ([self.unitStr isEqualToString:@"头/只/羽"] || [self.unitStr isEqualToString:@"个"] || [self.unitStr isEqualToString:@"栋"] || [self.unitStr isEqualToString:@"口"]|| [self.unitStr isEqualToString:@"尾"] || [self.unitStr isEqualToString:@"台"] || [self.unitStr isEqualToString:@"次"] || [self.unitStr isEqualToString:@"人"] || [self.unitStr isEqualToString:@"头"] || [self.unitStr isEqualToString:@"头/只/群"] || [self.unitStr isEqualToString:@"头/只"] || [self.unitStr isEqualToString:@"袋"]) {
                textField.text = @"0";
                if (self.isNoDefault) {
                    textField.text = @"";
                }
            } else {
                textField.text = @"0.00";
                if (self.isNoDefault) {
                    textField.text = @"";
                }
            }
        } else {
            if ([self.unitStr isEqualToString:@"头/只/羽"] || [self.unitStr isEqualToString:@"个"] || [self.unitStr isEqualToString:@"栋"] || [self.unitStr isEqualToString:@"口"]|| [self.unitStr isEqualToString:@"尾"] || [self.unitStr isEqualToString:@"台"] || [self.unitStr isEqualToString:@"次"] || [self.unitStr isEqualToString:@"人"] || [self.unitStr isEqualToString:@"头"] || [self.unitStr isEqualToString:@"头/只/群"] || [self.unitStr isEqualToString:@"头/只"] || [self.unitStr isEqualToString:@"袋"]) {
                
            } else {
                double num = [textField.text doubleValue];
                textField.text = [NSString stringWithFormat:@"%.2lf", num];
            }
        }
        [self.delegate baseCellTextCellTextEndingWith:textField.text withIndexPath:self.indexPath];
    }
}
- (void)textFieldBeginEdit:(UITextField *)textField {
    if ([textField.text isEqualToString:@"0"]) {
        textField.text = @"";
    } else if ([textField.text isEqualToString:@"0.00"]) {
        textField.text = @"";
    }
}
- (void)setDateStr:(NSString *)dateStr {
    self.unitField.text = dateStr;
}

- (void)tapAction:(UIGestureRecognizer *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellShowSelectViewWithIndexPath:)]) {
        [self.delegate baseCellShowSelectViewWithIndexPath:self.indexPath];
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    NSLog(@"load:%@",textField.text);
}

- (void)leftTitleTap{
    NSString *title = self.title;
    NSRange range = [title rangeOfString:@"*"];
    if (range.location != NSNotFound) {
        title = [title substringToIndex:title.length - 1];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellTextIntroduce: title: indexPath:)]) {
        [self.delegate baseCellTextIntroduce:self.introduceString title:title indexPath:self.indexPath];
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
