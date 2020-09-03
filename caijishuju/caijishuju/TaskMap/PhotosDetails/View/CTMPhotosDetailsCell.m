//
//  CTMPhotosDetailsCell.m
//  PdaHuaMaster
//
//  Created by M on 2018/11/19.
//  Copyright © 2018年 TDHY. All rights reserved.
//

#import "CTMPhotosDetailsCell.h"

@interface CTMPhotosDetailsCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrV;

@end

@implementation CTMPhotosDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)cellInit:(CGFloat)navHeigh {

    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeigh)];
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    self.imgV.userInteractionEnabled = YES;
    self.imgV.backgroundColor = [UIColor blackColor];

    self.scrV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeigh)];
    self.scrV.minimumZoomScale = 1.0;
    self.scrV.maximumZoomScale = 3.0;
    self.scrV.delegate = self;
    self.scrV.backgroundColor = [UIColor blackColor];
    [self.scrV addSubview:self.imgV];
    [self addSubview:self.scrV];
    
    /** 双击 放大或缩小 */
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
}


- (void)tapImageAction {
    if (self.imgV.frame.size.width>self.frame.size.width) {
        [self minPictureZoom];
    } else {
        [self maxPictureZoom];
    }
}


/**
 3倍放大
 */
- (void)maxPictureZoom {

    CGFloat imageWidth = 3.0 * self.imgV.image.size.width;
    CGFloat imageHeight = 3.0 * self.imgV.image.size.height;
    self.scrV.contentSize = CGSizeMake( imageWidth, imageHeight);
    self.imgV.frame = CGRectMake(0, 0, imageWidth, imageHeight);
    
}


/**
 1倍复原
 */
- (void)minPictureZoom {
    self.scrV.contentSize = CGSizeMake( self.frame.size.width, self.frame.size.height);
    self.imgV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


#pragma mark -- UIScrollViewDelegate

//返回需要缩放的视图控件 缩放过程中
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgV;
}

//开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    MLog(@"开始缩放");

}
//结束缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    MLog(@"结束缩放");

}

// 缩放中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
 

    CGFloat imageWidth = scrollView.zoomScale * self.imgV.image.size.width;
    CGFloat imageHeight = scrollView.zoomScale * self.imgV.image.size.height;
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    if (self.frame.size.width>imageWidth) {
        imageX = ((self.frame.size.width - imageWidth)/2.0);
    } else {
        imageX = 0;
    }
    
    if (self.frame.size.height>imageHeight) {
        imageY = ((self.frame.size.height - imageHeight)/2.0);
    } else {
        imageY = 0;
    }
    
    
    if (scrollView.zoomScale==1.0||scrollView.zoomScale<1.0) {

        [self minPictureZoom];
    } else {

        self.imgV.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    }

}

@end
