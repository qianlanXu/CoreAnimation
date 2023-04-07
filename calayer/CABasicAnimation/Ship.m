//
//  Ship.m
//  calayer
//
//  Created by xu qianlan on 2023/4/3.
//

#import "Ship.h"

@interface Ship () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) CALayer *shipLayer;

@property (nonatomic, strong) UIButton *start;

@property (nonatomic, strong) UIButton *stop;

@end

@implementation Ship

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _containerView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_containerView];
    
    CAShapeLayer *shapeLayer = CAShapeLayer.layer;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.strokeColor = UIColor.greenColor.CGColor;
    shapeLayer.lineWidth = 3.0;
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint:CGPointMake(0, 150)];
    [path addCurveToPoint:CGPointMake(150, 300) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(230, 300)];
    shapeLayer.path = path.CGPath;
    [_containerView.layer addSublayer:shapeLayer];
    
    _shipLayer = CALayer.layer;
    _shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    _shipLayer.frame = CGRectMake(0, 0, 64, 64);
    _shipLayer.position = CGPointMake(0, 150);
        
//    CABasicAnimation *animation2 = CABasicAnimation.animation;
//    animation2.keyPath = @"transform";
//    animation2.duration = 2.0;
//    animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0, 0, 1)];
//    [_shipLayer addAnimation:animation2 forKey:nil];
//
//    CAKeyframeAnimation *animation = CAKeyframeAnimation.animation;
//    // 属性
//    animation.keyPath = @"position";
//    animation.path = shapeLayer.path;
//    animation.duration = 5.0;
//    // 图层将会根据曲线的切线自动旋转
//    animation.rotationMode = kCAAnimationRotateAuto;
//
//    [_shipLayer addAnimation:animation forKey:nil];
    [_containerView.layer addSublayer:_shipLayer];
    
    _start = [UIButton buttonWithType:UIButtonTypeCustom];
    _start.frame = CGRectMake(100, 600, 50, 50);
    _start.backgroundColor = UIColor.orangeColor;
    [_start setTitle:@"start" forState:UIControlStateNormal];
    [_start addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_start];
    
    _stop = [UIButton buttonWithType:UIButtonTypeCustom];
    _stop.frame = CGRectMake(300, 600, 50, 50);
    _stop.backgroundColor = UIColor.greenColor;
    [_stop setTitle:@"stop" forState:UIControlStateNormal];
    [_stop addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_stop];
}

- (void)start:(UIButton *)button {
    CABasicAnimation *animation1 = CABasicAnimation.animation;
    animation1.keyPath = @"transform.rotation";
    animation1.duration = 2.0;
    animation1.byValue = @(M_PI * 2);
    animation1.delegate = self;
    [_shipLayer addAnimation:animation1 forKey:@"rotateAnimation"];
}

- (void)stop:(UIButton *)button {
    [_shipLayer removeAnimationForKey:@"rotateAnimation"];
   // [_shipLayer animationForKey:@"rotateAnimation"];
   // [_shipLayer removeAllAnimations];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"The animation stopped (finished:%@)", flag ? @"YES" : @"NO");
}
@end
