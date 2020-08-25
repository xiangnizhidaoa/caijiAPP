//
//  MyTaskDetailsTwoCell.h
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskDetailsTwoCell : UITableViewCell
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/// 详情
@property (weak, nonatomic) IBOutlet UILabel *detailsLb;


@end

NS_ASSUME_NONNULL_END
