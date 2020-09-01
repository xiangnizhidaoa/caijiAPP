//
//  MyTaskDetailsFivCell.h
//  caijishuju
//
//  Created by 🍭M on 2020/9/2.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskDetailsFivCell : UITableViewCell
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/** 提示 */
@property (weak, nonatomic) IBOutlet UILabel *hintLb;
/** 详情 */
@property (weak, nonatomic) IBOutlet UITextView *detailTv;

/** 编辑完成 */
@property (nonatomic, copy) void (^finishBlock) (NSString *finishText);


@end

NS_ASSUME_NONNULL_END
