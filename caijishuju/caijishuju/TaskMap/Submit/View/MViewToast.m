//
//  MViewToast.m
//  HuaMaster
//
//  Created by M on 2018/6/8.
//

#import "MViewToast.h"

@interface MViewToast()

@property (strong, nonatomic) UIView *showV;

@end

@implementation MViewToast

+ (void)MShowWithText:(NSString *)text {
    MViewToast *mvt = [[MViewToast alloc] initWithMText:text];
    [mvt showToast];
}


- (void)showToast {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.showV.center = CGPointMake(window.center.x, window.center.y + 200);
    self.showV.alpha = 0.0;
    [window addSubview:self.showV];
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.showV.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:2.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              self.showV.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [self.showV removeFromSuperview];
                                          }];
                     }];
}

- (instancetype)initWithMText:(NSString *)str {
    self = [super init];
    if (self) {
        if (str != nil && ![str isEqual:[NSNull null]]) {
            //  显示的lb
            UILabel *messageLb = [[UILabel alloc] init];
            //  行数
            messageLb.numberOfLines = 0;
            //  字体大小
            UIFont *mFont = [UIFont systemFontOfSize:16.0];
            messageLb.font = mFont;
            messageLb.lineBreakMode = NSLineBreakByWordWrapping;
            messageLb.textColor = [UIColor whiteColor];
            messageLb.backgroundColor = [UIColor clearColor];
            messageLb.alpha = 1.0;
            messageLb.textAlignment = NSTextAlignmentCenter;
            messageLb.text = str;
            NSDictionary * dict = [NSDictionary dictionaryWithObject: mFont forKey:NSFontAttributeName];
            CGRect rect = [str boundingRectWithSize:CGSizeMake(200,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
            messageLb.frame = CGRectMake(4, 4, rect.size.width, rect.size.height);
         
            self.showV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, messageLb.frame.size.width + 8, messageLb.frame.size.height + 8)];
            self.showV.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
            self.showV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
            self.showV.layer.cornerRadius = 4;
            [self.showV addSubview:messageLb];
            
        }
    }
    return self;
}

@end
