//
//  ClockView.m
//  calayer
//
//  Created by xu qianlan on 2023/3/25.
//

#import "ClockView.h"

@interface ClockView () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *hourHand;

@property (nonatomic, strong) UIImageView *minuteHand;

@property (nonatomic, strong) UIImageView *secondHand;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.yellowColor;
        self.layer.contents = (__bridge id)[UIImage imageNamed:@"ClockFace"].CGImage;
        [self createUIComponents];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [self updateHandsAnimated:NO];
    }
    return self;
}

- (void)createUIComponents {
    _hourHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HourHand"]];
    _hourHand.contentMode = UIViewContentModeCenter;
    [self addSubview:_hourHand];
    
    _minuteHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MinuteHand"]];
    _minuteHand.contentMode = UIViewContentModeCenter;
    [self addSubview:_minuteHand];
    
    _secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SecondHand"]];
    _secondHand.contentMode = UIViewContentModeCenter;
    [self addSubview:_secondHand];
    
    CGFloat hourW = 60;
    CGFloat hourH = 188;
    CGFloat hourX = (self.bounds.size.width - hourW) * 0.5;
    CGFloat hourY = (self.bounds.size.height - hourH) * 0.5;
    _hourHand.frame = CGRectMake(hourX, hourY, hourW, hourH);
    
    CGFloat minuteW = 40;
    CGFloat minuteH = 212;
    CGFloat minuteX = (self.bounds.size.width - minuteW) * 0.5;
    CGFloat minuteY = (self.bounds.size.height - minuteH) * 0.5;
    _minuteHand.frame = CGRectMake(minuteX, minuteY, minuteW, minuteH);
    
    CGFloat secondW = 16;
    CGFloat secondH = 204;
    CGFloat secondX = (self.bounds.size.width - secondW) * 0.5;
    CGFloat secondY = (self.bounds.size.height - secondH) * 0.5;
    _secondHand.frame = CGRectMake(secondX, secondY, secondW, secondH);
    
    _hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.7f);
    _minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.7f);
    _secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.7f);
    
}

- (void)tick {
    [self updateHandsAnimated:YES];
}

- (void)updateHandsAnimated:(BOOL)animated {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//公历
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:NSDate.date];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    [self setAngle:hourAngle forHand:_hourHand animated:animated];
    [self setAngle:minuteAngle forHand:_minuteHand animated:animated];
    [self setAngle:secondAngle forHand:_secondHand animated:animated];
}


/// 设置指针的角度
/// - Parameters:
///   - angle: 设置的角度
///   - handView: 指针
///   - animated: 是否动态 YES:指针动态地转向新的位置 NO:简单地每秒更新指针的角度来实现一个钟
- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated {
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        // 想更好地控制动画时间，使用显式动画会更好
        CABasicAnimation *animation = CABasicAnimation.animation;
        [self updateHandsAnimated:NO];
        // 给transform的过程增加动画
        animation.keyPath = @"transform"; // 属性
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        [animation setValue:handView forKey:@"handView"]; // 给操作的view加标签
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        handView.layer.transform = transform;
    }
}

#pragma mark - CAAnimationDelegate

// 识别出每个图层停止动画的时间，然后更新它的变换到一个新值
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    // 找出哪个view发生了动画
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}
@end
