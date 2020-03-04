//
//  MAFYcYdMulitiSelectCell.h
//  MAF
//
//  Created by 高赛 on 2018/3/27.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MAFYcYdMulitiSelectCellDelegate <NSObject>

- (void)clickImgBtnWithIndexPath:(NSIndexPath *)indexPath;

- (void)textFieldEndEditWithStr:(NSString *)str withDictID:(NSString *)dictID;

@end

@interface MAFYcYdMulitiSelectCell : UITableViewCell

@property (nonatomic, assign) id<MAFYcYdMulitiSelectCellDelegate> delegate;

@property (nonatomic, assign) BOOL is_select;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *dictId;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
