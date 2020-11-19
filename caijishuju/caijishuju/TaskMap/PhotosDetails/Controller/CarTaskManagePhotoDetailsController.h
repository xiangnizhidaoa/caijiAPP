//
//  CarTaskManagePhotoDetailsController.h
//  PdaHuaMaster
//
//  Created by M on 2018/11/11.
//  Copyright © 2018年 TDHY. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 查看图片页面 */
@class CarTaskManagePhotoDetailsController;
@protocol CTMPhotoDetailsDelegate <NSObject>
//@optional

/**
 删除照片
 */
- (void)photosDetailsWithDelete:(NSInteger)arrInd;

@end

/** 删除照片 */
UIKIT_EXTERN NSNotificationName const CTMNDeletePhotoReloadNotification;

@interface CarTaskManagePhotoDetailsController : UIViewController

/** 图片源 */
@property (nonatomic, strong) NSMutableArray *photosDetailsArr;

/** 是否可编辑  YES 可以删除  */
@property (nonatomic, assign) BOOL isModification;

/** 当前行数 */
@property (nonatomic, assign) NSInteger cellInd;

@property (nonatomic, assign) id <CTMPhotoDetailsDelegate> delegate;

@end
