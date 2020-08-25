//
//  MyTaskTableViewCell.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *weizhi;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;



@end

NS_ASSUME_NONNULL_END
