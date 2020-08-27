//
//  MyTaskDetailsController.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsController.h"
#import "MyTaskDetailsOneCell.h"
#import "MyTaskDetailsTwoCell.h"
#import "MyTaskDetailsThrCell.h"
#import "MyTaskDetailsHeadCell.h"
#import "MyTaskDetailsFouCell.h"
#import "MyTaskDetailsFootCell.h"

@interface MyTaskDetailsController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabV;

/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MyTaskDetailsController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [@[
            @{
                @"type":@"1",
                @"title":@"",
                @"text":@""
            },
            @{
                @"type":@"4",
                @"title":@"",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"地理位置",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"填报时间",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"作物名称",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"朝向",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"朝向精度",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"填报时间",
                @"text":@""
            },
            @{
                @"type":@"2",
                @"title":@"状态",
                @"text":@""
            },
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
                @"type":@"5",
                @"title":@"备注",
                @"count":[NSNumber numberWithInteger:200],
                @"holder":@"备注(200字)",
                @"text":@""
            } mutableCopy],
            @{
                @"type":@"6",
                @"title":@"",
                @"text":@""
            },
        ] mutableCopy];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小麦";
    
    if (@available(iOS 11.0, *)) {
        self.tabV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tabV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tabV.scrollIndicatorInsets = self.tabV.contentInset;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tabV.rowHeight = UITableViewAutomaticDimension;
    self.tabV.estimatedRowHeight = 30;
    
    
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsOneCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsTwoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsTwoCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsThrCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsThrCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsHeadCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFouCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFouCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFootCell"];
}

/** 保存 */
- (IBAction)MTDSaveBtAction:(UIButton *)sender {
    
}

/** 采集地图 */
- (IBAction)MTDMapBtAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)MTDDetailsBtAction:(UIButton *)sender {
    
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
        MyTaskDetailsOneCell *cellOne = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsOneCell" forIndexPath:indexPath];
        [cellOne MTDTCreateMap];
         return cellOne;
    } else if ([typeStr isEqualToString:@"2"]) {
        MyTaskDetailsTwoCell *cellTwo = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsTwoCell" forIndexPath:indexPath];
        cellTwo.titleLb.text = titleStr;
        cellTwo.detailsLb.text = detailStr;
         return cellTwo;
    } else if ([typeStr isEqualToString:@"3"]) {
        MyTaskDetailsThrCell *cellThr = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsThrCell" forIndexPath:indexPath];
        cellThr.titleLb.text = titleStr;
        cellThr.selectBlock = ^{
            
        };
         return cellThr;
    } else if ([typeStr isEqualToString:@"4"]) {
        MyTaskDetailsHeadCell *cellFou = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsHeadCell" forIndexPath:indexPath];
         return cellFou;
    } else if ([typeStr isEqualToString:@"5"]) {
       MyTaskDetailsFouCell *cellFiv = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFouCell" forIndexPath:indexPath];
        cellFiv.wordCount = [[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
        cellFiv.detailsTf.placeholder = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"holder"];
        cellFiv.titleLb.text = titleStr;
        cellFiv.finishBlock = ^(NSString * _Nonnull text) {
            [[self.dataArr objectAtIndex:indexPath.row] setObject:[self isNoBlankText:text] forKey:@"text"];
        };
        return cellFiv;
   } else if ([typeStr isEqualToString:@"6"]) {
      MyTaskDetailsFootCell *cellSix = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFootCell" forIndexPath:indexPath];
       return cellSix;
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
