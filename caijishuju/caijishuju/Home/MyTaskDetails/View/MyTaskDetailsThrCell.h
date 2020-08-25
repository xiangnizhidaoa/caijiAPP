//
//  MyTaskDetailsThrCell.h
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskDetailsThrCell : UITableViewCell
/// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/// 详情
@property (weak, nonatomic) IBOutlet UIImageView *detailsIv;
/** <#Note#> */
@property (nonatomic, copy) void (^selectBlock) (void);

@end

NS_ASSUME_NONNULL_END
