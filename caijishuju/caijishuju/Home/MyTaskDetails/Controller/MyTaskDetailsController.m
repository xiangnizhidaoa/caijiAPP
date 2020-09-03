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
#import "UIImageView+WebCache.h"
#import "MyTaskDetailsFivCell.h"

@interface MyTaskDetailsController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabV;

/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MyTaskDetailsController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.tkModel.zuowumc;
    [self MTDCreateUIInfo];
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
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFivCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFivCell"];
}

/** 保存 */
- (IBAction)MTDSaveBtAction:(UIButton *)sender {
    [self MTDSubmitRequest];
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
        [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:detailStr] placeholderImage:[UIImage imageNamed:@"upload"]];
        cellThr.selectBlock = ^{
            
        };
         return cellThr;
    } else if ([typeStr isEqualToString:@"4"]) {
        MyTaskDetailsHeadCell *cellFou = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsHeadCell" forIndexPath:indexPath];
         return cellFou;
    } else if ([typeStr isEqualToString:@"5"]) {
//       MyTaskDetailsFouCell *cellFiv = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFouCell" forIndexPath:indexPath];
//        cellFiv.wordCount = [[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
//        cellFiv.detailsTf.placeholder = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"holder"];
//        cellFiv.titleLb.text = titleStr;
//        cellFiv.finishBlock = ^(NSString * _Nonnull text) {
//            [[self.dataArr objectAtIndex:indexPath.row] setObject:[self isNoBlankText:text] forKey:@"text"];
//        };
//        return cellFiv;
        MyTaskDetailsFivCell *cellFiv = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFivCell" forIndexPath:indexPath];
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

- (void)MTDCreateUIInfo {
    if (self.tkModel!=nil) {
        NSArray *rstArr = @[
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
                @"text":[NSString stringWithFormat:@"%@%@%@",self.tkModel.province,self.tkModel.city,self.tkModel.district]
            },
            @{
                @"type":@"2",
                @"title":@"填报时间",
                @"text":self.tkModel.createDate
            },
            @{
                @"type":@"2",
                @"title":@"作物名称",
                @"text":self.tkModel.zuowumc
            },
            @{
                @"type":@"2",
                @"title":@"朝向",
                @"text":self.tkModel.chaoxiang
            },
            @{
                @"type":@"2",
                @"title":@"朝向精度",
                @"text":self.tkModel.jingduzhi
            },
            @{
                @"type":@"2",
                @"title":@"填报时间",
                @"text":self.tkModel.createDate
            },
            @{
                @"type":@"2",
                @"title":@"状态",
                @"text":self.tkModel.zhuangtai
            },
            @{
                @"type":@"3",
                @"title":@"叶子照片",
                @"text":self.tkModel.yepianzpid
            },
            @{
                @"type":@"3",
                @"title":@"植株照片",
                @"text":self.tkModel.zhizhuzpid
            },
            @{
                @"type":@"3",
                @"title":@"地块照片",
                @"text":self.tkModel.dikuaizpid
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
        ];
        [self.dataArr addObjectsFromArray:rstArr];
    }
    
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

#pragma mark - 网络请求
- (void)MTDSubmitRequest {
    
    NSString *bodyStr = [NSString stringWithFormat:@"%@?zuowumc=%@􏱻􏱻􏰧􏰧􏱭􏱭&remarks=%@&id=%@&fi lecode=%@&weidu1=%@&jingdu1=%@&weidu=%@&jingdu=%@&weidu2=%@&jingdu2=%@&province=%@&city=%@&district=%@&renwuid=&chaoxiang=146&jingduzhi=high&zhuangtai=5",BS_Url.dataSave,self.tkModel.zuowumc,[[self.dataArr objectAtIndex:12] objectForKey:@"text"],self.tkModel.ID,self.tkModel.filecode,self.tkModel.weidu1,self.tkModel.jingdu1,self.tkModel.weidu,self.tkModel.jingdu,self.tkModel.weidu2,self.tkModel.jingdu2,self.tkModel.province,self.tkModel.city,self.tkModel.district];
    
    [LSNetworkService getDataCollectionSaveWithString:bodyStr response:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                
                UIAlertController *cameraAc = [UIAlertController alertControllerWithTitle:nil message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                [cameraAc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                [self presentViewController:cameraAc animated:YES completion:nil];
                
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
    
    
}






@end
