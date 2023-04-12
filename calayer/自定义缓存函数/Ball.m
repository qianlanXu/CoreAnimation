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

- (void)animate {
    _ballView.center = CGPointMake(150, 32);
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    CFTimeInterval duration = 1.0;
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = NSMutableArray.array;
    for (int i = 0; i < numFrames; i++) {
        CGFloat time = 1 /  (CGFloat)numFrames * i ;
        time = bounceEaseOut(time);
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    CAKeyframeAnimation *animation = CAKeyframeAnimation.animation;
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
//    animation.values = @[
//        [NSValue valueWithCGPoint:CGPointMake(150, 32)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 140)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 220)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 250)],
//        [NSValue valueWithCGPoint:CGPointMake(150, 268)]
//    ];
//    animation.timingFunctions = @[
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
//    ];
//    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    [_ballView.layer addAnimation:animation forKey:nil];
    _ballView.layer.position = CGPointMake(150, 268);
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
