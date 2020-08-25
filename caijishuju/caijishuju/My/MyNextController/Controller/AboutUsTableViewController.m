//
//  AboutUsTableViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "AboutUsTableViewController.h"
#import "AboutUsTableViewCell.h"
#import "MyMsgTableViewCell.h"

@interface AboutUsTableViewController ()

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation AboutUsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于程序";
    [self.tableView registerNib:[UINib nibWithNibName:@"AboutUsTableViewCell" bundle:nil] forCellReuseIdentifier:@"AboutUsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMsgTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyMsgTableViewCell"];
    self.imageArray = @[@"使用手册",@"邮箱"];
    self.typeArray = @[@"使用手册",@"邮箱"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutUsTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AboutUsTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.contentLabel.text = @"小程序由中国农业科学院农业资源与农业区划研究所智慧农业团队开发，用于农田地块时空信息抽样、监测，支持ios(iphone\ipad)、Android、windows等系统。小程序主要用于作物（油料作物、粮食作物、经济作物等）时空信息采集、作物长势监测、病虫害信息采集等。小程序面向科研人员、广大农户以及相关领域工作者，便于大家随时随地采集、记录、查看、管理信息。";
        return cell;
    }else{
        MyMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMsgTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyMsgTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.typeImageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        cell.typeLabel.text = self.typeArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.msgLabel.text = @"查看";
        }else if (indexPath.row == 1){
            cell.msgLabel.text = @"agrls@caas.cn";
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        BSWebViewController *webView = [[BSWebViewController alloc] init];
        webView.type = 1;
        webView.viewTitle = @"使用手册";
        [self.navigationController pushViewController:webView animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.tableView.rowHeight = UITableViewAutomaticDimension; // 自适应单元格高度
        self.tableView.estimatedRowHeight = 5000.0f;
        return self.tableView.rowHeight;
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
