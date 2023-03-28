//
//  ClockView.m
//  calayer
//
//  Created by xu qianlan on 2023/3/25.
//

#import "ClockView.h"

@interface ClockView ()

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
        [self tick];
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

- (void)layoutSubviews {
    [super layoutSubviews];
    
  
}

- (void)tick {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//公历
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:NSDate.date];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    self.hourHand.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secondAngle);
}
@end
