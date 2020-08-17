//
//  PhotoViewController.h
//  Investigation
//
//  Created by 牛方路 on 2018/9/11.
//  Copyright © 2018年 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FileListModel.h"

@interface PhotoViewController : UIViewController

@property (nonatomic,strong) NSArray *imageArray;//需要展示图片的数组

@property (nonatomic,strong) NSArray *invImageArray;//需要展示图片的数组

@property (nonatomic,assign) NSInteger locationView;//当前scrollView显示初始位置

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) NSInteger viewType;

@end
