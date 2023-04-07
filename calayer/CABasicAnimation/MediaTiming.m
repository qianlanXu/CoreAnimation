//
//  MediaTiming.m
//  calayer
//
//  Created by xu qianlan on 2023/4/6.
//

#import "MediaTiming.h"

@interface MediaTiming () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *durationLabel;

@property (nonatomic, strong) UITextField *durationField;

@property (nonatomic, strong) UILabel *repeatLabel;

@property (nonatomic, strong) UITextField *repeatField;

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) CALayer *shipLayer;

@property (nonatomic, strong) CALayer *secondShipLayer;

@property (nonatomic, strong) UIBezierPath *bezierPath;

@property (nonatomic, strong) UISlider *speedSlider;

@property (nonatomic, strong) UISlider *timeOffsetSlider;

@property (nonatomic, strong) UILabel *timeOffsetLabel;

@property (nonatomic, strong) UILabel *speedLabel;

@property (nonatomic, strong) UILabel *timeOffsetValueLabel;

@property (nonatomic, strong) UILabel *speedValueLabel;

@property (nonatomic, strong) UIButton *playButton;

@end

@implementation MediaTiming

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_containerView];
    
    _durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 350, 100, 50)];
    _durationLabel.text = @"duration:";
    [_containerView addSubview:_durationLabel];
    
    _durationField = [[UITextField alloc] initWithFrame:CGRectMake(50, 400, 50, 50)];
    _durationField.borderStyle = UITextBorderStyleRoundedRect;
    _durationField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    _durationField.text = @"0";
    [_containerView addSubview:_durationField];
    
    _repeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 350, 100, 50)];
    _repeatLabel.text = @"repeatCount:";
    [_containerView addSubview:_repeatLabel];
    
    _repeatField = [[UITextField alloc] initWithFrame:CGRectMake(200, 400, 50, 50)];
    _repeatField.borderStyle = UITextBorderStyleRoundedRect;
    _repeatField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    _repeatField.text = @"0";
    [_containerView addSubview:_repeatField];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame = CGRectMake(300, 400, 50, 50);
    _startButton.backgroundColor = UIColor.orangeColor;
    [_startButton setTitle:@"start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_startButton];
    
    _shipLayer = CALayer.layer;
    _shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    _shipLayer.frame = CGRectMake(0, 0, 64, 64);
    _shipLayer.position = CGPointMake(150, 150);
    [_containerView.layer addSublayer:_shipLayer];
    
    _secondShipLayer = CALayer.layer;
    _secondShipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    _secondShipLayer.frame = CGRectMake(0, 0, 64, 64);
    _secondShipLayer.position = CGPointMake(50, 250);
    [_containerView.layer addSublayer:_secondShipLayer];
    
    _bezierPath = UIBezierPath.bezierPath;
    [_bezierPath moveToPoint:CGPointMake(50, 250)];
    [_bezierPath addCurveToPoint:CGPointMake(350, 150) controlPoint1:CGPointMake(75, 300) controlPoint2:CGPointMake(250, 300)];
    
    CAShapeLayer *shaperLayer = CAShapeLayer.layer;
    shaperLayer.fillColor = UIColor.clearColor.CGColor;
    shaperLayer.strokeColor = UIColor.yellowColor.CGColor;
    shaperLayer.lineWidth = 4.0;
    shaperLayer.path = _bezierPath.CGPath;
    [_containerView.layer addSublayer:shaperLayer];
    
    _speedSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 480, 100, 50)];
    _speedSlider.minimumValue = 0.0f;
    _speedSlider.maximumValue = 3.0f;
    [_speedSlider addTarget:self action:@selector(updateSliders) forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_speedSlider];
    
    _timeOffsetSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 600, 100, 50)];
    _timeOffsetSlider.minimumValue = 0.0f;
    _timeOffsetSlider.maximumValue = 3.0f;
    [_timeOffsetSlider addTarget:self action:@selector(updateSliders) forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_timeOffsetSlider];
    
    _speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 480, 100, 50)];
    _speedLabel.text = @"speed:";
    [_containerView addSubview:_speedLabel];
    
    _timeOffsetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 600, 100, 50)];
    _timeOffsetLabel.text = @"timeOffset:";
    [_containerView addSubview:_timeOffsetLabel];
    
    _speedValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 480, 100, 50)];
    _speedValueLabel.text = @"0.0";
    [_containerView addSubview:_speedValueLabel];
    
    _timeOffsetValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 600, 100, 50)];
    _timeOffsetValueLabel.text = @"0.0";
    [_containerView addSubview:_timeOffsetValueLabel];
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton.frame = CGRectMake(300, 500, 50, 50);
    _playButton.backgroundColor = UIColor.orangeColor;
    [_playButton setTitle:@"play" forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_playButton];
}

- (void)start:(UIButton *)button {
    CFTimeInterval duration = _durationField.text.doubleValue;
    CGFloat repeatCount = _repeatField.text.floatValue;
    CABasicAnimation *animation = CABasicAnimation.animation;
    animation.keyPath = @"transform.rotation";
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [_shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    [self setControlsEnabled:NO];
}

- (void)play:(UIButton *)button {
    CAKeyframeAnimation *animation = CAKeyframeAnimation.animation;
    animation.keyPath = @"position";
    animation.path = _bezierPath.CGPath;
    animation.speed = _speedSlider.value;
    animation.timeOffset = _timeOffsetSlider.value;
    animation.duration = 5.0;
    animation.rotationMode = kCAAnimationRotateAuto;
    // 动画将会在动画结束的时候仍然保持之前的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeRemoved;
    [_secondShipLayer addAnimation:animation forKey:nil];
}

- (void)updateSliders {
    CFTimeInterval time = _timeOffsetSlider.value;
    _timeOffsetValueLabel.text = [NSString stringWithFormat:@"%0.2f", time];
    
    CGFloat speed = _speedSlider.value;
    _speedValueLabel.text = [NSString stringWithFormat:@"%0.2f", speed];
}

- (void)hideKeyboard {
    [_durationField resignFirstResponder];
    [_repeatField resignFirstResponder];
}

// 防止重复点击
- (void)setControlsEnabled:(BOOL)enabled {
    for (UIControl *control in @[self.durationField, self.repeatField, self.startButton]) {
        control.enabled = enabled;
        control.alpha = enabled ? 1.0f : 0.25f;
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self setControlsEnabled:YES];
}
@end
