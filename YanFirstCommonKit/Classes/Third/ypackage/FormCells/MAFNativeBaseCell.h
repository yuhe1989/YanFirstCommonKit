//
//  MAFNativeBaseCell.h
//  MAF
//
//  Created by 高赛 on 2017/9/4.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MAFNativeBaseCellDelegate <NSObject>
@optional
/**
 *  展示选择控件
 */
- (void)baseCellShowSelectViewWithIndexPath:(NSIndexPath *)indexPath;
/**
 开始输入时
 */
- (void)baseCellTextBeginEdit;
/**
 *  textView输入完毕后
 */
- (void)baseCellTextViewCellTextEndingWith:(NSString *)str withIndexPath:(NSIndexPath *)indexPath;
/**
 *  textField输入完毕后
 */
- (void)baseCellTextCellTextEndingWith:(NSString *)str withIndexPath:(NSIndexPath *)indexPath;
/**
 *  单选框选择了后
 */
- (void)baseCellSingleSelectWithIndexPath:(NSIndexPath *)indexPath withValue:(BOOL )value;

// 弹出介绍文字
- (void)baseCellTextIntroduce:(NSString *)textIntroduce title:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end

@interface MAFNativeBaseCell : UITableViewCell
/**
 *  代理
 */
@property (nonatomic, assign) id<MAFNativeBaseCellDelegate> delegate;
/**
 *  页面类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  是否是农民  0不是 1是
 */
@property (nonatomic, assign) BOOL isFarmer;
/**
 *  cell 下标
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  左边标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *introduceString;  // 介绍的文字
/**
 *  右边数据
 */
@property (nonatomic, copy) NSString *dateStr;
/**
 单位字段
 */
@property (nonatomic, copy) NSString *unitStr;
/**
 *  单选按钮默认值
 */
@property (nonatomic, assign) BOOL defaultSelectValue;
/**
 单选按钮默认值 字符串格式
 */
@property (nonatomic, copy) NSString *defaultSelectStr;
/**
 *  签名视图
 */
@property (nonatomic, strong) UIImageView *signImageView;

#pragma mark 子类中需要用到  声明在.h中
/**
 *  左边标题栏
 */
@property (nonatomic, strong) UILabel *leftTitleLabel;
/**
 左边标题1
 */
@property (nonatomic, strong) UILabel *titleLable;
/**
 右边展示文字
 */
@property (nonatomic, strong) UILabel *rightLable;
/**
 *  文本输入框
 */
@property (nonatomic, strong) UITextField *textField;
/**
 *  数字输入框
 */
@property (nonatomic, strong) UITextField *numberField;
/**
 *  选择按钮
 */
@property (nonatomic, strong) UIButton *selectBtn;
/**
 *  文本输入视图
 */
@property (nonatomic, strong) UITextView *textView;
/**
 *  单选父视图
 */
@property (nonatomic, strong) UIView *singleView;
/**
 *  单选父视图1
 */
@property (nonatomic, strong) UIView *singleView1;
/**
 *  是按钮
 */
@property (nonatomic, strong) UIButton *yesBtn;
/**
 *  是文字
 */
@property (nonatomic, strong) UILabel *yesLabel;
/**
 *  是图片
 */
@property (nonatomic, strong) UIImageView *yesImg;
/**
 *  否按钮
 */
@property (nonatomic, strong) UIButton *noBtn;
/**
 *  否文字
 */
@property (nonatomic, strong) UILabel *noLabel;
/**
 *  否图片
 */
@property (nonatomic, strong) UIImageView *noImg;
/**
 *  箭头图片
 */
@property (nonatomic, strong) UIImageView *arrowImg;
/**
 *  是否展示箭头
 */
@property (nonatomic, assign) BOOL showArrowImg;
/**
 单位label
 */
@property (nonatomic, strong) UILabel *unitLabel;
/**
 是否有默认值  1没有默认值 0有默认值
 */
@property (nonatomic, assign) BOOL isNoDefault;
/**
 键盘类型
 */
@property (nonatomic, copy) NSString *keyBoardType;
/**
 提示文字
 */
@property (nonatomic, copy) NSString *textPlaceholder;
/**
 *  多行展示label 默认高度20
 */
@property (nonatomic, strong) UILabel *multiLineLabel;
/**
 动物疫病表单,样品编号
 */
@property (nonatomic, copy) NSString *numText;
/**
 *  初始化空白cell类发方法
 */
+ (instancetype)nativeBaseBlankCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath;
/**
 *  初始化cell类发方法
 */
+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath;
/**
 *  初始化cell类发方法带单位
 */
+ (instancetype)nativeBaseCellTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath withUnitStr:(NSString *)unitStr;

@end
