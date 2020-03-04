//
//  MAFNativeSingleCell.m
//  MAF
//
//  Created by 高赛 on 2017/9/4.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeSingleCell.h"

@implementation MAFNativeSingleCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.singleView];
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
