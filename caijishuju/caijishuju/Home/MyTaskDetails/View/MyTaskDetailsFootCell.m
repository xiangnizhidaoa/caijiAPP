//
//  MyTaskDetailsFootCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/27.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsFootCell.h"

@interface MyTaskDetailsFootCell ()

@property (weak, nonatomic) IBOutlet UIView *bgV;

@property (weak, nonatomic) IBOutlet UIView *topV;


@end

@implementation MyTaskDetailsFootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgV.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    self.bgV.layer.shadowOpacity = 0.8;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
    self.bgV.layer.shadowOffset = CGSizeMake(0, 0);//设置偏移量
    self.bgV.layer.cornerRadius = 4.0;
    self.bgV.layer.shadowRadius = 4.0;
    self.topV.layer.cornerRadius = 4.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
