//
//  CarTaskManagePhotoDetailsController.m
//  PdaHuaMaster
//
//  Created by M on 2018/11/11.
//  Copyright © 2018年 TDHY. All rights reserved.
//

#import "CarTaskManagePhotoDetailsController.h"
#import "CTMPhotosDetailsCell.h"
#import "UIImageView+WebCache.h"

/** 删除照片 */
NSNotificationName const CTMNDeletePhotoReloadNotification = @"CTMNDeletePhotoReloadNotification";


@interface CarTaskManagePhotoDetailsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *clcV;

/** 当前cell行数 */
@property (nonatomic, assign) NSInteger nowIndex;


@end

@implementation CarTaskManagePhotoDetailsController


- (NSMutableArray *)photosDetailsArr {
    if (!_photosDetailsArr) {
        self.photosDetailsArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _photosDetailsArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setUpNavStyle:2];
    self.navigationItem.title = [NSString stringWithFormat:@"共 %ld 张", self.photosDetailsArr.count];

    if (self.isModification) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"whiteDelete"] style:UIBarButtonItemStyleDone target:self action:@selector(navigationDeleteAction)];
    }
    [self creatDetailPhoto];
    [self addObserver:self forKeyPath:@"nowIndex" options: NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 删除
 */
- (void)navigationDeleteAction {
    
    UIAlertController *pac = [UIAlertController alertControllerWithTitle:nil message:@"确认删除吗" preferredStyle:UIAlertControllerStyleActionSheet];
    [pac addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        MLog(@"删除：%ld",self.cellInd);
//        [[NSNotificationCenter defaultCenter] postNotificationName:CTMNDeletePhotoReloadNotification object:[NSString stringWithFormat:@"%ld",self.cellInd]];
        
        
        if (self.photosDetailsArr.count==1) {
            [self.delegate photosDetailsWithDelete:0];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [self.delegate photosDetailsWithDelete:self.nowIndex];
            [self.photosDetailsArr removeObjectAtIndex:self.nowIndex];
            
            [self.clcV reloadData];
            self.nowIndex--;
        }


    }]];
    [pac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:pac animated:YES completion:nil];

    
}




//  创建
- (void)creatDetailPhoto {
    //布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //根据自己的需求设置宽高
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH, self.view.frame.size.height)];

    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //内边距，列、行间距
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [self.clcV setCollectionViewLayout:flowLayout];


    [self.clcV registerNib:[UINib nibWithNibName:@"CTMPhotosDetailsCell" bundle:nil] forCellWithReuseIdentifier:@"CTMPhotosDetailsCell"];
    [self.clcV layoutIfNeeded];
    CGFloat offsetX = self.cellInd * SCREEN_WIDTH;
    [self.clcV setContentOffset:CGPointMake(offsetX, 0)];
    self.nowIndex = self.cellInd;
}

#pragma mark ----- collection
//  分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}

//
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.photosDetailsArr.count;


}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTMPhotosDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CTMPhotosDetailsCell" forIndexPath:indexPath];
    [cell cellInit:self.view.frame.size.height];
    if (self.isModification) {
        cell.imgV.image = [self.photosDetailsArr objectAtIndex:indexPath.row];
    } else {
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.photosDetailsArr objectAtIndex:indexPath.row]]] placeholderImage:nil];
    }
    self.nowIndex = indexPath.row;
    MLog(@"cell: %ld",self.nowIndex);

    return cell;

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSIndexPath *indPath = [NSIndexPath indexPathForRow:self.cellInd inSection:0];
////    NSIndexPath *index = [NSIndexPath indexPathForRow:self.cellInd inSection:0];
////    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    CTMPhotosDetailsCell *cell = [self.clcV cellForItemAtIndexPath:indPath];
//    [cell minPictureZoom];
    self.nowIndex = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    MLog(@"滚动: %ld",self.nowIndex);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"nowIndex"]) {
//        self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld", [[change valueForKey:@"new"] integerValue]+1, self.photosDetailsArr.count];
        self.navigationItem.title = [NSString stringWithFormat:@"共 %ld 张", self.photosDetailsArr.count];
//        self.cellInd = [[change valueForKey:@"new"] integerValue];
    }
    
}



@end
