//
//  MAFNativeTextLayoutCell.m
//  MAF
//
//  Created by joy 尹 on 2019/11/16.
//  Copyright © 2019 ctnq. All rights reserved.
//

#import "MAFNativeTextLayoutCell.h"
#import "Masonry/Masonry.h"

@implementation MAFNativeTextLayoutCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeTextLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeTextLayoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.singleView1];
    [self.singleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(170, 40));
    }];
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(7);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7);
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.right.mas_equalTo(self.singleView1.mas_left);
    }];
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    if ([self.type isEqualToString:@"detail"]) {
        self.yesBtn.enabled = NO;
        self.noBtn.enabled = NO;
    } else {
        self.yesBtn.enabled = YES;
        self.noBtn.enabled = YES;
    }
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.singleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(170, 40));
    }];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(7);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7);
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.right.mas_equalTo(self.singleView1.mas_left);
    }];
}


- (void)clickYesBtn {
    self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
    self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellSingleSelectWithIndexPath:withValue:)]) {
        [self.delegate baseCellSingleSelectWithIndexPath:self.indexPath withValue:YES];
    }
}
- (void)clickNoBtn {
    self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellSingleSelectWithIndexPath:withValue:)]) {
        [self.delegate baseCellSingleSelectWithIndexPath:self.indexPath withValue:NO];
    }
}

- (void)setDefaultSelectValue:(BOOL)defaultSelectValue {
    if (defaultSelectValue) {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    }else {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
    }
}
- (void)setDefaultSelectStr:(NSString *)defaultSelectStr {
    if ([defaultSelectStr isEqualToString:@"1"]) {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    } else if ([defaultSelectStr isEqualToString:@"0"]) {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
    } else {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    }
}
- (void)setDateStr:(NSString *)dateStr {
    if ([dateStr isEqualToString:@"0"]) {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
    } else if([dateStr isEqualToString:@"1"]) {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_Yes"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    } else {
        self.yesImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
        self.noImg.image = [UIImage imageNamed:@"FY_SelectCircle_No"];
    }
}
@end
