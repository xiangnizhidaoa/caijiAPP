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
#import "CarTaskManagePhotoDetailsController.h"

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
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionMap" object:self];
//    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController popToRootViewControllerAnimated:YES];
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
//        [cellOne MTDTCreateMap];
        [cellOne MTDTCreateMap:self.tkModel.jingdu2 weidu:self.tkModel.weidu2];
         return cellOne;
    } else if ([typeStr isEqualToString:@"2"]) {
        MyTaskDetailsTwoCell *cellTwo = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsTwoCell" forIndexPath:indexPath];
        cellTwo.titleLb.text = titleStr;
        
        if (indexPath.row == 5) {
            cellTwo.detailsLb.text = [NSString stringWithFormat:@"%@%ld",[self huoquchaoxiangWithFloat:[detailStr doubleValue]],[detailStr integerValue]];
        }else if (indexPath.row == 6){
            cellTwo.detailsLb.text = detailStr.length != 0 ? @"高":@"";
        }else if (indexPath.row == 8){
            if ([detailStr integerValue] == 5) {
                cellTwo.detailsLb.text = @"未共享";
            }else if ([detailStr integerValue] == 10){
                cellTwo.detailsLb.text = @"待审核";
            }else if ([detailStr integerValue] == 20){
                cellTwo.detailsLb.text = @"共享";
            }else if ([detailStr integerValue] == 30){
                cellTwo.detailsLb.text = @"未通过";
            }
        }else{
            cellTwo.detailsLb.text = detailStr;
        }
         return cellTwo;
    } else if ([typeStr isEqualToString:@"3"]) {
        MyTaskDetailsThrCell *cellThr = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsThrCell" forIndexPath:indexPath];
        cellThr.titleLb.text = titleStr;
        [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:detailStr] placeholderImage:[UIImage imageNamed:@"upload"]];
        cellThr.selectBlock = ^{
            [self loadImageViewCellIndex:indexPath.row];
        };
        if (indexPath.row == 9) {
            [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=s&id=%@",BS_Url.downImage,self.tkModel.yepianzpid]] placeholderImage:[UIImage imageNamed:@"upload"]];
        }else if (indexPath.row == 10){
            [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=s&id=%@",BS_Url.downImage,self.tkModel.zhizhuzpid]] placeholderImage:[UIImage imageNamed:@"upload"]];
        }else if (indexPath.row == 11){
            [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=s&id=%@",BS_Url.downImage,self.tkModel.dikuaizpid]] placeholderImage:[UIImage imageNamed:@"upload"]];
        }
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
        [[self.dataArr objectAtIndex:indexPath.row] setObject:self.tkModel.remarks forKey:@"text"];
        cellFiv.detailTv.text = self.tkModel.remarks;
        cellFiv.hintLb.hidden = YES;
        return cellFiv;
   } else if ([typeStr isEqualToString:@"6"]) {
      MyTaskDetailsFootCell *cellSix = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFootCell" forIndexPath:indexPath];
       return cellSix;
  }
    return nil;
}

-(void)loadImageViewCellIndex:(NSInteger)row{
    CarTaskManagePhotoDetailsController *ctmpdc = [CarTaskManagePhotoDetailsController new];
    ctmpdc.isModification = NO;
    ctmpdc.cellInd = 0;
    if (row == 9) {
        [ctmpdc.photosDetailsArr addObject:self.tkModel.yepianzpid];
    }else if (row == 10){
        [ctmpdc.photosDetailsArr addObject:self.tkModel.zhizhuzpid];
    }else if (row == 11){
        [ctmpdc.photosDetailsArr addObject:self.tkModel.dikuaizpid];
    }
    [self.navigationController pushViewController:ctmpdc animated:YES];
}

/**
 点击cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(NSString *)huoquchaoxiangWithFloat:(CGFloat)chaoxiang{
    if ((chaoxiang <= 22.5 && chaoxiang >= 0) || (chaoxiang > 337.5 && chaoxiang <= 360)) {
        return @"北";
    }else if (chaoxiang > 22.5 && chaoxiang <= 67.5){
        return @"东北";
    }else if (chaoxiang > 67.5 && chaoxiang <= 112.5){
        return @"东";
    }else if (chaoxiang > 112.5 && chaoxiang <= 157.5){
        return @"东南";
    }else if (chaoxiang > 157.5 && chaoxiang <= 202.5){
        return @"南";
    }else if (chaoxiang > 202.5 && chaoxiang <= 247.5){
        return @"西南";
    }else if (chaoxiang > 247.5 && chaoxiang <= 292.5){
        return @"西";
    }else if (chaoxiang > 292.5 && chaoxiang <= 337.5){
        return @"西北";
    }else{
        return @"";
    }
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
    
    NSDictionary *bodyDic = @{@"zuowumc":self.tkModel.zuowumc,
                              @"remarks":[[self.dataArr objectAtIndex:12] objectForKey:@"text"],
                              @"filecode":self.tkModel.filecode,
                              @"weidu1":self.tkModel.weidu1,
                              @"jingdu1":self.tkModel.jingdu1,
                              @"weidu":self.tkModel.weidu,
                              @"jingdu":self.tkModel.jingdu,
                              @"weidu2":self.tkModel.weidu2,
                              @"jingdu2":self.tkModel.jingdu2,
                              @"province":self.tkModel.province,
                              @"city":self.tkModel.city,
                              @"district":self.tkModel.district,
                              @"chaoxiang":self.tkModel.chaoxiang,
                              @"jingduzhi":self.tkModel.jingduzhi,
                              @"zhuangtai":self.tkModel.zhuangtai,
                              @"id":self.tkModel.ID
    };
    
    [LSNetworkService getDataCollectionSaveWithString:bodyDic response:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = dict;
            if ([dic[@"status"] integerValue] == 1) {
                [LPUnitily showToastWithText:@"保存成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
    
}






@end
