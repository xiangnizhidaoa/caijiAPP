//
//  TaskMapDataSubmitController.h
//  caijishuju
//
//  Created by 🍭M on 2020/8/28.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "BSViewController.h"
#import "TaskModel.h"
#import "TaskByModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskMapDataSubmitController : BSViewController

@property (nonatomic, strong) TaskModel *model;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *ID;

@end

NS_ASSUME_NONNULL_END
