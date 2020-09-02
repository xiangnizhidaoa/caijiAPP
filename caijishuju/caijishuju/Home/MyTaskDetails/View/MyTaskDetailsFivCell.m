//
//  MyTaskDetailsFivCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/9/2.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsFivCell.h"

@interface MyTaskDetailsFivCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *leftV;
@property (weak, nonatomic) IBOutlet UIView *rightV;

@end

@implementation MyTaskDetailsFivCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.leftV.layer.shadowOffset = CGSizeMake(0, 0);
    self.leftV.layer.shadowOpacity = 0.8;
    self.rightV.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rightV.layer.shadowOffset = CGSizeMake(0, 0);
    self.rightV.layer.shadowOpacity = 0.8;
    self.detailTv.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - textviewDelegate
/**
 限制字数
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([toBeString length] > 200) {

        return NO;
    }
    return YES;
}

/**
 编辑完成
 */
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.finishBlock) {
        self.finishBlock(textView.text);
    }
}

/**
 字数改变
 */
- (void)textViewDidChange:(UITextView *)textView {
    self.hintLb.hidden = textView.text.length==0?NO:YES;
}



@end
