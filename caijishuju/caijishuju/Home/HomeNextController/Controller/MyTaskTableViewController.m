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

@interface MyTaskTableViewController ()<UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, assign) NSInteger pageNo;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) NSString *zuowuName;

@property (nonatomic, strong) NSMutableArray *modelArray;

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
}

-(void)loadData{
    [LSNetworkService getMyTaskWithDic:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize),@"zuowumc":self.zuowuName} response:^(id dict, BSError *error) {
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
    if ([model.zhuangtai integerValue] == 20) {
        cell.shareImageView.image = [UIImage imageNamed:@"共享"];
    }else{
        cell.shareImageView.image = [UIImage imageNamed:@"为共享"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

/**
 点击cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTaskDetailsController *mtdc = [MyTaskDetailsController new];
    [self.navigationController pushViewController:mtdc animated:YES];
}

@end
