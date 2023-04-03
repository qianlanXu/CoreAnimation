//
//  Presentation.m
//  calayer
//
//  Created by xu qianlan on 2023/4/2.
//

#import "Presentation.h"

@interface Presentation ()

@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) CALayer *secondLayer;

@end

@implementation Presentation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _colorLayer = CALayer.layer;
    _colorLayer.backgroundColor = UIColor.redColor.CGColor;
    _colorLayer.frame = CGRectMake(0, 0, 100, 100);
    _colorLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    [self.view.layer addSublayer:_colorLayer];
    
    _secondLayer = CALayer.layer;
    _secondLayer.backgroundColor = UIColor.yellowColor.CGColor;
    _secondLayer.frame = CGRectMake(0, 0, 100, 100);
    _secondLayer.position = CGPointMake(self.view.bounds.size.width * 0.5 + 100, self.view.bounds.size.height * 0.5 + 100);
    [self.view.layer addSublayer:_secondLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint point = [touches.anyObject locationInView:self.view];
    if ([_colorLayer.presentationLayer hitTest:point]) {
        // 动画过程点击就生效
        CGFloat r = arc4random()/(CGFloat)INT_MAX;
        CGFloat g = arc4random()/(CGFloat)INT_MAX;
        CGFloat b = arc4random()/(CGFloat)INT_MAX;
        _colorLayer.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0].CGColor;
    } else if ([_secondLayer.modelLayer hitTest:point]){
        // 动画结束后点击生效
        // 不生效的原因是动画过程中被隐藏了
        // 动画发生时，原layer将会被隐藏，动画停止后才生效。另一个图层属性modelLayer即可以被看作是原layer。
        CGFloat r = arc4random()/(CGFloat)INT_MAX;
        CGFloat g = arc4random()/(CGFloat)INT_MAX;
        CGFloat b = arc4random()/(CGFloat)INT_MAX;
        _secondLayer.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        _colorLayer.position = point;
        point.x = point.x + 70;
        _secondLayer.position = point;
        [CATransaction commit];
    }
}
@end
