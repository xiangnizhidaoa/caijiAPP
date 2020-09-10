//
//  HHRLaunchViewController.m
//  HHR
//
//  Created by 🍭M on 2017/12/13.
//  Copyright © 2017年 HHR. All rights reserved.
//

#import "HHRLaunchViewController.h"
#import "ZJPageControl.h"
#import "HHRLaunchPageCell.h"


@interface HHRLaunchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *launchCv;

//@property (strong, nonatomic) UICollectionView *launchCv;
/* 图片数组 */
@property (strong, nonatomic) NSArray *imgArray;
/* pageControl */
@property (strong, nonatomic) ZJPageControl *laPageC;
/* 开始体验bt */
@property (strong, nonatomic) UIButton *clickBt;

@end

@implementation HHRLaunchViewController

- (NSArray *)imgArray {
    if (!_imgArray) {
        self.imgArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    }
    return _imgArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatLaunchUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) creatLaunchUI {
    /* collection */
    self.launchCv.dataSource = self;
    self.launchCv.delegate = self;
    self.launchCv.bounces = NO;
//    [self.launchCv registerClass:[HHRLaunchPageCell class] forCellWithReuseIdentifier:@"HHRLaunchPageCell"];
    [self.launchCv registerNib:[UINib nibWithNibName:@"HHRLaunchPageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HHRLaunchPageCell"];
    
    /* pageControl */
    self.laPageC = [[ZJPageControl alloc] init];
    self.laPageC.backgroundColor = [UIColor clearColor];
    self.laPageC.frame = CGRectMake(0, SCREENH_HEIGHT - 80, SCREEN_WIDTH, 30);
    self.laPageC.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:170 / 255.0 alpha:0.6];
    self.laPageC.numberOfPages = self.imgArray.count;
    self.laPageC.currentPage = 0;
    self.laPageC.lineWidth = 1;
    self.laPageC.radius = 4;
    self.laPageC.padding = 6;
    [self.laPageC addTarget:self action:@selector(launchPageChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.laPageC];
    
    /* 开始体验 */
    self.clickBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickBt.frame = CGRectMake((SCREEN_WIDTH-200)/2 , SCREENH_HEIGHT - 140, 200, 40);
    self.clickBt.alpha = 0;
    self.clickBt.hidden = YES;
    self.clickBt.backgroundColor = [UIColor clearColor];
    self.clickBt.layer.masksToBounds = YES;
    self.clickBt.layer.cornerRadius = 4;
    self.clickBt.layer.borderWidth = 1.0;
    self.clickBt.layer.borderColor=[UIColor whiteColor].CGColor;
    [self.clickBt setTitle:@"开始体验" forState:UIControlStateNormal];
    [self.clickBt addTarget:self action:@selector(startRootController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clickBt];
    
}



/// 设置主控制器
- (void)startRootController {
#warning 设置主控制器
    App_Utility.currentUser.isShow = @"1";
    [App_Utility saveCurrentUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.imgArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    //    UINib *nib = [UINib nibWithNibName:@"HHRLaunchPageCell" bundle: [NSBundle mainBundle]];
    //    [collectionView registerNib:nib forCellWithReuseIdentifier:@"HHRLaunchPageCell"];
    HHRLaunchPageCell *cell=[self.launchCv dequeueReusableCellWithReuseIdentifier:@"HHRLaunchPageCell" forIndexPath:indexPath];
    cell.launchIv.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    
    return cell;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
    
}

// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    
    
    if ((scrollView.contentOffset.x/self.view.frame.size.width)==self.imgArray.count-1){
        //        [self performSelector:@selector(btnHidden:) withObject:self.clickBt afterDelay:0.2];
        self.clickBt.hidden = NO;
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.clickBt.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }else if ((scrollView.contentOffset.x/self.view.frame.size.width) > self.imgArray.count-1) {
        
    }else{
        self.clickBt.alpha = 0.0;
        self.clickBt.hidden = YES;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.laPageC setCurrentPage:page animated:YES];
}

#pragma mark - pagaControl
- (void)launchPageChangeValue:(ZJPageControl *)zjpc {
    [self.launchCv layoutIfNeeded];
    [self.launchCv scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:zjpc.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

@end
