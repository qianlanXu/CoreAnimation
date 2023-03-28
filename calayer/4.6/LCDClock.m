//
//  LCDClock.m
//  calayer
//
//  Created by xu qianlan on 2023/3/28.
//

#import "LCDClock.h"

@interface LCDClock ()

@property (nonatomic, strong) NSMutableArray *subViews;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LCDClock

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self initViews];
    
    UIImage *digits = [UIImage imageNamed:@"Digits"];
    
    for (UIView *view in _subViews) {
        view.layer.contents = (__bridge id)digits.CGImage;
        // 取图片的十分之一
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        // 内容的拉伸方式，不会生成新的像素
        view.layer.contentsGravity = kCAGravityResizeAspect;
        // 它作用于原图的像素上并根据需要生成新的像素显示在屏幕上。
        // 当图片需要显示不同的大小的时候
        // 对于比较小的图或者是差异特别明显，极少斜线的大图，最近过滤算法会保留这种差异明显的特质以呈现更好的结果。但是对于大多数的图尤其是有很多斜线或是曲线轮廓的图片来说，最近过滤算法会导致更差的结果。换句话说，线性过滤保留了形状，最近过滤则保留了像素的差异。
        // minification（缩小图片）和magnification（放大图片）
        view.layer.magnificationFilter = kCAFilterNearest;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}

- (void)initViews {
    _subViews = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * 30, 100, 30, 60)];
        [self.view addSubview:view];
        [_subViews addObject:view];
    }
}

- (void)setDigit:(NSUInteger)digit forView:(UIView *)view {
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}
- (void)tick {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:NSDate.date];
    
    [self setDigit:components.hour / 10 forView:_subViews[0]];
    [self setDigit:components.hour % 10 forView:_subViews[1]];
    
    [self setDigit:components.minute / 10 forView:_subViews[2]];
    [self setDigit:components.minute % 10 forView:_subViews[3]];
    
    [self setDigit:components.second /  10 forView:_subViews[4]];
    [self setDigit:components.second % 10 forView:_subViews[5]];
    
}
@end
