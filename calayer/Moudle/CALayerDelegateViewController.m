//
//  CALayerDelegateViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/3/24.
//

#import "CALayerDelegateViewController.h"

@interface CALayerDelegateViewController () <CALayerDelegate>

@end

@implementation CALayerDelegateViewController

//但是除非你创建了一个单独的图层，你几乎没有机会用到CALayerDelegate协议。因为当UIView创建了它的宿主图层时，它就会自动地把图层的delegate设置为它自己，并提供了一个-displayLayer:的实现，那所有的问题就都没了。
//当使用寄宿了视图的图层的时候，你也不必实现-displayLayer:和-drawLayer:inContext:方法来绘制你的寄宿图。通常做法是实现UIView的-drawRect:方法，UIView就会帮你做完剩下的工作，包括在需要重绘的时候调用-display方法。

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.f, 50.f, 100.f, 100.f);
    blueLayer.backgroundColor = UIColor.blueColor.CGColor;
    
    // 这是因为当你使用CALayerDelegate绘制寄宿图的时候，并没有对超出边界外的内容提供绘制支持
    blueLayer.delegate = self;
    
    blueLayer.contentsScale = UIScreen.mainScreen.scale;
    [self.view.layer addSublayer:blueLayer];
    
    // 强制layer重绘
    // 当图层显示在屏幕上时，CALayer不会自动重绘它的内容。它把重绘的决定权交给了开发者。
    // 会调用drawLayer:inContext:
    [blueLayer display];
    
}

// 对一个单独的图层使用Core Animation
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 4.0);
    CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


@end
