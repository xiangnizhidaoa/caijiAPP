//
//  TaskViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "TaskViewController.h"
#import <WebKit/WebKit.h>
#import "TaskMapDataSubmitController.h"
#import "NewTaskViewController.h"

@interface TaskViewController ()<WKNavigationDelegate,WKScriptMessageHandler,CLLocationManagerDelegate,TencentLBSLocationManagerDelegate>

@property (nonatomic, strong) WKWebView *wkWV;
/** 进度条 */
@property (nonatomic, strong) UIProgressView *progressV;
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

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务地图";
}

- (void)viewWillAppear:(BOOL)animated{
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
    // 如果需要POI信息的话，根据所需要的级别来设定，定位结果将会根据设定的POI级别来返回，如：
    [self.locationManager setRequestLevel:TencentLBSRequestLevelPoi];
//    [self.locationManager requestLocationWithCompletionBlock:^(TencentLBSLocation *location, NSError *error) {
//
//        if (error) {
//            MLog(@"定位异常\nlocError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            return;
//        }
//
//        self.provinceStr = location.province;
//        self.cityStr = location.city;
//        self.districtStr = location.district;
////        self.nowClCoor2d = CLLocationCoordinate2DMake(location.latitude, location.location);
//        MLog(@"%@, %@, %@", location.location, location.name, location.address);
//
//
//
//    }];
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
    
       [self loadWeb];
        
        [self stopSerialLocation];
}

    -(void)loadWeb{
        self.view.backgroundColor = [UIColor whiteColor];
        self.progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
        self.progressV.progressViewStyle = UIProgressViewStyleDefault;
        self.progressV.trackTintColor = [UIColor colorWithRed:146/255.0 green:156/255.0 blue:159/255.0 alpha:1.0];
        self.progressV.progressTintColor = [UIColor colorWithRed:0 green:153/255.0 blue:1.0 alpha:1.0];
        
        CGFloat nHeight = IPHONE_X?88:64;
        self.wkWV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-nHeight)];
        self.wkWV.navigationDelegate = self;
        self.wkWV.backgroundColor = [UIColor whiteColor];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"https://farmviewer.digitaltest.cn/web/wx/markerfill/appbigmap?isrenwu=true&lat=%f&lng=%f&province=%@&city=%@&district=%@&token=&loginName=&userid=",self.nowClCoor2d.latitude,self.nowClCoor2d.longitude,self.provinceStr,self.cityStr,self.districtStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [self.wkWV loadRequest:request];
        [self.view addSubview:self.wkWV];
        [self.view addSubview:self.progressV];
        
        [self.wkWV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        [self.wkWV.configuration.userContentController addScriptMessageHandler:self name:@"markertask"];
    }

/**
 *  当定位发生错误时，会调用代理的此方法
 *
 *  @param manager 定位 TencentLBSLocationManager 类
 *  @param error 返回的错误，参考 TencentLBSLocationError
 */
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didFailWithError:(NSError *)error {
    
    return;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"markertask"]) {
        NSArray *array = [message.body componentsSeparatedByString:@"#"]; //从字符A中分隔成2个元素的数组
        //这里通过捕获这个先判断是否登录 未登录登录 登录跳转录入数据页面(记得修改下你现在这里是任务地图 不是采集地图).
        //这个请求是判断当前用户是否已经登录
        if ([array[0] boolValue]) {
            [LSNetworkService getIsLoginResponse:^(id dict, BSError *error) {
                if (dict != nil) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                    NSLog(@"%@",dic);
                    if ([dic[@"status"] integerValue] == 1) {
                        //这里处理登录后的逻辑就行
                        NewTaskViewController *tmdsc = [NewTaskViewController new];
                        tmdsc.ID = array[1];
                        [self.navigationController pushViewController:tmdsc animated:YES];
                    }else{
                        // 所有需要弹出登录的时候直接发送通知就好
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
                    }
                }
            }];
        }else{
            [LPUnitily showToastWithText:@"任务未激活"];
        }
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressV.hidden = NO;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//
//    //    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
//    //    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
//    //    //不允许跳转
//    //    //decisionHandler(WKNavigationResponsePolicyCancel);
//}
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//
//
////    NSURL *URL = navigationAction.request.URL;
////    NSString *urlStr = URL.absoluteString;
////    if (![urlStr isEqualToString:kLOGINBINDING]) {
////        [MViewToast MShowWithText:@"提交成功"];
////        [self dismissViewControllerAnimated:YES completion:nil];
////        decisionHandler(WKNavigationActionPolicyCancel);
////    } else {
////        decisionHandler(WKNavigationActionPolicyAllow);
////    }
//
//    //
//    //
//    //    NSLog(@"%@",navigationAction.request.URL.absoluteString);
//    //    //允许跳转
//        decisionHandler(WKNavigationActionPolicyAllow);
//    //    //不允许跳转
//    //    //decisionHandler(WKNavigationActionPolicyCancel);
//}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressV setAlpha:1.0f];
        BOOL animated = self.wkWV.estimatedProgress > self.progressV.progress;
        [self.progressV setProgress:self.wkWV.estimatedProgress animated:animated];
        
        if (self.wkWV.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressV setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressV setProgress:0.0f animated:NO];
                             }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self.wkWV removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
