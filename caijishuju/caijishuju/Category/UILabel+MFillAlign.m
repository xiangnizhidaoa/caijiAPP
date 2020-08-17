//
//  UILabel+MFillAlign.m
//  NewMaster
//
//  Created by M on 2019/10/15.
//  Copyright © 2019 Hoau. All rights reserved.
//

#import "UILabel+MFillAlign.h"
#import <CoreText/CoreText.h>

@implementation UILabel (MFillAlign)

- (void)MTextAlignmentLeftAndRight {
    

    if(self.text==nil||self.text.length==0) {
        
        return;
        
    }
    
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil];
    
    
    
    CGFloat margin = (self.frame.size.width - textSize.size.width) / (self.text.length - 1);// 每个字符之间，平均的宽度（点坐标）
    
    
    
    NSNumber *number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributeString addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    
    self.attributedText = attributeString;
    
    
}

- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth {
    
    if(self.text==nil||self.text.length==0) {
        
        return;
        
    }
    

    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    NSInteger length = (self.text.length-1);
    
//    NSString* lastStr = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
//
//    if([lastStr isEqualToString:@":"]||[lastStr isEqualToString:@"："]) {
//
//        length = (self.text.length-2);
//
//    }
    
    CGFloat margin = (labelWidth - size.width)/length;
    
    NSNumber*number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString* attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,length)];
    
    self.attributedText= attribute;
    
}





@end
