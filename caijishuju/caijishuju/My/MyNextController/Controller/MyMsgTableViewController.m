//
//  MyMsgTableViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyMsgTableViewController.h"
#import "MyMsgHeaderTableViewCell.h"
#import "MyMsgTableViewCell.h"

@interface MyMsgTableViewController ()

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation MyMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMsgHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyMsgHeaderTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMsgTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyMsgTableViewCell"];
    self.imageArray = @[@"dianhua",@"email",@"phone2",@"department"];
    self.typeArray = @[@"电话",@"邮箱",@"手机",@"部门"];
    self.title = @"个人信息";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyMsgHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMsgHeaderTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyMsgHeaderTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.nameLable.text = App_Utility.currentUser.userName;
        cell.contentLabel.text = App_Utility.currentUser.roleNames;
        return cell;
    }else{
        MyMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMsgTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyMsgTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.typeImageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        cell.typeLabel.text = self.typeArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.msgLabel.text = App_Utility.currentUser.mobile;
        }else if (indexPath.row == 1){
            cell.msgLabel.text = App_Utility.currentUser.eMail;
        }else if (indexPath.row == 2){
            cell.msgLabel.text = App_Utility.currentUser.phone;
        }else if (indexPath.row == 3){
            cell.msgLabel.text = App_Utility.currentUser.officeName;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110.0;
    }else{
        return 50.0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5.0;
    }else{
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

@end
