//
//  MyTaskDetailsThrCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsThrCell.h"

@interface MyTaskDetailsThrCell ()

@property (weak, nonatomic) IBOutlet UIView *leftBgV;

@property (weak, nonatomic) IBOutlet UIView *rightBgV;

@end

@implementation MyTaskDetailsThrCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftBgV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.leftBgV.layer.shadowOffset = CGSizeMake(0, 0);
    self.leftBgV.layer.shadowOpacity = 0.8;
    self.rightBgV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rightBgV.layer.shadowOffset = CGSizeMake(0, 0);
    self.rightBgV.layer.shadowOpacity = 0.8;
    
    
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
