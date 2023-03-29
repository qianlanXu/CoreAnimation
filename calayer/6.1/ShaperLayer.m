//
//  ShaperLayer.m
//  calayer
//
//  Created by xu qianlan on 2023/3/29.
//

#import "ShaperLayer.h"

@interface ShaperLayer ()

@property (nonatomic, strong) UIView *cornerView;

@end

@implementation ShaperLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    CAShapeLayer *shapeLayer = [self createShaper];
    shapeLayer.path = [self createPath].CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    _cornerView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 300, 300)];
    _cornerView.backgroundColor = UIColor.redColor;
    [self.view addSubview:_cornerView];
    [self specifiedCornerByView:_cornerView corners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
}

- (UIBezierPath *)createPath {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    return path;
}

- (CAShapeLayer *)createShaper {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.lineWidth = 5.0;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    
    return shapeLayer;
}

// cornerRadii:used only CGSize.width value and ignored .height
- (void)specifiedCornerByView:(UIView *)view corners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}
@end
