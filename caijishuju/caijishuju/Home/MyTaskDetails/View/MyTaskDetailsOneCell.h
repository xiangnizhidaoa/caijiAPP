//
//  MyTaskDetailsOneCell.h
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskDetailsOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *rootV;

/** 初始化数据 */
- (void)MTDTCreateMap:(NSString *)jingdu weidu:(NSString *)weidu;

@end

NS_ASSUME_NONNULL_END
