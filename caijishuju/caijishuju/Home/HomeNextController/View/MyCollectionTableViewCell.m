//
//  MyCollectionTableViewCell.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/26.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyCollectionTableViewCell.h"

@implementation MyCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleat:(UIButton *)sender {
    [self.delegate deleatWithTag:self.tag];
}

- (IBAction)detail:(UIButton *)sender {
    [self.delegate detailWithTag:self.tag];
}



@end
