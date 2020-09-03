//
//  CTMPhotosDetailsCell.h
//  PdaHuaMaster
//
//  Created by M on 2018/11/19.
//  Copyright © 2018年 TDHY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTMPhotosDetailsCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgV;

- (void)cellInit:(CGFloat)navHeigh;

/**
 1倍复原
 */
- (void)minPictureZoom;



@end
