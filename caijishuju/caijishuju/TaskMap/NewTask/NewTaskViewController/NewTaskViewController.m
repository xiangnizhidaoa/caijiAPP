//
//  NewTaskViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/9/8.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "NewTaskViewController.h"
#import "TaskMapDataSubmitController.h"

@interface NewTaskViewController ()<CLLocationManagerDelegate,TencentLBSLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *marker;

@property (weak, nonatomic) IBOutlet UILabel *statues;

@property (nonatomic, strong) NSString *zhuangtai;

@property (nonatomic, strong) NSString *taskID;

@property (nonatomic, strong) NSString *weidu;

@property (nonatomic, strong) NSString *jingdu;
/** 朝向 */
@property (nonatomic, strong) NSString *chaoxiang;
/** 省 */
@property (nonatomic, copy) NSString *provinceStr;
/** 市 */
@property (nonatomic, copy) NSString *cityStr;
/** 区 */
@property (nonatomic, copy) NSString *districtStr;
/** 当前位置 */
@property (nonatomic, assign) CLLocationCoordinate2D nowClCoor2d;
/** 定位管理器 */
@property (nonatomic, strong) CLLocationManager *clManager;
/** 地位权限提示框 */
@property (nonatomic, strong) UIAlertController *clAc;
/** 腾讯定位 */
@property (nonatomic, strong) TencentLBSLocationManager *locationManager;

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

-(void)loadData{
    [LSNetworkService getTaskStatuseWithID:self.ID response:^(id dict, BSError *error) {
        if (dict != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dic);
            if ([dic[@"status"] integerValue] == 1) {
                self.name.text = dic[@"dataValue"][@"markertask"][@"name"];
                self.marker.text = dic[@"dataValue"][@"markertask"][@"remarks"];
                self.zhuangtai = dic[@"dataValue"][@"markertask"][@"zhuangtai"];
                self.taskID = dic[@"dataValue"][@"markertask"][@"id"];
                self.weidu = dic[@"dataValue"][@"markertask"][@"weidu1"];
                self.jingdu = dic[@"dataValue"][@"markertask"][@"jingdu1"];
                switch ([dic[@"dataValue"][@"markertask"][@"zhuangtai"] integerValue]) {
                    case 10:
                    self.statues.text = @"进行中";
                    break;
                    case 20:
                    self.statues.text = @"完成";
                    break;
                        
                    default:
                        break;
                }
            }else{
                [LPUnitily showToastWithText:dic[@"message"]];
            }
        }
    }];
}

- (IBAction)upLoad:(UIButton *)sender {
    if ([self.zhuangtai integerValue] == 10) {
        CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(self.nowClCoor2d.latitude,self.nowClCoor2d.longitude);
        // 腾讯北京总部大楼
        CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake([self.weidu doubleValue], [self.jingdu doubleValue]);
        CLLocationDistance distance = QMetersBetweenCoordinates(coord1, coord2);
        if (distance <= 5.0 ) {
            TaskMapDataSubmitController *tmdsc = [TaskMapDataSubmitController new];
            tmdsc.type = 0;
            tmdsc.ID = self.taskID;
            [self.navigationController pushViewController:tmdsc animated:YES];
        }else{
            [LPUnitily showToastWithText:@"当前任务位置5米范围内才可上报"];
        }
    }
}

- (IBAction)taskMap:(UIButton *)sender {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self HPSILocationJurisdiction];
}

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
        [LPUnitily showToastWithText:@"暂不支持定位"];
        
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
    
    self.locationManager = [[TencentLBSLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setApiKey:@"F7ABZ-EKRWW-MEGR4-RIYHI-GQHIH-7CFHU"];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setRequestLevel:TencentLBSRequestLevelPoi];
    [self startSerialLocation];
    
}

// 连续定位
- (void)startSerialLocation {
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation {
    //停止定位
    [self.locationManager stopUpdatingLocation];
}
 
/**
 *  定位朝向改变时回调函数
 *
 *  @param manager 定位 TencentLBSLocationManager 类
 *  @param newHeading  新的定位朝向
 */
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    self.chaoxiang = [NSString stringWithFormat:@"%@",newHeading];
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                didUpdateLocation:(TencentLBSLocation *)location {
    //定位结果
    self.provinceStr = location.province;
    self.cityStr = location.city;
    self.districtStr = location.district;
    TencentLBSPoi *tlbs = location.poiList.firstObject;
    self.nowClCoor2d = CLLocationCoordinate2DMake(tlbs.latitude, tlbs.longitude);
    [self stopSerialLocation];
}



@end
