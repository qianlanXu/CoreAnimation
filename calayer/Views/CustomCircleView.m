//
//  CustomCircleView.m
//  calayer
//
//  Created by xu qianlan on 2023/3/21.
//

#import "CustomCircleView.h"

@implementation CustomCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.purpleColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 获取画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(context, UIColor.redColor.CGColor);
    // 画笔宽度
    CGFloat lineWidth = 5.f;
    CGContextSetLineWidth(context, lineWidth);
    // 圆点坐标
    CGFloat centerX = CGRectGetWidth(rect) * 0.5;
    CGFloat centerY = CGRectGetHeight(rect) * 0.5;
    CGFloat radius = self.bounds.size.width * 0.5 - lineWidth;
    // 绘制路径
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, NO);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
