//
//  MyCollectionTableViewCell.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/26.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyCollectionTableViewCellDelegate <NSObject>

-(void)deleatWithTag:(NSInteger)tag;

@end

@interface MyCollectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *weizhi;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;

@property (nonatomic, strong) id <MyCollectionTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
