//
//  MAFYcYdMulitiSelectVC.m
//  MAF
//
//  Created by 高赛 on 2018/3/27.
//  Copyright © 2018年 ctnq. All rights reserved.
//

#import "MAFYcYdMulitiSelectVC.h"
#import "MAFYcYdDataModel.h"
#import "MAFYcYdMulitiSelectCell.h"
#import "UIView+Uitls.h"
#import "MBProgressHUD.h"

#define IMAGED(name) [UIImage imageNamed:name]

@interface MAFYcYdMulitiSelectVC ()<UITableViewDelegate, UITableViewDataSource, MAFYcYdMulitiSelectCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MAFYcYdMulitiSelectVC
#pragma mark 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)selectedModels {
    if (!_selectedModels) {
        _selectedModels = [NSMutableArray array];
    }
    return _selectedModels;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.rowHeight = 50.0f;
    }
    return _tableView;
}
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self.view addSubview:self.tableView];
}

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)      //屏幕宽度
// 设置导航字体大小
#define NAVIGATION_FONT_SIZE 18

#pragma mark 自定义方法
- (void)setNav {
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:IMAGED(@"MAF_NavBack") forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 25)];
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.navTitle;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:NAVIGATION_FONT_SIZE];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [submitBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submitAction {
    [self.view endEditing:YES];
    [self.selectedModels removeAllObjects];
    for (MAFYcYdDataModel *model in _dataArr) {
        if (model.is_select) {
            [self.selectedModels addObject:model];
            if (self.isZhaoYe) {
                if ([model.dict_id isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"]) {
                    if (self.zhaoyhtcs_num1.length == 0 || [self.zhaoyhtcs_num1 isEqualToString:@"0"]) {
                        [self showNotice:@"请输入粪水潜水泵台数"];
                        return;
                    }
                } else if ([model.dict_id isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"]) {
                    if (self.zhaoyhtcs_num2.length == 0 || [self.zhaoyhtcs_num2 isEqualToString:@"0"]) {
                        [self showNotice:@"请输入硬管及田间沼液池米数"];
                        return;
                    }
                } else if ([model.dict_id isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"]) {
                    if (self.zhaoyhtcs_num3.length == 0 || [self.zhaoyhtcs_num3 isEqualToString:@"0"]) {
                        [self showNotice:@"请输入沼液车个数"];
                        return;
                    }
                }                
            }
        }
    }
    if (!self.selectedModels.count) {
        [self showNotice:@"请至少选择一项"]; return;
    }
    if (self.multiSelectBlock) {
        self.multiSelectBlock(self.selectedModels, self.zhaoyhtcs_num1, self.zhaoyhtcs_num2, self.zhaoyhtcs_num3);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAFYcYdDataModel *model = [self.dataArr objectAtIndex:indexPath.row];
    MAFYcYdMulitiSelectCell *cell = [MAFYcYdMulitiSelectCell cellWithTableView:tableView];
    cell.title = model.dict_name;
    cell.dictId = model.dict_id;
    cell.is_select = model.is_select;
    cell.delegate = self;
    cell.indexPath = indexPath;
    if (self.isZhaoYe) {
        if ([model.dict_id isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"]) {
            cell.num = _zhaoyhtcs_num1;
        } else if ([model.dict_id isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"]) {
            cell.num = _zhaoyhtcs_num2;
        } else if ([model.dict_id isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"]) {
            cell.num = _zhaoyhtcs_num3;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MAFYcYdDataModel *model = [_dataArr objectAtIndex:indexPath.row];
    model.is_select = !model.is_select;
    if (self.isZhaoYe) {
        if ([model.dict_id isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"] && !model.is_select) {
            _zhaoyhtcs_num1 = @"";
        } else if ([model.dict_id isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"] && !model.is_select) {
            _zhaoyhtcs_num2 = @"";
        } else if ([model.dict_id isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"] && !model.is_select) {
            _zhaoyhtcs_num3 = @"";
        }
        if (indexPath.row == 4) {
            for (int i = 0; i <= 3; i++) {
                MAFYcYdDataModel *model = self.dataArr[i];
                model.is_select = NO;
            }
            self.zhaoyhtcs_num1 = @"";
            self.zhaoyhtcs_num2 = @"";
            self.zhaoyhtcs_num3 = @"";
        } else {
            MAFYcYdDataModel *model = self.dataArr.lastObject;
            model.is_select = NO;
        }
    } else if (self.isWSLYFS) {
        if (indexPath.row == 5) {
            for (int i = 0; i <= 4; i++) {
                MAFYcYdDataModel *model = self.dataArr[i];
                model.is_select = NO;
            }
        } else {
            MAFYcYdDataModel *model = self.dataArr.lastObject;
            model.is_select = NO;
        }
    } else {
        if ([model.dict_name isEqualToString:@"无"]) {
            for (MAFYcYdDataModel *model in self.dataArr) {
                if (![model.dict_name isEqualToString:@"无"]) {
                    model.is_select = NO;
                }
            }
        } else {
            for (MAFYcYdDataModel *model in self.dataArr) {
                if ([model.dict_name isEqualToString:@"无"]) {
                    model.is_select = NO;
                }
            }
        }
    }
    [tableView reloadData];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
#pragma mark MAFYcYdMulitiSelectCellDelegate
- (void)clickImgBtnWithIndexPath:(NSIndexPath *)indexPath {
    MAFYcYdDataModel *model = [_dataArr objectAtIndex:indexPath.row];
    model.is_select = !model.is_select;
    if (self.isZhaoYe) {
        if ([model.dict_id isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"] && !model.is_select) {
            _zhaoyhtcs_num1 = @"";
        } else if ([model.dict_id isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"] && !model.is_select) {
            _zhaoyhtcs_num2 = @"";
        } else if ([model.dict_id isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"] && !model.is_select) {
            _zhaoyhtcs_num3 = @"";
        }
        if (indexPath.row == 4) {
            for (int i = 0; i <= 3; i++) {
                MAFYcYdDataModel *model = self.dataArr[i];
                model.is_select = NO;
            }
            self.zhaoyhtcs_num1 = @"";
            self.zhaoyhtcs_num2 = @"";
            self.zhaoyhtcs_num3 = @"";
        } else {
            MAFYcYdDataModel *model = self.dataArr.lastObject;
            model.is_select = NO;
        }
    } else if (self.isWSLYFS) {
        if (indexPath.row == 5) {
            for (int i = 0; i <= 4; i++) {
                MAFYcYdDataModel *model = self.dataArr[i];
                model.is_select = NO;
            }
        } else {
            MAFYcYdDataModel *model = self.dataArr.lastObject;
            model.is_select = NO;
        }
    } else {
        if ([model.dict_name isEqualToString:@"无"]) {
            for (MAFYcYdDataModel *model in self.dataArr) {
                if (![model.dict_name isEqualToString:@"无"]) {
                    model.is_select = NO;
                }
            }
        } else {
            for (MAFYcYdDataModel *model in self.dataArr) {
                if ([model.dict_name isEqualToString:@"无"]) {
                    model.is_select = NO;
                }
            }
        }
    }
    [self.tableView reloadData];
}
- (void)textFieldEndEditWithStr:(NSString *)str withDictID:(NSString *)dictID {
    if ([str floatValue] == 0) {
        [self showNotice:@"请输入大于0的数"];
        return;
    }
    if ([dictID isEqualToString:@"56ac9f9b-1886-41c3-bba3-3089f11f0ff8"]) {
        self.zhaoyhtcs_num1 = str;
    } else if ([dictID isEqualToString:@"3fd2c45a-d316-401c-a47c-9ff1ee8d3804"]) {
        self.zhaoyhtcs_num2 = str;
    } else if ([dictID isEqualToString:@"d9dd57f4-3b2a-45bf-8e17-5cc678db2c18"]) {
        self.zhaoyhtcs_num3 = str;
    }
}

- (void)showNotice:(NSString *)notice {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = notice;
    hud.margin = 10.0f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
