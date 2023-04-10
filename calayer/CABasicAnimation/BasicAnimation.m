//
//  BasicAnimaction.m
//  calayer
//
//  Created by xu qianlan on 2023/4/3.
//

#import "BasicAnimation.h"

@interface BasicAnimation () <CAAnimationDelegate>

@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIButton *keyButton;

@end

@implementation BasicAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _colorLayer = CALayer.layer;
    _colorLayer.frame = CGRectMake(50.f, 50.f, 100.f, 100.f);
    _colorLayer.backgroundColor = UIColor.blueColor.CGColor;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_contentView];
    
    [_contentView.layer addSublayer:_colorLayer];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100.f, 600.f, 100.f, 100.f);
    [_button setTitle:@"改变颜色" forState:UIControlStateNormal];
    _button.backgroundColor = UIColor.orangeColor;
    [_button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_button];
    
    _keyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _keyButton.frame = CGRectMake(100.f, 400.f, 100.f, 100.f);
    [_keyButton setTitle:@"keyFrame改变颜色" forState:UIControlStateNormal];
    _keyButton.backgroundColor = UIColor.greenColor;
    [_keyButton addTarget:self action:@selector(didClickKeyButton:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_keyButton];
}

- (void)didClickButton:(UIButton *)button {
    CGFloat r = arc4random()/(CGFloat)INT_MAX;
    CGFloat g = arc4random()/(CGFloat)INT_MAX;
    CGFloat b = arc4random()/(CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    CABasicAnimation *animation = CABasicAnimation.animation;
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    [_colorLayer addAnimation:animation forKey:nil];
}

- (void)didClickKeyButton:(UIButton *)button {
    CAKeyframeAnimation *animation = CAKeyframeAnimation.animation;
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)UIColor.redColor.CGColor,
    (__bridge id)UIColor.yellowColor.CGColor,
    (__bridge id)UIColor.greenColor.CGColor,
    (__bridge id)UIColor.blueColor.CGColor];
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.timingFunctions = @[fn, fn, fn, fn];
    [_colorLayer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    // 关闭隐式动画
    [CATransaction setDisableActions:YES];
    _colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}
@end
