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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _path = UIBezierPath.bezierPath;
        _path.lineJoinStyle = kCGLineJoinRound;
        _path.lineCapStyle = kCGLineCapRound;
        _path.lineWidth = 5.0;
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
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 填充画布颜色
    // 只在drawRect生效,获取当前的context,在当前context生效 相当于
    [UIColor.clearColor setFill];
    [UIColor.redColor setStroke];
    // on the current graphics context
    [_path stroke];
}
@end
