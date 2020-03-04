//
//  MAFNativeNumberCell.m
//  MAF
//
//  Created by 高赛 on 2017/9/4.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeNumberCell.h"
#import "UIView+Uitls.h"

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation MAFNativeNumberCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    MAFNativeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier withUnitStr:@""];
    }
    return cell;
}
/**
 *  初始化cell类发方法带单位
 */
+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath withUnitStr:(NSString *)unitStr {
    MAFNativeNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier withUnitStr:unitStr];
    }
    return cell;
}
/**
 *  初始化cell 根据indexPage布局右边控件
 */
- (void)initSubViewAndIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)identifier withUnitStr:(NSString *)unitStr {
    [self.contentView addSubview:self.leftTitleLabel];
    self.indexPath = indexPath;
    
    if (![unitStr isEqualToString:@""]) {
        self.unitLabel.hidden = NO;
        self.unitLabel.text = unitStr;
        [self.unitLabel sizeToFit];
        self.unitLabel.x = SCREENWIDTH - 12 - self.unitLabel.width;
        self.unitLabel.height = 50;
        CGFloat x = CGRectGetMaxX(self.leftTitleLabel.frame);
        self.textField.width = SCREENWIDTH - x - 12 - self.unitLabel.width;
        [self.contentView addSubview:self.unitLabel];
        self.arrowImg.hidden = YES;
    }
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.arrowImg];
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    if ([self.type isEqualToString:@"detail"]) {
        self.textField.enabled = NO;
    } else {
        self.textField.enabled = YES;
    }
    if ([self.keyBoardType isEqualToString:@"yingwen"]) {
        self.textField.keyboardType = UIKeyboardTypeAlphabet;
    } else {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;        
    }
}

- (void)textFieldEndEdit:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        if (self.isNoDefault) {
            
        } else {
            textField.text = @"0";            
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellTextCellTextEndingWith:withIndexPath:)]) {
        [self.delegate baseCellTextCellTextEndingWith:textField.text withIndexPath:self.indexPath];
    }
}
- (void)textFieldBeginEdit:(UITextField *)textField {
    if ([textField.text isEqualToString:@"0"]) {
        textField.text = @"";
    }
}

- (void)setDateStr:(NSString *)dateStr {
    self.textField.text = dateStr;
}
- (void)setUnitStr:(NSString *)unitStr {
    self.unitLabel.hidden = NO;
    self.unitLabel.text = unitStr;
    [self.unitLabel sizeToFit];
    self.unitLabel.x = SCREENWIDTH - 12 - self.unitLabel.width;
    self.unitLabel.height = 50;
    CGFloat x = CGRectGetMaxX(self.leftTitleLabel.frame);
    self.textField.width = SCREENWIDTH - x - 12 - self.unitLabel.width;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
