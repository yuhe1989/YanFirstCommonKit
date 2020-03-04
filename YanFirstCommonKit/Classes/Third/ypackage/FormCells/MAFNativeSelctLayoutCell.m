//
//  MAFNativeSelctLayoutCell.m
//  MAF
//
//  Created by joy 尹 on 2019/11/22.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "MAFNativeSelctLayoutCell.h"
#import "Masonry.h"
#import "UIColor+AN.h"

@implementation MAFNativeSelctLayoutCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeSelctLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeSelctLayoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier];
    }
    return cell;
}
/**
 *  初始化cell 根据indexPage布局右边控件
 */
- (void)initSubViewAndIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)identifier {
    self.indexPath = indexPath;
    
    [self.contentView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(7);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7);
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.width.mas_equalTo(self.mas_width).multipliedBy(14.0/32.0);
    }];
    
    self.rightLable.text = @"请选择";
    [self.contentView addSubview:self.rightLable];
    [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowImg.mas_left).offset(-8);
        make.top.mas_equalTo(self.contentView.mas_top).offset(7);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7);
        make.left.mas_equalTo(self.titleLable.mas_right).offset(8);
    }];
    
    [self.selectBtn setTitle:@"" forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowImg.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.titleLable.mas_right);
    }];
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    if ([self.type isEqualToString:@"detail"]) {
        self.selectBtn.enabled = NO;
    } else {
        self.selectBtn.enabled = YES;
    }
}
- (void)clickSelectBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellShowSelectViewWithIndexPath:)]) {
        [self.delegate baseCellShowSelectViewWithIndexPath:self.indexPath];
    }
}
- (void)setDateStr:(NSString *)dateStr {
//    CGFloat titleWidth = [dateStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]} context:nil].size.width;
//    if (titleWidth >= SCREENWIDTH - 140 - 24 - 5) {
//        self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    }else{
//        self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:17];
//    }
    if (dateStr != nil && dateStr.length) {
        self.rightLable.text = dateStr;
        self.rightLable.textColor = [UIColor colorWithHexString:@"#000000"];
    }else {
        if ([self.type isEqualToString:@"detail"] && !dateStr.length) {
            self.rightLable.text = @"";
        }else {
            self.rightLable.text = @"请选择";
            self.rightLable.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
        }
    }
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
