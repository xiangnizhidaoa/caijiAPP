//
//  MyTaskDetailsFouCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/27.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsFouCell.h"


@interface MyTaskDetailsFouCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *leftV;

@property (weak, nonatomic) IBOutlet UIView *rightV;

@end

@implementation MyTaskDetailsFouCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.leftV.layer.shadowOffset = CGSizeMake(0, 0);
    self.leftV.layer.shadowOpacity = 0.8;
    self.rightV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rightV.layer.shadowOffset = CGSizeMake(0, 0);
    self.rightV.layer.shadowOpacity = 0.8;
    self.detailsTf.delegate = self;
    
    if (self.wordCount==0) {
        self.wordCount = 20;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - text delegate
/**
 限制输入长度
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([toBeString length] > self.wordCount) {
        
        return NO;
    }
    return YES;
}

/**
 return键
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

/**
 编辑完成
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.finishBlock) {
        self.finishBlock(textField.text);
    }
}

@end
