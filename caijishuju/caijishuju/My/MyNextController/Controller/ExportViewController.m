//
//  ExportViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "ExportViewController.h"

@interface ExportViewController ()

@property (weak, nonatomic) IBOutlet UIView *exportView;


@end

@implementation ExportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导出数据";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(export:)];
    [self.exportView addGestureRecognizer:tap];
}

-(void)export:(UITapGestureRecognizer *)tap{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];

    pab.string = @"https://farmviewer.digitaltest.cn/web";

    if (pab == nil) {
        [LPUnitily showToastWithText:@"复制失败"];
        
    } else {
        [LPUnitily showToastWithText:@"已复制访问地址,请打开浏览器进行粘贴访问"];
    }
}




@end
