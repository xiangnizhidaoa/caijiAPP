//
//  MyTaskDetailsHeadCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/27.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsHeadCell.h"

@interface MyTaskDetailsHeadCell ()

@property (weak, nonatomic) IBOutlet UIView *headV;

@property (weak, nonatomic) IBOutlet UIView *topV;
@property (weak, nonatomic) IBOutlet UIView *leftV;
@property (weak, nonatomic) IBOutlet UIView *rightV;

@end

@implementation MyTaskDetailsHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headV.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    self.headV.layer.shadowOpacity = 0.8;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
    self.headV.layer.shadowOffset = CGSizeMake(0, 0);//设置偏移量
    self.headV.layer.cornerRadius = 4.0;
    self.headV.layer.shadowRadius = 4.0;
     self.leftV.layer.shadowColor = [UIColor blackColor].CGColor;
     self.leftV.layer.shadowOffset = CGSizeMake(0, 0);
     self.leftV.layer.shadowOpacity = 0.8;
     self.rightV.layer.shadowColor = [UIColor blackColor].CGColor;
     self.rightV.layer.shadowOffset = CGSizeMake(0, 0);
     self.rightV.layer.shadowOpacity = 0.8;
    
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
