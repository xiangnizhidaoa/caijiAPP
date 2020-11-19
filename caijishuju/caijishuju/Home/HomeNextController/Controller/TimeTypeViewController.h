//
//  TimeTypeViewController.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/26.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "BSViewController.h"

NS_ASSUME_NONNULL_BEGIN
/** 搜索选择时间弹窗页面 */
@protocol TimeTypeViewControllerDelegate <NSObject>

-(void)chooseTypeWithTag:(NSInteger)tag;/** 选择时间类型 */

-(void)cancle;/** 取消按钮 */

-(void)sure;/** 确定按钮 */

@end

@interface TimeTypeViewController : BSViewController

@property (weak, nonatomic) IBOutlet UILabel *startTime;

@property (weak, nonatomic) IBOutlet UILabel *toLabel;


@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (nonatomic, strong) id <TimeTypeViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeViewH;


@end

NS_ASSUME_NONNULL_END
