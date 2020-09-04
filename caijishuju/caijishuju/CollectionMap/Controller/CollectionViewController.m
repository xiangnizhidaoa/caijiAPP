//
//  CollectionViewController.m
//  caijishuju
//
//  Created by 牛方路 on 2020/8/17.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "CollectionViewController.h"
#import <WebKit/WebKit.h>
#import "TaskMapDataSubmitController.h"

@interface CollectionViewController ()<WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWV;
/** 进度条 */
@property (nonatomic, strong) UIProgressView *progressV;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"采集地图";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    self.progressV.progressViewStyle = UIProgressViewStyleDefault;
    self.progressV.trackTintColor = [UIColor colorWithRed:146/255.0 green:156/255.0 blue:159/255.0 alpha:1.0];
    self.progressV.progressTintColor = [UIColor colorWithRed:0 green:153/255.0 blue:1.0 alpha:1.0];
    
    CGFloat nHeight = IPHONE_X?88:64;
    self.wkWV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-nHeight)];
    self.wkWV.navigationDelegate = self;
    self.wkWV.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://farmviewer.digitaltest.cn/web/static/wx/myMap/test.html"]];
    
//    //请求添加自定义header
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    [mutableRequest addValue:App_Utility.currentUser.token forHTTPHeaderField:@"token"];
//    request = [mutableRequest copy];
    [self.wkWV loadRequest:request];
    [self.view addSubview:self.wkWV];
    [self.view addSubview:self.progressV];
    
    [self.wkWV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.wkWV.configuration.userContentController addScriptMessageHandler:self name:@"collectData"];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"collectData"]) {
        //这里通过捕获这个先判断是否登录 未登录登录 登录跳转录入数据页面(记得修改下你现在这里是任务地图 不是采集地图).
        //这个请求是判断当前用户是否已经登录
        [LSNetworkService getIsLoginResponse:^(id dict, BSError *error) {
            if (dict != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",dic);
                if ([dic[@"status"] integerValue] == 1) {
                    //这里处理登录后的逻辑就行
                    //这里处理登录后的逻辑就行
                    TaskMapDataSubmitController *tmdsc = [TaskMapDataSubmitController new];
                    tmdsc.type = 0;
                    [self.navigationController pushViewController:tmdsc animated:YES];
                }else{
                    // 所有需要弹出登录的时候直接发送通知就好
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:self];
                }
            }
        }];
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
