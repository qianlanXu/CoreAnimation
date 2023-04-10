//
//  AnimationTimingFunction.m
//  calayer
//
//  Created by xu qianlan on 2023/4/10.
//

#import "AnimationTimingFunction.h"

@interface AnimationTimingFunction ()

@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIView *colorView;

@end

@implementation AnimationTimingFunction

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _colorLayer = CALayer.layer;
    _colorLayer.frame = CGRectMake(0, 0, 100, 100);
    _colorLayer.position = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    _colorLayer.backgroundColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:_colorLayer];
    
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    _colorView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:_colorView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    _colorLayer.position = [touches.anyObject locationInView:self.view];
    [CATransaction commit];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.colorView.center = [touches.anyObject locationInView:self.view];
    } completion:nil];
    
    
}

@end
