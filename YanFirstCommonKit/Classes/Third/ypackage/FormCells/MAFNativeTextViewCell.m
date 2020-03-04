//
//  MAFNativeTextViewCell.m
//  MAF
//
//  Created by 高赛 on 2017/9/4.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeTextViewCell.h"

@interface MAFNativeTextViewCell ()<UITextViewDelegate>

@end

@implementation MAFNativeTextViewCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    [self.contentView addSubview:self.textView];
    self.textView.delegate = self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    
    if ([self.type isEqualToString:@"detail"]) {
        self.textView.editable = NO;
    } else {
        self.textView.editable = YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCellTextViewCellTextEndingWith:withIndexPath:)]) {
        [self.delegate baseCellTextViewCellTextEndingWith:textView.text withIndexPath:self.indexPath];
    }
}

- (void)setDateStr:(NSString *)dateStr {
    self.textView.text = dateStr;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
