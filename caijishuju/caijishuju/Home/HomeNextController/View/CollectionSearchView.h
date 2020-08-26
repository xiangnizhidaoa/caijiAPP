//
//  CollectionSearchView.h
//  caijishuju
//
//  Created by 牛方路 on 2020/8/26.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CollectionSearchViewDelegate <NSObject>

-(void)timeView;

@end

@interface CollectionSearchView : UIView

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) id <CollectionSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
