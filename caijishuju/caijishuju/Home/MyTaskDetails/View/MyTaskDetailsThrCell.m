//
//  MyTaskDetailsThrCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsThrCell.h"

@implementation MyTaskDetailsThrCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)MTDThreeImageBtAction:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock();
    }
}

@end
