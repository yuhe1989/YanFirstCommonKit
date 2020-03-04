//
//  MAFNativeShowTextCell.m
//  MAF
//
//  Created by joy 尹 on 2019/11/15.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "MAFNativeShowTextCell.h"
#import "UIView+Uitls.h"

@implementation MAFNativeShowTextCell

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    MAFNativeShowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeShowTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    MAFNativeShowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeShowTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier withUnitStr:unitStr];
    }
    return cell;
}
/**
 *  初始化cell 根据indexPage布局右边控件
 */
- (void)initSubViewAndIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)identifier withUnitStr:(NSString *)unitStr{
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
    self.textField.frame = CGRectMake(100, 0, SCREENWIDTH - 100 - 12 - 5, 50);
    [self.contentView addSubview:self.textField];
//    [self.contentView addSubview:self.arrowImg];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    self.textField.frame = CGRectMake(100, 0, SCREENWIDTH - 100 - 8 - 5, 50);
    self.arrowImg.hidden = YES;
    if ([self.type isEqualToString:@"detail"]) {
        self.textField.enabled = NO;
    } else {
        self.textField.enabled = YES;
        if (self.textPlaceholder == nil || [self.textPlaceholder isEqualToString:@""]) {
            
        } else {
            self.textField.placeholder = self.textPlaceholder;
        }
    }
}

- (void)textFieldEndEdit:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellTextCellTextEndingWith:withIndexPath:)]) {
        [self.delegate baseCellTextCellTextEndingWith:textField.text withIndexPath:self.indexPath];
    }
}

- (void)setDateStr:(NSString *)dateStr {
    self.textField.text = dateStr;
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

@end
