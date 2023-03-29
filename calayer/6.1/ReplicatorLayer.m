//
//  ReplicatorLayer.m
//  calayer
//
//  Created by xu qianlan on 2023/3/29.
//

#import "ReplicatorLayer.h"

@interface ReplicatorLayer ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;


@end

@implementation ReplicatorLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_containerView];
    
    [self musicVolumeAnimation];
}

- (void)musicVolumeAnimation {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = _containerView.bounds;
    replicatorLayer.backgroundColor = UIColor.blackColor.CGColor;
    [_containerView.layer addSublayer:replicatorLayer];
    
    // 创建音量振动条
    CALayer *layer = CALayer.layer;
    layer.backgroundColor = UIColor.whiteColor.CGColor;
    CGFloat width = 30;
    CGFloat height = 100;
    layer.frame = CGRectMake(0, _containerView.bounds.size.height - height, width, height);
    // anchorPoint 用来确定 layer 身上哪个点会在 position 所指的位置
    layer.anchorPoint = CGPointMake(0, 1);
    // postion 用来确定 layer 层在父层中的位置
    layer.position = CGPointMake(0, _containerView.bounds.size.height);
    [_containerView.layer addSublayer:layer];
    
    // 创建音量振动动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.toValue = @0;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    [layer addAnimation:animation forKey:nil];
    
    [replicatorLayer addSublayer:layer];
    replicatorLayer.instanceCount = 6;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(50, 0, 0);
    replicatorLayer.instanceDelay = 0.4;
    replicatorLayer.instanceAlphaOffset = -0.15;
    
    _replicatorLayer = replicatorLayer;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _replicatorLayer.frame = _containerView.bounds;
}
@end
