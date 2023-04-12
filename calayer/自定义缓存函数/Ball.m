//
//  Ball.m
//  calayer
//
//  Created by xu qianlan on 2023/4/11.
//

#import "Ball.h"

@interface Ball () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *ballView;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) NSTimeInterval timeOffset;

@property (nonatomic, assign) NSTimeInterval lastStep;

@property (nonatomic, strong) id fromValue;

@property (nonatomic, strong) id toValue;

@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation Ball

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self animate];
}

- (void)createView {
    self.view.backgroundColor = UIColor.whiteColor;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_containerView];
    
    _ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ball"]];
    [_containerView addSubview:_ballView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self animate];
}

- (void)animate {
    _ballView.center = CGPointMake(150, 32);
    _duration = 1.0;
    _timeOffset = 0.0;
    _fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    _toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    _lastStep = CACurrentMediaTime();
    // stop the timer if it's already running
    [self.timer invalidate];
    // start the timer
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    [_timer addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
    [_timer addToRunLoop:NSRunLoop.mainRunLoop forMode:UITrackingRunLoopMode];
}

- (void)step:(NSTimer *)step {
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - _lastStep;
    _lastStep = thisStep;
    _timeOffset = MIN(_timeOffset + stepDuration, _duration);
    CGFloat time = _timeOffset / _duration;
    time = bounceEaseOut(time);
    id position = [self interpolateFromValue:_fromValue toValue:_toValue time:time];
    _ballView.center = [position CGPointValue];
    // 到时间停止计时器
    if (_timeOffset >= _duration) {
        [_timer invalidate];
        _timer = nil;
    }
    
}
- (CGFloat)interpolate:(CGFloat)from to:(CGFloat)to time:(CGFloat)time {
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(CGFloat)time {
    if ([fromValue isKindOfClass:NSValue.class]) {
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake([self interpolate:from.x to:to.x time:time], [self interpolate:from.y to:to.y time:time]);
            return [NSValue valueWithCGPoint:result];
        }
    }
    return time < 0.5 ? fromValue : toValue;
}

float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}
@end
