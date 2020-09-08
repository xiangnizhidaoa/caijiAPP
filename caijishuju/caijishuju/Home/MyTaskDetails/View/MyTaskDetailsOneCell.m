//
//  MyTaskDetailsOneCell.m
//  caijishuju
//
//  Created by 🍭M on 2020/8/25.
//  Copyright © 2020 牛方路. All rights reserved.
//

#import "MyTaskDetailsOneCell.h"
#import <QMapKit/QMapKit.h>

//#import <MAMapKit/MAMapKit.h>
//#import <AMapFoundationKit/AMapFoundationKit.h>

@interface MyTaskDetailsOneCell ()<QMapViewDelegate>

///** 高德地图 */
//@property (nonatomic, strong) MAMapView *mapView;
/** 腾讯地图 */
@property (nonatomic, strong) QMapView *mapView;
@end

@implementation MyTaskDetailsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/** 初始化数据 */
- (void)MTDTCreateMap:(NSString *)jingdu weidu:(NSString *)weidu {
    self.mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    //接受地图的delegate回调
    self.mapView.delegate = self;
    //把mapView添加到view中进行显示
    [self.contentView addSubview:self.mapView];
    
    QPointAnnotation *pointAnnotation = [[QPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([weidu doubleValue], [jingdu doubleValue]);
//    // 点标注的标题
//    pointAnnotation.title = @"腾讯";
//    // 副标题
//    pointAnnotation.subtitle = @"腾讯北京总部";

    // 将点标记添加到地图中
    
    [self.mapView selectAnnotation:pointAnnotation animated:YES];
    [self.mapView addAnnotation:pointAnnotation];
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation {
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString *annotationIdentifier = @"pointAnnotation";
        QPinAnnotationView *pinView = (QPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (pinView == nil) {
            pinView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            pinView.canShowCallout = YES;
        }
        
        return pinView;
    }
    
    return nil;
}

@end
