//
//  BezierPath.m
//  calayer
//
//  Created by xu qianlan on 2023/3/20.
//

#import "BezierPath.h"

@interface BezierPath ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) CAShapeLayer *popLayer;

@property (nonatomic, strong) UILabel *tipLab;

@property (nonatomic, strong) UIImageView *icon;

/// 三角形高度
@property (nonatomic, assign) CGFloat triangleHeight;
/// 三角形宽度
@property (nonatomic, assign) CGFloat triangleWidth;
/// 三角形距离右边距离
@property (nonatomic, assign) CGFloat triangleRight;
/// 圆角
@property (nonatomic, assign) CGFloat radius;
/// 三角是否朝上
@property (nonatomic, assign) BOOL isTriangleUp;

/// 内容大小
@property (nonatomic, assign) CGSize contentSize;

@end

@implementation BezierPath

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUIComponents];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutUIComponents];
}

#pragma mark - Custom UI

- (void)createUIComponents {
    self.backgroundColor = UIColor.clearColor;
    _triangleHeight = 8.f;
    _triangleWidth = 15.f;
    _triangleRight = 31.f;
    _radius = 11.f;
    
    _popLayer = [[CAShapeLayer alloc] init];
    _popLayer.fillColor = [UIColor.redColor colorWithAlphaComponent:0.5].CGColor;
    _popLayer.strokeColor = [[UIColor alloc] initWithWhite:1 alpha:0.28].CGColor;
    _popLayer.lineWidth = 1;
    [self.layer insertSublayer:_popLayer atIndex:0];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColor.clearColor;
    _contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"voiceCard_laugh_icon"]];
    [_contentView addSubview:_icon];
    
    _tipLab = [[UILabel alloc] init];
    _tipLab.font = [UIFont systemFontOfSize:13];
    _tipLab.textColor = UIColor.whiteColor;
    _tipLab.textAlignment = NSTextAlignmentCenter;
    _tipLab.text = @"前往配置你的声音，让更多好友找你聊天";
    _tipLab.numberOfLines = 2;
    [_contentView addSubview:_tipLab];
}

- (void)layoutUIComponents {
    _contentSize = CGSizeMake(180, 53);
    self.bounds = CGRectMake(0, 0, _contentSize.width, _contentSize.height + _triangleHeight);
    _contentView.frame = self.bounds;
    _popLayer.path = self.triangleTopPath.CGPath;
    
    const CGFloat iconX = 12;
    const CGFloat iconY = 13 + _triangleHeight;
    const CGFloat iconW = 32;
    const CGFloat iconH = 32;
    _icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    const CGFloat labelX = iconX + iconW + 5.5;
    const CGFloat labelY = 9;
    const CGFloat labelW = self.bounds.size.width - labelX;
    const CGFloat labelH = self.bounds.size.height - labelY;
    _tipLab.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

/// 三角在上
- (UIBezierPath *)triangleTopPath {
    const CGFloat triangleRadius = 3;
    CGFloat triangleLength = triangleRadius * sin(M_PI_4);
    CGSize size = self.bounds.size;
    CGPoint p0 = CGPointMake(size.width - _triangleRight - _triangleWidth / 2, 0);
    CGPoint p0_c = CGPointMake(p0.x, triangleRadius);
    CGPoint p0_a = CGPointMake(p0.x - triangleLength, triangleRadius - triangleLength);
    CGPoint p0_b = CGPointMake(p0.x + triangleLength, triangleRadius - triangleLength);
    CGPoint p1 = CGPointMake(p0.x - _triangleWidth / 2, _triangleHeight);
    CGPoint p2 = CGPointMake(_radius, p1.y);
    CGPoint p2_c = CGPointMake(p2.x, p2.y + _radius);
    CGPoint p3 = CGPointMake(0, size.height - _radius);
    CGPoint p3_c = CGPointMake(_radius, p3.y);
    CGPoint p4 = CGPointMake(size.width - _radius, size.height);
    CGPoint p4_c = CGPointMake(p4.x, size.height - _radius);
    CGPoint p5 = CGPointMake(size.width, _triangleHeight + _radius);
    CGPoint p5_c = CGPointMake(p5.x - _radius, p5.y);
    CGPoint p6 = CGPointMake(size.width - _triangleRight, _triangleHeight);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p0_b];
    [path addArcWithCenter:p0_c radius:3 startAngle:-M_PI_4 endAngle:-M_PI_4 * 3 clockwise:NO];
    [path addLineToPoint:p1];
    [path addLineToPoint:p2];
    [path addArcWithCenter:p2_c radius:_radius startAngle:-M_PI_2 endAngle:-M_PI_2 * 2 clockwise:NO];
    [path addLineToPoint:p3];
    [path addArcWithCenter:p3_c radius:_radius startAngle:-M_PI_2 * 2 endAngle:-M_PI_2 * 3 clockwise:NO];
    [path addLineToPoint:p4];
    [path addArcWithCenter:p4_c radius:_radius startAngle:-M_PI_2 * 3 endAngle:0 clockwise:NO];
    [path addLineToPoint:p5];
    [path addArcWithCenter:p5_c radius:_radius startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    [path addLineToPoint:p6];
    [path addLineToPoint:p0_b];

    return path;
}
@end

