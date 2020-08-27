//
//  TaskMapDataSubmitController.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/28.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "TaskMapDataSubmitController.h"
#import "MyTaskDetailsThrCell.h"
#import "MyTaskDetailsHeadCell.h"
#import "MyTaskDetailsFouCell.h"
#import "MyTaskDetailsFootCell.h"

@interface TaskMapDataSubmitController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tabV;

/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TaskMapDataSubmitController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [@[
            @{
                @"type":@"1",
                @"title":@"",
                @"text":@""
            },
            [@{
                @"type":@"2",
                @"title":@"作物名称",
                @"count":[NSNumber numberWithInteger:200],
                @"holder":@"作物名称(自动识别)",
                @"text":@""
            } mutableCopy],
            @{
                @"type":@"3",
                @"title":@"叶子照片",
                @"text":@""
            },
            @{
                @"type":@"3",
                @"title":@"植株照片",
                @"text":@""
            },
            @{
                @"type":@"3",
                @"title":@"地块照片",
                @"text":@""
            },
            [@{
                @"type":@"2",
                @"title":@"备注",
                @"count":[NSNumber numberWithInteger:200],
                @"holder":@"备注(200字)",
                @"text":@""
            } mutableCopy],
            @{
                @"type":@"4",
                @"title":@"",
                @"text":@""
            },
        ] mutableCopy];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据填报";
    
    if (@available(iOS 11.0, *)) {
        self.tabV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tabV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tabV.scrollIndicatorInsets = self.tabV.contentInset;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tabV.rowHeight = UITableViewAutomaticDimension;
    self.tabV.estimatedRowHeight = 30;
    
    

    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsThrCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsThrCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsHeadCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFouCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFouCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFootCell"];
    
    
}

/** 保存 */
- (IBAction)TMDSSaveBtAction:(UIButton *)sender {
    
}

/** 采集地图 */
- (IBAction)TMDSMapBtAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ---- UItableView
/**
 分区
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/**
 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

/**
 头部高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

/**
 尾部高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}



/**
 cell赋值
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *typeStr = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"type"];
    NSString *titleStr = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *detailStr = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    if ([typeStr isEqualToString:@"1"]) {
        MyTaskDetailsHeadCell *cellOne = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsHeadCell" forIndexPath:indexPath];
        return cellOne;
        
        
    } else if ([typeStr isEqualToString:@"2"]) {
        MyTaskDetailsFouCell *cellTwo = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFouCell" forIndexPath:indexPath];
        cellTwo.wordCount = [[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
        cellTwo.detailsTf.placeholder = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"holder"];
        cellTwo.titleLb.text = titleStr;
        cellTwo.finishBlock = ^(NSString * _Nonnull text) {
            [[self.dataArr objectAtIndex:indexPath.row] setObject:[self isNoBlankText:text] forKey:@"text"];
        };
        return cellTwo;
    } else if ([typeStr isEqualToString:@"3"]) {
        MyTaskDetailsThrCell *cellThr = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsThrCell" forIndexPath:indexPath];
        cellThr.titleLb.text = titleStr;
        cellThr.selectBlock = ^{
            
        };
        return cellThr;
   } else if ([typeStr isEqualToString:@"4"]) {
      MyTaskDetailsFootCell *cellFou = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFootCell" forIndexPath:indexPath];
       return cellFou;
  }
    return nil;
}

/**
 点击cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/**
 判断非空
 */
- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/**
 判断字符串是否为空,空返回@""

 @return 空 @""  不为空 text
 */
- (NSString *)isNoBlankText:(NSString *)text {
    if ([self isBlankString:text]) {
        return @"";
    }
    return text;
}



@end
