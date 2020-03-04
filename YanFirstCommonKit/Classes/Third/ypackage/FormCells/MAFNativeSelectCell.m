//
//  MAFNativeSelectCell.m
//  MAF
//
//  Created by 高赛 on 2017/9/4.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeSelectCell.h"
#import "UIColor+AN.h"

///定义screen的宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation MAFNativeSelectCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.leftTitleLabel];
    self.indexPath = indexPath;
    
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.arrowImg];
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
    CGFloat titleWidth = [dateStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]} context:nil].size.width;
    if (titleWidth >= SCREENWIDTH - 140 - 24 - 5) {
        self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }else{
        self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    if (dateStr != nil && dateStr.length) {
        [self.selectBtn setTitle:dateStr forState:UIControlStateNormal];
        [self.selectBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    }else {
        if ([self.type isEqualToString:@"detail"] && !dateStr.length) {
            [self.selectBtn setTitle:@"" forState:UIControlStateNormal];
        }else {
            [self.selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
            [self.selectBtn setTitleColor:[UIColor colorWithHexString:@"#c0c0c0"] forState:UIControlStateNormal];
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
