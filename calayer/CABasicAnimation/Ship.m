//
//  Ship.m
//  calayer
//
//  Created by xu qianlan on 2023/4/3.
//

#import "Ship.h"

@interface Ship ()

@property (nonatomic, strong) UIView *containerView;

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
    
    CALayer *shipLayer = CALayer.layer;
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    
//    CABasicAnimation *animation1 = CABasicAnimation.animation;
//    animation1.keyPath = @"transform.rotation";
//    animation1.duration = 2.0;
//    animation1.byValue = @(M_PI * 2);
//    [shipLayer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = CABasicAnimation.animation;
    animation2.keyPath = @"transform";
    animation2.duration = 2.0;
    animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0, 0, 1)];
    [shipLayer addAnimation:animation2 forKey:nil];
    
    CAKeyframeAnimation *animation = CAKeyframeAnimation.animation;
    // 属性
    animation.keyPath = @"position";
    animation.path = shapeLayer.path;
    animation.duration = 5.0;
    // 图层将会根据曲线的切线自动旋转
    animation.rotationMode = kCAAnimationRotateAuto;
    
    [shipLayer addAnimation:animation forKey:nil];
    [_containerView.layer addSublayer:shipLayer];
}



@end
