//
//  MAFYcYdMapVC.m
//  MAF
//
//  Created by wang k on 2017/8/17.
//  Copyright © 2017年 ctnq. All rights reserved.
//

#import "MAFYcYdMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MAFYcYdHttpManager.h"
#import "UIView+Uitls.h"
#import "UIImage+AN.h"
#import "UIView+Extension.h"
#import "MBProgressHUD.h"

#define iOS11Later        ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define kStatusBarHeight (iOS11Later ? ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom>0 ? 44 : 20):[[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavBarHeight 44.0
#define kMainBottomHeight (@available(iOS 11.0, *)?([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom>0?83:49):([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49))
#define kMainTopHeight (kStatusBarHeight + kNavBarHeight)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)    //屏幕高度

#define IMAGED(name) [UIImage imageNamed:name]

@interface MAFYcYdMapVC ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, assign) CLLocationCoordinate2D center;

@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) AMapReGeocodeSearchRequest *regeo;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) NSMutableArray *searchDataArr;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) NSInteger searchPage;

@property (nonatomic, assign) BOOL isShowLoading;

@end

@implementation MAFYcYdMapVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        CGFloat y = 64 + 40 + 280;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, self.view.width, self.view.height - y) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UITableView *)searchTableView {
    if (_searchTableView == nil) {
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kMainTopHeight + 40, self.view.width, self.view.height - kMainTopHeight - 40) style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.tableFooterView = [UIView new];
    }
    return _searchTableView;
}
- (NSMutableArray *)searchDataArr {
    if (_searchDataArr == nil) {
        _searchDataArr = [NSMutableArray array];
    }
    return _searchDataArr;
}
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, kMainTopHeight, self.view.width, 40)];
        _searchBar.barStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"搜索位置";
        _searchBar.delegate = self;
        _searchBar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor] size:_searchBar.size];
        _searchBar.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    }
    return _searchBar;
}
#pragma 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubView];
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    CGRect rect = CGRectMake(0, kMainTopHeight + 40, self.view.width, SCREEN_HEIGHT - kMainTopHeight - 40);
    _mapView = [[MAMapView alloc] initWithFrame:rect];
    _mapView.delegate = self;
    _mapView.zoomLevel = 17;
    _mapView.showsCompass = YES;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.lockedToScreen = YES;
    NSLog(@"%@",NSStringFromCGPoint(self.mapView.center));
    pointAnnotation.lockedScreenPoint = CGPointMake(self.mapView.centerX, self.mapView.centerY - 100);
    
    [_mapView addAnnotation:pointAnnotation];
    self.pointAnnotation = pointAnnotation;
}

// 设置导航字体大小
#define NAVIGATION_FONT_SIZE 18

#pragma customFunction
- (void)setSubView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
//    [self.view addSubview:self.tableView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backButton setImage:IMAGED(@"MAF_NavBack") forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 25)];
    [backButton addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:NAVIGATION_FONT_SIZE];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"地理位置";
    self.navigationItem.titleView = titleLabel;
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [addBtn setTitle:@"确定" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [addBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    [addBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRightBtn {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:self.isNetWork?@"是否是在该场站现场,需要修改坐标信息?":@"是否确认该位置为目标位置?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    if (self.isNetWork) {
//        alertView.message = @"是否是在该场站现场,需要修改坐标信息?";
//    }
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location                    = [AMapGeoPoint locationWithLatitude:_mapView.region.center.latitude longitude:_mapView.region.center.longitude];
        regeo.requireExtension            = YES;
        [self.search AMapReGoecodeSearch:regeo];
    }
}
#pragma MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    [mapView deselectAnnotation:self.pointAnnotation animated:NO];
}
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
//    self.page = 1;
//    [self searchPOIWithPage:self.page];
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
#pragma AMapSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self hideLoading];
    if (response.pois.count == 0)
    {
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    if (self.isShow) {
        if (request.offset == 21) {
            if (self.searchPage == 1) {
                [self.searchDataArr removeAllObjects];
                self.searchDataArr = [NSMutableArray arrayWithArray:response.pois];
            }else {
                [self.searchDataArr addObjectsFromArray:response.pois];
            }
            [self.searchTableView reloadData];
        }
    } else {
        if (self.page == 1) {
            [self.dataArr removeAllObjects];
            self.dataArr = [NSMutableArray arrayWithArray:response.pois];
            
            
        } else {
            [self.dataArr addObjectsFromArray:response.pois];
        }
        [self.tableView reloadData];
    }
}
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {
        self.selectBlock(response.regeocode.formattedAddress, [NSString stringWithFormat:@"%.6lf",request.location.latitude], [NSString stringWithFormat:@"%.6lf",request.location.longitude]);
        if (self.isNetWork) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.dataArr.count;
    } else {
        return self.searchDataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"";
    AMapPOI *poi = [[AMapPOI alloc] init];
    if (tableView == self.tableView) {
        identifier = @"mapCell";
        poi = self.dataArr[indexPath.row];
    } else {
        identifier = @"searchCell";
        poi = self.searchDataArr[indexPath.row];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AMapPOI *poi = nil;
    if (tableView == self.tableView) {
        poi = self.dataArr[indexPath.row];
    } else {
        poi = self.searchDataArr[indexPath.row];
    }
    NSString *latitude = [NSString stringWithFormat:@"%.6lf",poi.location.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.6lf",poi.location.longitude];
    self.selectBlock(poi.name, latitude, longitude);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShow) {
        if (indexPath.row == [self.searchDataArr count] - 4) {
            self.searchPage++;
            [self searchKeyWord:self.searchBar.text andPage:self.searchPage];
        }
    } else {
        if (indexPath.row == [self.dataArr count] - 4) {
            self.page ++;
            [self searchPOIWithPage:self.page];
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isShow) {
        [self.searchBar resignFirstResponder];
    }
}
#pragma UISearchBarDelegate
// 改变searchBar上右边按钮
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    for (id cc in [searchBar subviews]) {
        for (UIView *view in [cc subviews]) {
            if ([NSStringFromClass(view.class) isEqualToString:@"UINavigationButton"]) {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
    [self showSearchBarTop];
}
// 搜索栏上取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [self hideSearchBarTop];
}
// 文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        [self.searchDataArr removeAllObjects];
        [self.searchTableView reloadData];
    } else {
        self.searchPage = 1;
        [self searchKeyWord:searchText andPage:self.searchPage];
    }
}
// 显示搜索列表
- (void)showSearchBarTop {
    [self.view addSubview:self.searchTableView];
    self.isShow = YES;
    self.searchPage = 1;
}
// 隐藏搜索列表
- (void)hideSearchBarTop {
    [self.searchTableView removeFromSuperview];
    self.isShow = NO;
}
/**
 关键字检索
 */
- (void)searchKeyWord:(NSString *)keyWord andPage:(NSInteger )page {
    [self showLoading];
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = keyWord;
    request.requireExtension    = YES;
    request.city = self.city;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.offset = 21;
    request.page = page;
    [self.search AMapPOIKeywordsSearch:request];
}
- (void)searchPOIWithPage:(NSInteger )page {
    [self showLoading];
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:_mapView.region.center.latitude longitude:_mapView.region.center.longitude];
    request.keywords            = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.radius = 500;
    request.page = page;
    [self.search AMapPOIAroundSearch:request];
}

- (void)showLoading {
    if (self.isShowLoading) {
        
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.isShowLoading = YES;
    }
}
- (void)hideLoading {
    if (self.isShowLoading) {
        self.isShowLoading = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}
#pragma systemFunction
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
