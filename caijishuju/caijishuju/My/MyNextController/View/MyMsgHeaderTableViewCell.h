//
//  MyMsgHeaderTableViewCell.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyMsgHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

NS_ASSUME_NONNULL_END
