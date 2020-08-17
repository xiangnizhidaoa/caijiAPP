//
//  CustomPickView.h
//  renminjinfu
//
//  Created by 牛方路 on 2018/7/31.
//  Copyright © 2018年 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPickViewDelegate <NSObject>

-(void)chanel;

-(void)sure;

@end

@interface CustomPickView : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (nonatomic,weak) id <CustomPickViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end
