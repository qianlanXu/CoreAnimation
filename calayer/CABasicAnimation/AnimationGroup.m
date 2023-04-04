//
//  AnimationGroup.m
//  calayer
//
//  Created by xu qianlan on 2023/4/4.
//

#import "AnimationGroup.h"

@interface AnimationGroup ()

@property (nonatomic, strong) UIView *containerView;
@end

@implementation AnimationGroup

- (void)viewDidLoad {
    [super viewDidLoad];
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_containerView];
    
    UIBezierPath *bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = CAShapeLayer.layer;
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = UIColor.clearColor.CGColor;
    pathLayer.strokeColor = UIColor.greenColor.CGColor;
    pathLayer.lineWidth = 4.0;
    [_containerView.layer addSublayer:pathLayer];
    
    CALayer *colorLayer = CALayer.layer;
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = UIColor.orangeColor.CGColor;
    [_containerView.layer addSublayer:colorLayer];
    
    CAKeyframeAnimation *animation = CAKeyframeAnimation.animation;
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation1 = CABasicAnimation.animation;
    animation1.keyPath = @"backgroundColor";
    animation1.toValue = (__bridge id)UIColor.redColor.CGColor;
    
    // 动画一起叠加没有先后顺序
    CAAnimationGroup *groupAnimation = CAAnimationGroup.animation;
    groupAnimation.duration = 5.0;
    groupAnimation.animations = @[animation, animation1];
    [colorLayer addAnimation:groupAnimation forKey:nil];
    
    
}



@end
