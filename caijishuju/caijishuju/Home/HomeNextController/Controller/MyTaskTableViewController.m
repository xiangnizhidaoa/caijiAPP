//
//  MyTaskTableViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskTableViewController.h"
#import "SearchView.h"
#import "TaskModel.h"
#import "TaskByModel.h"
#import "MyTaskTableViewCell.h"
#import "MyTaskDetailsController.h"
#import "TaskMapDataSubmitController.h"

@interface MyTaskTableViewController ()<UISearchBarDelegate,UITextFieldDelegate,MyTaskTableViewCellDelegate>

@property (nonatomic, assign) NSInteger pageNo;/** 请求的页码 */

@property (nonatomic, assign) NSInteger pageSize;/** 请求页码的数量 */

@property (nonatomic, strong) NSString *zuowuName;/** 作物名称 */

@property (nonatomic, strong) NSMutableArray *modelArray;/** 页面数据 */

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MyTaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的任务";
    self.pageNo = 1;
    self.pageSize = 10;
    self.zuowuName = @"";
    self.modelArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyTaskTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTaskTableViewCell"];
    [self loadData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        self.pageSize = 10;
//        self.zuowuName = @"";
        self.modelArray = [NSMutableArray array];
        [self loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageNo ++;
        [self loadData];
    }];
}
/** 数据请求 */
-(void)loadData{
    [LSNetworkService getMyTaskWithDic:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize),@"zuowumc":self.zuowuName} response:^(id dict, BSError *error) {
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
        self.imageView.image = [UIImage imageNamed:@"暂无任务"];
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
    MyTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTaskTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTaskTableViewCell" owner:nil options:nil] firstObject];
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
    if ([model.zhuangtai integerValue] == 5) {
        cell.shareImageView.image = [UIImage imageNamed:@"未共享"];
    }else if ([model.zhuangtai integerValue] == 10){
        cell.shareImageView.image = [UIImage imageNamed:@"待审核"];
    }else if ([model.zhuangtai integerValue] == 20){
        cell.shareImageView.image = [UIImage imageNamed:@"共享"];
    }else if ([model.zhuangtai integerValue] == 30){
        cell.shareImageView.image = [UIImage imageNamed:@"未通过"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.model = model;
    return cell;
}
/** 数据详情 */
- (void)detaliWithModel:(TaskModel *)model{
    if ([model.zhuangtai integerValue] == 30) {
        TaskMapDataSubmitController *tmdsc = [TaskMapDataSubmitController new];
        tmdsc.type = 1;
        tmdsc.model = model;
        [self.navigationController pushViewController:tmdsc animated:YES];
    }else{
        MyTaskDetailsController *mtdc = [MyTaskDetailsController new];
        mtdc.tkModel = model;
        [self.navigationController pushViewController:mtdc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SearchView *view =  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SearchView class]) owner:nil options:nil] lastObject];
    view.searchaBar.delegate = self;
    UITextField *searchField = [view.searchaBar valueForKey:@"searchField"];
    searchField.text = self.zuowuName;
    searchField.delegate = self;
    return view;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.zuowuName = textField.text;
    [self loadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

/**
 点击cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskModel *model = self.modelArray[indexPath.row];
    if ([model.zhuangtai integerValue] == 30) {
        TaskMapDataSubmitController *tmdsc = [TaskMapDataSubmitController new];
        tmdsc.type = 1;
        tmdsc.model = model;
        [self.navigationController pushViewController:tmdsc animated:YES];
    }else{
        MyTaskDetailsController *mtdc = [MyTaskDetailsController new];
        mtdc.tkModel = model;
        [self.navigationController pushViewController:mtdc animated:YES];
    }
    
}

@end
