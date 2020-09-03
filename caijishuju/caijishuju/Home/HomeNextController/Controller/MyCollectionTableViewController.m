//
//  MyCollectionTableViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/26.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyCollectionTableViewController.h"
#import "CollectionSearchView.h"
#import "TimeTypeViewController.h"
#import "TaskModel.h"
#import "TaskByModel.h"
#import "MyCollectionTableViewCell.h"
#import "TaskMapDataSubmitController.h"

@interface MyCollectionTableViewController ()<UISearchBarDelegate,UITextFieldDelegate,CollectionSearchViewDelegate,TimeTypeViewControllerDelegate,THDatePickerViewDelegate,MyCollectionTableViewCellDelegate>

@property (nonatomic, strong) NSString *starttime;

@property (nonatomic, strong) NSString *endtime;

@property (nonatomic, strong) NSString *zuowuName;

@property (nonatomic, assign) NSInteger pageNo;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) NSInteger timetype;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) TimeTypeViewController *alertView;

@property (strong, nonatomic) THDatePickerView *dateView;

@property (nonatomic, assign) NSInteger clickType;

@end

@implementation MyCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的采集";
    self.pageSize = 10;
    self.timetype = 0;
    self.clickType = 0;
    self.starttime = @"";
    self.endtime = @"";
    self.pageNo = 1;
    self.modelArray = [NSMutableArray array];
    [self loadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCollectionTableViewCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageSize = 10;
        self.timetype = 0;
        self.clickType = 0;
        self.starttime = @"";
        self.endtime = @"";
        self.pageNo = 1;
        self.modelArray = [NSMutableArray array];
        [self loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageNo ++;
        [self loadData];
    }];
}

-(void)loadData{
    [LSNetworkService getMyCollectionWithDic:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize),@"timetype":@(self.timetype),@"starttime":self.starttime,@"endtime":self.endtime} response:^(id dict, BSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                NSArray *array = dic[@"dataValue"][@"rows"];
                for (int i = 0; i < array.count; i ++) {
                    NSDictionary *dicc = array[i];
                    TaskModel *model = [TaskModel mj_objectWithKeyValues:dicc];
                    model.ID = dicc[@"id"];
                    model.createBy = [TaskByModel mj_objectWithKeyValues:dicc[@"createBy"]];
                    model.createBy.ID = dicc[@"createBy"][@"id"];
                    model.createBy.passwordNew = dicc[@"createBy"][@"newPassword"];
                    [self.modelArray addObject:model];
                }
                [self.tableView reloadData];
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.imageView != nil) {
        [self.imageView removeFromSuperview];
    }
    if (self.modelArray.count == 0) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 167) / 2, (SCREENH_HEIGHT - 91)/ 2, 176, 91)];
        self.imageView.image = [UIImage imageNamed:@"暂无采集"];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.imageView];
    }else{
        [self.imageView removeFromSuperview];
    }
    return self.modelArray.count;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.imageView removeFromSuperview];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCollectionTableViewCell" owner:nil options:nil] firstObject];
    }
    TaskModel *model = self.modelArray[indexPath.row];
    cell.name.text = model.zuowumc;
    cell.weizhi.text = [NSString stringWithFormat:@"%@%@",model.province,model.district];
    cell.time.text = model.updateDate;
    if ([model.zuowumc isEqualToString:@"非作物"]) {
        cell.typeImageView.image = [UIImage imageNamed:@"植物"];
    }else{
        cell.typeImageView.image = [UIImage imageNamed:@"小麦选项"];
    }
    if ([model.zhuangtai integerValue] == 20) {
        cell.shareImageView.image = [UIImage imageNamed:@"共享"];
    }else{
        cell.shareImageView.image = [UIImage imageNamed:@"为共享"];
    }
    cell.delegate = self;
    cell.tag = 2000 + indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskModel *model = self.modelArray[indexPath.row];
    TaskMapDataSubmitController *tmdsc = [TaskMapDataSubmitController new];
    tmdsc.type = 1;
    tmdsc.model = model;
    [self.navigationController pushViewController:tmdsc animated:YES];
}

- (void)deleatWithTag:(NSInteger)tag{
    NSLog(@"%ld",tag);
    TaskModel *model = self.modelArray[tag - 2000];
    [LSNetworkService getDeleatWithID:model.ID response:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                self.pageNo = 1;
                self.modelArray = [NSMutableArray array];
                [self loadData];
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CollectionSearchView *view =  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CollectionSearchView class]) owner:nil options:nil] lastObject];
    view.searchBar.delegate = self;
    view.delegate = self;
    UITextField *searchField = [view.searchBar valueForKey:@"searchField"];
    searchField.text = self.zuowuName;
    searchField.delegate = self;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

- (void)timeView{
    self.alertView = [[TimeTypeViewController alloc] initWithNibName:@"TimeTypeViewController" bundle:nil];
    self.alertView.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
    self.alertView.delegate = self;
    self.alertView.startTime.hidden = YES;
    self.alertView.endTime.hidden = YES;
    self.alertView.toLabel.hidden = YES;
    self.alertView.timeViewH.constant = 130;
    UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start:)];
    UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(end:)];
    [self.alertView.startTime addGestureRecognizer:startTap];
    [self.alertView.endTime addGestureRecognizer:endTap];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.alertView.view];
    [self addChildViewController:self.alertView];
}

-(void)start:(UITapGestureRecognizer *)tap{
    self.clickType = 0;
    [self chooseTime];
}

-(void)end:(UITapGestureRecognizer *)tap{
    self.clickType = 1;
    [self chooseTime];
}

-(void)chooseTypeWithTag:(NSInteger)tag{
    if (tag == 1004) {
        self.alertView.startTime.hidden = NO;
        self.alertView.endTime.hidden = NO;
        self.alertView.toLabel.hidden = NO;
        self.alertView.timeViewH.constant = 200;
    }else{
        self.alertView.startTime.hidden = YES;
        self.alertView.endTime.hidden = YES;
        self.alertView.toLabel.hidden = YES;
        self.alertView.timeViewH.constant = 130;
    }
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [self.alertView.view viewWithTag:1001 + i];
        if (tag - 1001 == i) {
            button.selected = YES;
            self.timetype = i;
        }else{
            button.selected = NO;
        }
    }
}

-(void)cancle{
    [self.alertView removeFromParentViewController];
    [self.alertView.view removeFromSuperview];
}

- (void)sure{
    if (self.timetype == 3) {
        if (self.starttime.length > 0 && self.endtime.length > 0) {
            self.pageNo = 1;
            self.modelArray = [NSMutableArray array];
            [self loadData];
        }
    }else{
        self.pageNo = 1;
        self.modelArray = [NSMutableArray array];
        [self loadData];
    }
    [self.alertView removeFromParentViewController];
    [self.alertView.view removeFromSuperview];
}

-(void)chooseTime
{
    self.dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 300)];
    self.dateView.delegate = self;
    self.dateView.title = @"请选择时间";
    [self.view endEditing:YES];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateView];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, SCREENH_HEIGHT - 300, SCREEN_WIDTH, 300);
        [self.dateView show];
    }];
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    [self.dateView removeFromSuperview];
    self.dateView.hidden = YES;
    if (self.clickType == 0) {
        self.alertView.startTime.text = timer;
        self.starttime = timer;
    }else{
        self.alertView.endTime.text = timer;
        self.endtime = timer;
    }
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    self.dateView.hidden = YES;
    [self.dateView removeFromSuperview];
}

@end
