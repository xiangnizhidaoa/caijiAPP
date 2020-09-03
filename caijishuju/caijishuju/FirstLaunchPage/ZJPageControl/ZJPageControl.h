//
//  ZJPageControl.h
//  ZJPageControl
//
//  Created by Evan on 7/9/2017.
//  Copyright © 2017 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface ZJPageControl : UIControl

//@property (nonatomic, assign) IBInspectable CGFloat lineWidth;
//@property (nonatomic, assign) IBInspectable CGFloat radius;
//@property (nonatomic, assign) IBInspectable CGFloat padding;
//
//@property(nonatomic, assign) IBInspectable NSInteger numberOfPages;
//@property(nonatomic, assign) IBInspectable NSInteger currentPage;
//
//@property(nonatomic,strong) IBInspectable UIColor *pageIndicatorTintColor;
//@property(nonatomic,strong) IBInspectable UIColor *currentPageIndicatorTintColor;
//
//@property(nonatomic, assign) IBInspectable BOOL hidesForSinglePage;

@property (nonatomic, assign)  CGFloat lineWidth;
@property (nonatomic, assign)  CGFloat radius;
@property (nonatomic, assign)  CGFloat padding;

@property(nonatomic, assign) NSInteger numberOfPages;
@property(nonatomic, assign) NSInteger currentPage;

@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@property(nonatomic, assign) BOOL hidesForSinglePage;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;

@end
