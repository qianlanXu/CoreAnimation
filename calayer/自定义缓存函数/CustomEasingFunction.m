//
//  CustomEasingFunction.m
//  calayer
//
//  Created by xu qianlan on 2023/4/11.
//

#import "CustomEasingFunction.h"

@interface CustomEasingFunction ()

@property (nonatomic, strong) UIView *easeInLayerView;

@property (nonatomic, strong) UIView *easeOutLayerView;

@property (nonatomic, strong) UIView *linearLayerView;

@property (nonatomic, strong) UIView *easeInOutLayerView;

@property (nonatomic, strong) UIView *defaultLayerView;

@end

@implementation CustomEasingFunction

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self createView];
}

- (void)createView {
    _easeInLayerView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    _easeInLayerView.backgroundColor = UIColor.yellowColor;
    [self createCurveLayerWithView:_easeInLayerView type:kCAMediaTimingFunctionEaseIn];
    [self.view addSubview:_easeInLayerView];
    
    _easeOutLayerView = [[UIView alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
    _easeOutLayerView.backgroundColor = UIColor.orangeColor;
    [self createCurveLayerWithView:_easeOutLayerView type:kCAMediaTimingFunctionEaseOut];
    [self.view addSubview:_easeOutLayerView];

    _linearLayerView = [[UIView alloc] initWithFrame:CGRectMake(50, 550, 100, 100)];
    _linearLayerView.backgroundColor = UIColor.greenColor;
    [self createCurveLayerWithView:_linearLayerView type:kCAMediaTimingFunctionLinear];
    [self.view addSubview:_linearLayerView];

    _easeInOutLayerView = [[UIView alloc] initWithFrame:CGRectMake(270, 50, 100, 100)];
    _easeInOutLayerView.backgroundColor = UIColor.blueColor;
    [self createCurveLayerWithView:_easeInOutLayerView type:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view addSubview:_easeInOutLayerView];

    _defaultLayerView = [[UIView alloc] initWithFrame:CGRectMake(270, 300, 100, 100)];
    _defaultLayerView.backgroundColor = UIColor.purpleColor;
    [self createCurveLayerWithView:_defaultLayerView type:kCAMediaTimingFunctionDefault];
    [self.view addSubview:_defaultLayerView];
}

- (void)createCurveLayerWithView:(UIView *)layerView type:(CAMediaTimingFunctionName)name {
    // create timing function
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:name];
    // get control points
    float controlPoint1[2];
    float controlPoint2[2];
    [function getControlPointAtIndex:1 values:controlPoint1];
    [function getControlPointAtIndex:2 values:controlPoint2];
    // create curve
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1) controlPoint1:CGPointMake(controlPoint1[0], controlPoint1[1]) controlPoint2:CGPointMake(controlPoint2[0], controlPoint2[1])];
    // scale the path up to a reasonable size to diaplay
    [path applyTransform:CGAffineTransformMakeScale(100.f, 100.f)];
    // create shape layer
    CAShapeLayer *shapeLayer = CAShapeLayer.layer;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [layerView.layer addSublayer:shapeLayer];
    // flip geometry so that 0,0 is in the bottom-left
    layerView.layer.geometryFlipped = YES;
}
@end
