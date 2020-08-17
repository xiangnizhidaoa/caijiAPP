//
//  BSWebViewController.h
//  PeopleYunXin
//
//  Created by 牛方路 on 2019/11/4.
//  Copyright © 2019 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSWebViewController : UIViewController

@property (nonatomic,strong) NSString *webUrl;

@property (nonatomic,strong) NSString *viewTitle;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *ID;

@end

NS_ASSUME_NONNULL_END
