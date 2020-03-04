//
//  MAFNativeSignCell.m
//  MAF
//
//  Created by wang k on 2017/9/20.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFNativeSignCell.h"

@implementation MAFNativeSignCell

+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
    MAFNativeSignCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MAFNativeSignCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell initSubViewAndIndexPath:indexPath andIdentifier:identifier];
    }
    return cell;
}

- (void)initSubViewAndIndexPath:(NSIndexPath *)indexPath andIdentifier:(NSString *)identifier {
    [self.contentView addSubview:self.signImageView];
    self.indexPath = indexPath;
}

@end
