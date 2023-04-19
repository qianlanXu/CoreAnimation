//
//  DrawView.m
//  calayer
//
//  Created by xu qianlan on 2023/4/18.
//

#import "DrawView.h"

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawView

// 避免重写drawRect,使用有硬件支持的CAShapeLayer

+ (Class)layerClass {
    return CAShapeLayer.class;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _path = UIBezierPath.bezierPath;
        
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = UIColor.redColor.CGColor;
        shapeLayer.fillColor = UIColor.clearColor.CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 5.0;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    [_path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self];
    [_path addLineToPoint:point];
    ((CAShapeLayer *)self.layer).path = _path.CGPath;
}


@end
