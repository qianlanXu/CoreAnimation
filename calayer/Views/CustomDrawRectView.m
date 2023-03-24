//
//  CustomDrawRectView.m
//  calayer
//
//  Created by xu qianlan on 2023/3/21.
//

#import "CustomDrawRectView.h"

@implementation CustomDrawRectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.lightGrayColor;
    }
    return self;
}

// 在此自定义绘画和动画
- (void)drawRect:(CGRect)rect {
    // 一个不透明类型的Quartz 2D绘画环境,相当于一个画布，你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
#pragma mark - 1.写文字
    // 设置填充颜色
    CGContextSetRGBFillColor(context, 255/255.0, 175/255.0, 40/255.0, 1.0);
    // 增添字体属性
    NSDictionary *dictionary = @{NSForegroundColorAttributeName: UIColor.cyanColor,
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
    };
    [@"画圆" drawInRect:CGRectMake(10, 20, 80, 20) withAttributes:dictionary];
    [@"画线及孤线：" drawInRect:CGRectMake(10, 80, 80, 20) withAttributes:dictionary];
    [@"画矩形：" drawInRect:CGRectMake(10, 130, 80, 20) withAttributes:dictionary];
    [@"画图形：" drawInRect:CGRectMake(10, 260, 80, 20) withAttributes:dictionary];
    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 350, 80, 20) withAttributes:dictionary];
    [@"图片:" drawInRect:CGRectMake(10, 400, 80, 20) withAttributes:dictionary];
    [@"画虚线:" drawInRect:CGRectMake(10, 460, 80, 20) withAttributes:dictionary];

#pragma mark - 2.画圆
    CGContextSetRGBStrokeColor(context, 255/255.0, 255/255.0, 255/255.0, 1);
    CGContextSetLineWidth(context, 1.0);
    CGContextAddArc(context, 70, 30, 15, 0, 2*M_PI, 0);
    // 绘制路径
     /*kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充（有边框颜色 和 填充颜色）
     kCGPathEOFillStroke：奇偶填充并绘制边框*/
    CGContextDrawPath(context, kCGPathStroke);
    
    // 填充圆
    CGContextSetRGBFillColor(context, 255/255.0, 175/255.0, 40/255.0, 1.0);
    CGContextAddArc(context, 130, 30, 20, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    // 画有边框的实体圆
    UIColor *color = [UIColor colorWithRed:1 green:0.0 blue:0.0 alpha:1.0];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 3.0);
    CGContextAddArc(context, 200, 30, 30, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
#pragma mark - 画线及弧线
    // 画线
    CGPoint aPoints[2];
    aPoints[0] = CGPointMake(120, 80);
    aPoints[1] = CGPointMake(160, 100);
    CGContextAddLines(context, aPoints, 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 画线1
    CGContextSetStrokeColorWithColor(context, UIColor.yellowColor.CGColor);
    CGContextMoveToPoint(context, 170, 80);
    CGContextAddLineToPoint(context, 170, 100);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 圆弧
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, UIColor.greenColor.CGColor);
    //弧度 中心点右侧 弧度为 0 顺时针为+ 逆时针为-
    CGContextAddArc(context, 200, 100, 15, 0, M_PI_2 * 3, 0);// 1逆时针 0顺时针
    CGContextDrawPath(context, kCGPathStroke);
    
    // 画笑脸
    CGContextSetStrokeColorWithColor(context, UIColor.orangeColor.CGColor);
    // 开始点p1
    CGContextMoveToPoint(context, 240, 90);
    //参数：CGFloat x1 控制点的x坐标, CGFloat y1 控制点的y坐标,CGFloat x2 结束点的x坐标, CGFloat y2 结束点的y坐标, CGFloat radius 半径
       /*
       开始点的坐标为p1，控制点坐标为p2,结束点的的坐标为p3
           以p2为端点，发出两条射线，分别经过p1和p3，那么与两条射线相切的圆有无数个，若是给一个确定的半径，则可以确定一个圆。那么函数可以绘制两个切点之间的一段弧线
        1).若开始点和结束点正好在两个切点的位置，则绘制一条弧线。
        2).若开始点不是切点，则以开始点连一条直线到切点再绘制弧线。
        3).所以该函数需要确定好控制点 和 结束点的位置 及 半径的值
        4).上下文会自动以结束点为 current point。
        */
    CGContextAddArcToPoint(context, 248, 78, 256, 90, 10);
    // 绘画路径
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 260, 90);
    CGContextAddArcToPoint(context, 268, 78, 276, 90, 10);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 250, 100);
    CGContextAddArcToPoint(context, 258, 112, 266, 100, 10);
    CGContextStrokePath(context);
    
    
    // 圆角为10的矩形
    // 左
    CGContextSetStrokeColorWithColor(context, UIColor.blueColor.CGColor);
    CGContextMoveToPoint(context, 300, 80);
    CGContextAddArcToPoint(context, 300, 120, 310, 120, 10);
    CGContextStrokePath(context);
    
    // 下
    CGContextSetStrokeColorWithColor(context, UIColor.redColor.CGColor);
    CGContextMoveToPoint(context, 310, 120);
    CGContextAddArcToPoint(context, 340, 120, 340, 110, 10);
    CGContextStrokePath(context);
    
    // 右
    CGContextSetStrokeColorWithColor(context, UIColor.yellowColor.CGColor);
    CGContextMoveToPoint(context, 340, 110);
    CGContextAddArcToPoint(context, 340, 70, 330, 70, 10);
    CGContextStrokePath(context);
    
    // 上
    CGContextSetStrokeColorWithColor(context, UIColor.greenColor.CGColor);
    CGContextMoveToPoint(context, 330, 70);
    CGContextAddArcToPoint(context, 300, 70, 300, 80, 10);
    CGContextStrokePath(context);
    
#pragma mark - 矩形
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextStrokeRect(context, CGRectMake(80, 120, 30, 30));
    
    CGContextSetLineWidth(context, 2.0);
    color = UIColor.blueColor;
    CGContextSetFillColorWithColor(context, color.CGColor);
    color = UIColor.yellowColor;
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextAddRect(context, CGRectMake(140, 120, 60, 30));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 渐变矩形
    // 方式1.就不属于在context上画，而是将层插入到view层上面
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(240, 120, 40, 40);
    gradient.colors = [NSArray arrayWithObjects:(id)UIColor.purpleColor.CGColor, (id)UIColor.greenColor.CGColor, (id)UIColor.cyanColor.CGColor, (id)UIColor.yellowColor.CGColor, nil];
    // 并不是表示颜色值所在位置,它表示的是颜色在Layer坐标系相对位置处要开始进行渐变颜色了
    gradient.locations = [NSArray arrayWithObjects:@(0.1), @(0.2), @(0.75), @(1.0), nil];
    // [0,0]左上角 [1, 1]右上角
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    [self.layer insertSublayer:gradient atIndex:0];
    
    // 方式2.
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] = {
        1,1,1, 1.0,
        1,1,0, 1.0,
        1,0,0, 1.0,
        1,0,1, 1.0,
        0,1,1, 1.0,
        0,1,0, 1.0,
        0,0,1, 1.0,
        0,0,0, 1.0,
    };
    // 参数：创建一个渐变的色值 1:颜色空间 2:渐变的色数组 3:位置数组,如果为NULL,则为平均渐变,否则颜色和位置一一对应 4:位置的个数
    CGGradientRef gradient2 = CGGradientCreateWithColorComponents(space, colors, NULL, sizeof(colors)/(sizeof(colors[0]) * 4) );
    //使用RGB模式的颜色空间（在Quartz 2D中凡是使用带有Create或者Copy关键字方法创建的对象，在使用后一定要使用对应的方法释放）
    CGColorSpaceRelease(space);
    
    //CGContextSaveGState 与 CGContextRestoreGState的作用
    /*
     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改。这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
     
     举个例子：现在画一个矩形框，边框的宽度为1，颜色为红色 save上下文，接着再画一个矩形框，宽度为2，颜色为蓝色。若现在又想画另一个宽度为1，颜色为红色的矩形，就不必改去写CGContextSetLineWidth（）和CGContextSetFillColorWithColor（）函数改变属性了，直接restore上下文，上下文就恢复到save之前的各项属性了，省去了重复更改上下文属性的代码编写了。
     */
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 320, 130);
    CGContextAddLineToPoint(context, 350, 130);
    CGContextAddLineToPoint(context, 350, 160);
    CGContextAddLineToPoint(context, 320, 160);
    //用当前的context的path作为裁剪的路径。
    CGContextClip(context);
    //options开始坐标之前or开始之后开始渐变
    CGContextDrawLinearGradient(context, gradient2, CGPointMake(320, 130), CGPointMake(350, 160), kCGGradientDrawsBeforeStartLocation);
    CGContextRestoreGState(context);
    
    // 渐变同心圆
    //KCGGradientDrawsAfterEndLocation扩展整个渐变到渐变的终点之后的所有点 KCGGradientDrawsBeforeStartLocation扩展整个渐变到渐变的起点之前的所有点。0不扩展该渐变。
    CGContextDrawRadialGradient(context, gradient2, CGPointMake(90, 200), 0, CGPointMake(90, 200), 20, 0);
    
    // 渐变圆筒
    CGContextDrawRadialGradient(context, gradient2, CGPointMake(170, 200), 5, CGPointMake(250, 200), 30, 0);
    
#pragma mark - 扇形和椭圆
    color = [UIColor colorWithRed:0 green:1.0 blue:1.0 alpha:1.0];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetStrokeColorWithColor(context, UIColor.whiteColor.CGColor);
    CGContextMoveToPoint(context, 100, 290);
    CGContextAddArc(context, 100, 290, 10, -M_PI/3, M_PI_2, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 画椭圆
    CGContextAddEllipseInRect(context, CGRectMake(130, 260, 40, 20));
    CGContextDrawPath(context, kCGPathFillStroke);
    
#pragma mark - 画多边形
    // 画三角形
    CGPoint sPoints[3];
    sPoints[0] = CGPointMake(180, 290);
    sPoints[1] = CGPointMake(210, 290);
    sPoints[2] = CGPointMake(240, 230);
    CGContextAddLines(context, sPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 画五角形
    CGPoint fPoints[5];
    fPoints[0] = CGPointMake(250, 300);
    fPoints[1] = CGPointMake(280, 300);
    fPoints[2] = CGPointMake(280, 240);
    fPoints[3] = CGPointMake(250, 240);
    fPoints[4] = CGPointMake(265, 270);
    CGContextAddLines(context, fPoints, 5);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 用贝塞尔曲线画五角星
    UIBezierPath *starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(314.5, 241)];
    [starPath addLineToPoint: CGPointMake(326.31, 255.41)];
    [starPath addLineToPoint: CGPointMake(346.36, 260.35)];
    [starPath addLineToPoint: CGPointMake(333.62, 274.19)];
    [starPath addLineToPoint: CGPointMake(334.19, 291.65)];
    [starPath addLineToPoint: CGPointMake(314.5, 285.8)];
    [starPath addLineToPoint: CGPointMake(294.81, 291.65)];
    [starPath addLineToPoint: CGPointMake(295.38, 274.19)];
    [starPath addLineToPoint: CGPointMake(282.64, 260.35)];
    [starPath addLineToPoint: CGPointMake(302.69, 255.41)];
    [starPath closePath];
    // 只在drawRect生效,获取当前的context,在当前context生效 相当于：
    //    UIColor *color = ... // some color
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(ctx, color.CGColor);
    [UIColor.cyanColor setFill];
    // on the current graphics context
    [starPath fill];
    
    CGContextMoveToPoint(context, 120, 350);
    // 二次曲线,设置贝塞尔曲线的控制点坐标和终点坐标
    CGContextAddQuadCurveToPoint(context, 150, 305, 180, 350);
    CGContextStrokePath(context);
    
    // 三次曲线
    CGContextMoveToPoint(context, 200, 350);
    //三次曲线函数（控制点1，控制点2，终点）
    CGContextAddCurveToPoint(context, 250, 330, 220, 400, 280, 320);
    CGContextStrokePath(context);
    
#pragma mark - 图片
    UIImage *image = [UIImage imageNamed:@"1"];
    [image drawInRect:CGRectMake(60, 400, 60, 60)];
    
    //在UIKit中，y轴是向下的。而在Core Graphics(Quartz) 中 y轴是向上
    // 使用CGContextDrawImage来绘图的话，默认是在用户空间下绘制出来的，使用的坐标系是以左下角为原点，y轴向上，x轴向右。
    //图像是刚好相反的，因为显示在屏幕上面是使用的是设备的坐标，而这样的话正好设备坐标y轴是向下为正的。也就是可以理解成从用户空间转换成了设备空间。
    CGRect rect1 = CGRectMake(160, 400, 60, 60);
   // CGContextDrawImage(context, rect1, image.CGImage);
    
//    // 转换坐标系
//    // 平移坐标系
//    CGContextTranslateCTM(context, rect1.origin.x, rect1.origin.y);
//    // 平移坐标系
//    CGContextTranslateCTM(context, 0, rect1.size.height);
//    // 翻转y轴
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextTranslateCTM(context, -rect1.origin.x, -rect1.origin.y);
//    CGContextDrawImage(context, rect1, image.CGImage);
    
    // 保持原大小
    [image drawAtPoint:CGPointMake(240, 430)];
    
    // 平铺在整个画布
    //CGContextDrawTiledImage(context, CGRectMake(280, 400, 60, 60), image.CGImage);
    
#pragma mark - 画虚线
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, UIColor.whiteColor.CGColor);
    //lengths的值｛10,10｝表示先绘制10个点的长度，再跳过10个点的长度，如此反复
    CGFloat lengths[] = {10, 10};
    // 设置线条起点和终点的样式为圆角
    CGContextSetLineCap(context, kCGLineCapRound);
    //CGFloat phase:绘制第一个虚线点时先减去该数值的长度。
    CGContextSetLineDash(context, 5, lengths, 2);
    
    CGContextMoveToPoint(context, 0, 490);
    CGContextAddLineToPoint(context, self.frame.size.width - 3, 520);
    CGContextStrokePath(context);
 
    CGContextSetLineWidth(context, 2);
    CGFloat lengths1[] = {10, 10, 5};
    CGContextSetLineDash(context, 0, lengths1, 3);
    CGContextMoveToPoint(context, 0, 530);
    CGContextAddLineToPoint(context, self.frame.size.width, 530);
    CGContextStrokePath(context);
    
}
@end
