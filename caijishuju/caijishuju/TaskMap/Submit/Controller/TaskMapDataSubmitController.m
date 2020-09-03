//
//  TaskMapDataSubmitController.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/28.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "TaskMapDataSubmitController.h"
#import "MyTaskDetailsThrCell.h"
#import "MyTaskDetailsHeadCell.h"
#import "MyTaskDetailsFouCell.h"
#import "MyTaskDetailsFootCell.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "MViewToast.h"
#import "MyTaskDetailsFivCell.h"


@interface TaskMapDataSubmitController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tabV;

/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** 定位 */
@property (nonatomic, strong) AMapLocationManager *locationManager;

/** 当前位置 */
@property (nonatomic, assign) CLLocationCoordinate2D nowClCoor2d;

/** 叶子图片 */
@property (nonatomic, strong) UIImage *yeziImg;
/** 植株图片 */
@property (nonatomic, strong) UIImage *zhizhuImg;
/** 地块 */
@property (nonatomic, strong) UIImage *dikuaiImg;
/** 定位管理器 */
@property (nonatomic, strong) CLLocationManager *clManager;
/** 地位权限提示框 */
@property (nonatomic, strong) UIAlertController *clAc;

/** 图片下表 */
@property (nonatomic, assign) NSInteger imgSelect;
/*** 省 ***/
@property (nonatomic, copy) NSString *provinceStr;
/*** 市 ***/
@property (nonatomic, copy) NSString *cityStr;
/*** 区 ***/
@property (nonatomic, copy) NSString *districtStr;



@end

@implementation TaskMapDataSubmitController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [@[
            @{
                @"type":@"1",
                @"title":@"",
                @"text":@""
            },
            [@{
                @"type":@"2",
                @"title":@"作物名称",
                @"count":[NSNumber numberWithInteger:200],
                @"holder":@"作物名称(自动识别)",
                @"text":@""
            } mutableCopy],
            @{
                @"type":@"3",
                @"title":@"叶子照片",
                @"text":@""
            },
            @{
                @"type":@"3",
                @"title":@"植株照片",
                @"text":@""
            },
            @{
                @"type":@"3",
                @"title":@"地块照片",
                @"text":@""
            },
            [@{
                @"type":@"5",
                @"title":@"备注",
                @"count":[NSNumber numberWithInteger:200],
                @"holder":@"备注(200字)",
                @"text":@""
            } mutableCopy],
            @{
                @"type":@"4",
                @"title":@"",
                @"text":@""
            },
        ] mutableCopy];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"数据填报";
    
    if (@available(iOS 11.0, *)) {
        self.tabV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tabV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tabV.scrollIndicatorInsets = self.tabV.contentInset;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tabV.rowHeight = UITableViewAutomaticDimension;
    self.tabV.estimatedRowHeight = 30;

    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsThrCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsThrCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsHeadCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFouCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFouCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFootCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFootCell"];
    [self.tabV registerNib:[UINib nibWithNibName:@"MyTaskDetailsFivCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyTaskDetailsFivCell"];
    
    [self HPSILocationJurisdiction];
    
    
}

/** 保存 */
- (IBAction)TMDSSaveBtAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self TMDSVerifyBody]) {
        [self TMDSSubmitRequest];
    }
}

/** 采集地图 */
- (IBAction)TMDSMapBtAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ---- UItableView
/**
 分区
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/**
 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

/**
 头部高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

/**
 尾部高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}



/**
 cell赋值
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *typeStr = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"type"];
    NSString *titleStr = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *detailStr = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    if ([typeStr isEqualToString:@"1"]) {
        MyTaskDetailsHeadCell *cellOne = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsHeadCell" forIndexPath:indexPath];
        return cellOne;
        
        
    } else if ([typeStr isEqualToString:@"2"]) {
        if (self.type == 0) {
            MyTaskDetailsFouCell *cellTwo = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFouCell" forIndexPath:indexPath];
            cellTwo.wordCount = [[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
            cellTwo.detailsTf.placeholder = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"holder"];
            cellTwo.titleLb.text = titleStr;
            cellTwo.finishBlock = ^(NSString * _Nonnull text) {
                [[self.dataArr objectAtIndex:indexPath.row] setObject:[self isNoBlankText:text] forKey:@"text"];
            };
            return cellTwo;
        }else{
            MyTaskDetailsFouCell *cellTwo = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFouCell" forIndexPath:indexPath];
            cellTwo.wordCount = [[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
            cellTwo.titleLb.text = titleStr;
            cellTwo.detailsTf.text = self.model.zuowumc;
            cellTwo.detailsTf.userInteractionEnabled = NO;
            return cellTwo;
        }
    } else if ([typeStr isEqualToString:@"3"]) {
        if (self.type == 0) {
            MyTaskDetailsThrCell *cellThr = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsThrCell" forIndexPath:indexPath];
            cellThr.titleLb.text = titleStr;
            cellThr.selectBlock = ^{
                self.imgSelect = indexPath.row;
                [self HPSICameraJurisdiction];
                
            };
            
            if (indexPath.row==2) {
                cellThr.detailsIv.image = self.yeziImg;
            } else if (indexPath.row==3) {
                cellThr.detailsIv.image = self.zhizhuImg;
            } else if (indexPath.row==4) {
                cellThr.detailsIv.image = self.dikuaiImg;
            }
            
            return cellThr;
        }else{
            MyTaskDetailsThrCell *cellThr = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsThrCell" forIndexPath:indexPath];
            cellThr.titleLb.text = titleStr;
            if (indexPath.row == 2) {
                [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=s&id=%@",BS_Url.downImage,self.model.yepianzpid]] placeholderImage:[UIImage imageNamed:@"upload"]];
            }else if (indexPath.row == 3){
                [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=s&id=%@",BS_Url.downImage,self.model.zhizhuzpid]] placeholderImage:[UIImage imageNamed:@"upload"]];
            }else if (indexPath.row == 4){
                [cellThr.detailsIv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=s&id=%@",BS_Url.downImage,self.model.dikuaizpid]] placeholderImage:[UIImage imageNamed:@"upload"]];
            }
            cellThr.detailsIv.userInteractionEnabled = NO;
            return cellThr;
        }
   } else if ([typeStr isEqualToString:@"4"]) {
      MyTaskDetailsFootCell *cellFou = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFootCell" forIndexPath:indexPath];
       return cellFou;
   } else if ([typeStr isEqualToString:@"5"]) {
       if (self.type == 0) {
           MyTaskDetailsFivCell *cellFiv = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFivCell" forIndexPath:indexPath];
           cellFiv.finishBlock = ^(NSString * _Nonnull text) {
               [[self.dataArr objectAtIndex:indexPath.row] setObject:[self isNoBlankText:text] forKey:@"text"];
           };
           
           return cellFiv;
       }else{
           MyTaskDetailsFivCell *cellFiv = [self.tabV dequeueReusableCellWithIdentifier:@"MyTaskDetailsFivCell" forIndexPath:indexPath];
           cellFiv.detailTv.text = self.model.remarks;
           cellFiv.hintLb.hidden = YES;
           cellFiv.detailTv.userInteractionEnabled = NO;
           
           return cellFiv;
       }
       
   }
    return nil;
}

/**
 点击cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/**
 判断非空
 */
- (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/**
 判断字符串是否为空,空返回@""

 @return 空 @""  不为空 text
 */
- (NSString *)isNoBlankText:(NSString *)text {
    if ([self isBlankString:text]) {
        return @"";
    }
    return text;
}

#pragma mark - 定位

/**
 定位权限
 */
- (void)HPSILocationJurisdiction {
    self.clManager = [[CLLocationManager alloc] init];
    [self.clManager requestAlwaysAuthorization];//一直获取定位信息
    [self.clManager requestWhenInUseAuthorization];//使用的时候获取定位信息
    self.clManager.delegate = self;
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
        if (locationStatus==kCLAuthorizationStatusNotDetermined) {
            /** 没有选择 */
            MLog(@"没有选择");
            
        } else if ((locationStatus==kCLAuthorizationStatusRestricted)||(locationStatus==kCLAuthorizationStatusDenied)) {
            /** 限制&拒绝 */
            MLog(@"拒绝");
            self.clAc = [UIAlertController alertControllerWithTitle:@"请允许定位服务" message:@"去手机系统\"设置-隐私-定位服务\"开启一下吧" preferredStyle:UIAlertControllerStyleAlert];
            [self.clAc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:self.clAc animated:YES completion:nil];
            
        } else if ((locationStatus==kCLAuthorizationStatusAuthorizedAlways)||(locationStatus==kCLAuthorizationStatusAuthorizedWhenInUse)) {
            /** 始终允许&仅在使用期间 */
            MLog(@"授权");
            [self isHomeGetMyLocation];
        }
    } else {
        [MViewToast MShowWithText:@"暂不支持定位"];
        
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status==kCLAuthorizationStatusNotDetermined) {
        /** 没有选择 */
        MLog(@"======没有选择");
        
    } else if ((status==kCLAuthorizationStatusRestricted)||(status==kCLAuthorizationStatusDenied)) {
        /** 限制&拒绝 */
        MLog(@"========拒绝");
        self.clAc = [UIAlertController alertControllerWithTitle:@"请允许定位服务" message:@"去手机系统\"设置-隐私-定位服务\"开启一下吧" preferredStyle:UIAlertControllerStyleAlert];
        [self.clAc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:self.clAc animated:YES completion:nil];
    } else if ((status==kCLAuthorizationStatusAuthorizedAlways)||(status==kCLAuthorizationStatusAuthorizedWhenInUse)) {
        /** 始终允许&仅在使用期间 */
        MLog(@"=========授权");
        [self isHomeGetMyLocation];
    }
    
}


/**
 获取定位
 */
- (void)isHomeGetMyLocation {
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =5;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout =5;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            MLog(@"定位异常\nlocError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed) {
                return;
            }
        }
        
        MLog(@"location:%@\n%f,%f", location,location.coordinate.longitude,location.coordinate.latitude);
        /** 经纬度 */
        CLLocationCoordinate2D gcj02Coord = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        self.nowClCoor2d = gcj02Coord;
        if (regeocode) {
            MLog(@"reGeocode:%@", regeocode);
            self.provinceStr = regeocode.province;
            self.cityStr = regeocode.city;
            self.districtStr = regeocode.district;
        }
        
        
    }];
}

/**
 相机权限
 */
- (void)HPSICameraJurisdiction {
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        
        AVAuthorizationStatus authstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authstatus == AVAuthorizationStatusNotDetermined) {
            /** 未确定 */
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        MLog(@"相机授权");
                            /** 拍照 */
                        [self HPSICreateCamera];
                        
                    }else{

                        [MViewToast MShowWithText:@"未开启相机权限,无法提供拍照功能"];
                        
                    }
                });
              
            }];
            
        } else if (authstatus == AVAuthorizationStatusDenied || authstatus == AVAuthorizationStatusRestricted) {
            /** 拒绝 */
            UIAlertController *cameraAc = [UIAlertController alertControllerWithTitle:@"请允许访问相机" message:@"去手机系统\"设置-隐私-相机\"开启一下吧" preferredStyle:UIAlertControllerStyleAlert];
            [cameraAc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:cameraAc animated:YES completion:nil];
        } else if (authstatus == AVAuthorizationStatusAuthorized) {
            /** 授权 */
                /** 拍照 */
            [self HPSICreateCamera];
            
            
        }
        
    } else {
        
        UIAlertController *cameraAc = [UIAlertController alertControllerWithTitle:@"当前设备不支持相机" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [cameraAc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:cameraAc animated:YES completion:nil];
    }
    
}

/**
 拍照
 */
- (void)HPSICreateCamera {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [picker.navigationBar setBarTintColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1]];
//    [picker.navigationBar setTranslucent:NO];
//    picker.navigationBar.tintColor = [UIColor whiteColor];
//    [picker.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    [self presentViewController:picker animated:YES completion:nil];
}

/**
 编辑成功之后
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
//    // 获取原始图片
    UIImage * originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    // 获取编辑图片
//    UIImage * editImage = [info objectForKey:UIImagePickerControllerEditedImage];
//
//    NSData *imgData = UIImageJPEGRepresentation(editImage, 0.2f);
//    [self HPSISaveImageToPhotoAlbum:editImage];
//    self.signInIv.image = editImage;
//
//    self.siModel.imgData = imgData;
    if (self.imgSelect==2) {
        self.yeziImg = originalImage;
        NSData *imgData = UIImageJPEGRepresentation(originalImage, 0.2f);
        NSDictionary *dic = @{@"code_id":@"4355549-d04f-40e0-afb7-bbb1faf",@"column":@"yepian",@"isreplace":@"1",@"filePath":imgData};
        [self loadImageWithDic:dic];
        
    } else if (self.imgSelect==3) {
        self.zhizhuImg = originalImage;
        NSData *imgData = UIImageJPEGRepresentation(originalImage, 0.2f);
        NSDictionary *dic = @{@"code_id":@"4355549-d04f-40e0-afb7-bbb1faf",@"column":@"zhizhu",@"isreplace":@"1",@"filePath":imgData};
        [self loadImageWithDic:dic];
    } else if (self.imgSelect==4) {
        self.dikuaiImg = originalImage;
        NSData *imgData = UIImageJPEGRepresentation(originalImage, 0.2f);
        NSDictionary *dic = @{@"code_id":@"4355549-d04f-40e0-afb7-bbb1faf",@"column":@"dikuai",@"isreplace":@"1",@"filePath":imgData};
        [self loadImageWithDic:dic];
    }
    [self.tabV reloadData];
    // 将模态显示的视图控制器消失
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

//上传图片
-(void)loadImageWithDic:(NSDictionary *)dic{
    [LSNetworkService postUpLoadImageWithDic:dic response:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dicc = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dicc);
            if (dicc != nil) {
                if ([dic[@"column"] isEqualToString:@"yepian"]) {
                    [LSNetworkService getZhiwuImageWithDic:@{@"fileid":dicc[@"id"]} response:^(id dict, BSError *error) {
                        if (dict != nil) {
                            NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                            NSLog(@"%@",dic1);
                            if ([dic1[@"status"] integerValue] == 1) {
                                
                            }else{
                                [LPUnitily showToastWithText:dic1[@"message"]];
                            }
                        }
                    }];
                }
            }else{
                [LPUnitily showToastWithText:dicc[@"message"]];
            }
        }
    }];
}


/**
 取消拍照
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


/// 校验提交参数
- (BOOL)TMDSVerifyBody {
    if ([[[self.dataArr objectAtIndex:1] objectForKey:@"text"] length]==0) {
        [MViewToast MShowWithText:@"请填写作物名称"];
        return NO;
    }
    if (self.yeziImg==nil) {
        [MViewToast MShowWithText:@"请添加叶子照片"];
        return NO;
    }
    if (self.zhizhuImg==nil) {
        [MViewToast MShowWithText:@"请添加植株照片"];
        return NO;
    }
    if (self.dikuaiImg==nil) {
        [MViewToast MShowWithText:@"请添加地块照片"];
        return NO;
    }
    return YES;
}


/// 保存
- (void)TMDSSubmitRequest {
    
    NSString *bodyStr = [NSString stringWithFormat:@"%@?zuowumc=%@􏱻􏱻􏰧􏰧􏱭􏱭&remarks=%@&id=f774f06d434d4e549da35de897196559&fi lecode=a8894ed2-48a4-d549-8680-9ca6fba5bba0&weidu1=&jingdu1=& weidu=0&jingdu=0&weidu2=%f&jingdu2=%f&province=%@&city=%@&distric t=%@&renwuid=&chaoxiang=146&jingduzhi=high&zhuangtai=5",BS_Url.dataSave,[[self.dataArr objectAtIndex:1] objectForKey:@"text"],[[self.dataArr objectAtIndex:5] objectForKey:@"text"],self.nowClCoor2d.latitude,self.nowClCoor2d.longitude,self.provinceStr,self.cityStr,self.districtStr   ];
    
    [LSNetworkService getDataCollectionSaveWithString:bodyStr response:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                
                UIAlertController *cameraAc = [UIAlertController alertControllerWithTitle:nil message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                [cameraAc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                [self presentViewController:cameraAc animated:YES completion:nil];
                
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
    
}



@end
