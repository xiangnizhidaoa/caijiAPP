//
//  BSWebViewController.m
//  PeopleYunXin
//
//  Created by 牛方路 on 2019/11/4.
//  Copyright © 2019 牛方路. All rights reserved.
//

#import "BSWebViewController.h"
#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>

@interface BSWebViewController ()<UIScrollViewDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic,strong) CALayer *progresslayer;

@property (nonatomic, strong) NSString *shareDescription;

@property (nonatomic, strong) NSString *sharePicUrl;

@property (nonatomic, strong) NSString *shareTitle;

@property (nonatomic, strong) NSString *webpageUrl;


@end

@implementation BSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewTitle;
    [self load];
}

-(void)load{
    if (self.type == 0) {
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - (IPHONE_X ? 84 : 64))];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.webUrl]];
        //请求添加自定义header
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        request = [mutableRequest copy];
        self.webView.scrollView.delegate = self;
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }else{
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - (IPHONE_X ? 84 : 64))];
        self.webView.scrollView.bounces = NO;
        [LSNetworkService getHandBookResponse:^(id dict, BSError *error)  {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:dict options:NSJSONReadingMutableLeaves error:nil];
            [self.webView loadHTMLString:dic[@"data"] baseURL:nil];
        }];
        [self.view addSubview:self.webView];
    }
    self.webView.navigationDelegate = self;
    self.progresslayer = [[CALayer alloc]init];
    self.progresslayer.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.1, 2);
    self.progresslayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:self.progresslayer];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}


#pragma mark - 设置右边按钮
-(void)setLeftBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"分享-"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    //     让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    //     修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)share:(UIButton *)sender{
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL

{
    UIImage * result;

    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];

    result = [UIImage imageWithData:data];

    return result;
}

// 监听页面加载进度
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progresslayer.opacity = 1;
        float floatNum = [[change objectForKey:@"new"] floatValue];
        self.progresslayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*floatNum, 2);
        if (floatNum == 1) {
            
            __weak __typeof(self)weakSelf = self;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.progresslayer.opacity = 0;
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
        
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}
@end
