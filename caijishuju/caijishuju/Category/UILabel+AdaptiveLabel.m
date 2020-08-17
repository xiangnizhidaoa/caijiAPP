//
//  UILabel+AdaptiveLabel.m
//  SpecificBusinessCell
//
//  Created by 王帅 on 14-8-19.
//  Copyright (c) 2014年 王帅. All rights reserved.
//

#import "UILabel+AdaptiveLabel.h"

@implementation UILabel (AdaptiveLabel)


- (void)heightAdaptive
{
    self.numberOfLines=0;    
    //设置文本高自适应
    CGRect rect=[self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.size.height);
}

//宽度自适应
- (void)widthAdaptive
{
    //设置文本宽自适应
    CGRect rect=[self.text boundingRectWithSize:CGSizeMake(10000, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, self.frame.size.height);
}




@end
