//
//  MyTaskDetailsFouCell.h
//  caijishuju
//
//  Created by 🍭M on 2020/8/27.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskDetailsFouCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UITextField *detailsTf;

/** 限制字数 */
@property (nonatomic, assign) NSInteger wordCount;

/** 编辑完成 */
@property (nonatomic, copy) void (^finishBlock) (NSString *text);

@end

NS_ASSUME_NONNULL_END
