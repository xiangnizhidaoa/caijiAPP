//
//  MyTaskTableViewCell.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyTaskTableViewCellDelegate <NSObject>

-(void)detaliWithModel:(TaskModel *)model;

@end

@interface MyTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *weizhi;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;

@property (nonatomic, strong) TaskModel *model;

@property (nonatomic, weak) id <MyTaskTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
