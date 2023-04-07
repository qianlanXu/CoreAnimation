//
//  Door.m
//  calayer
//
//  Created by xu qianlan on 2023/4/7.
//

#import "Door.h"

@interface Door ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation Door

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_containerView];
    
    CALayer *doorLayer = CALayer.layer;
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    // postion 用来确定 layer 层在父层中的位置
    doorLayer.position = CGPointMake(150 - 64, 400);
    //anchorPoint 用来确定 layer 身上哪个点会在 position 所指的位置,就是动画的中心轴
    doorLayer.anchorPoint = CGPointMake(0, 0);
    doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door"].CGImage;
    [_containerView.layer addSublayer:doorLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    _containerView.layer.sublayerTransform = perspective;
    
    
    CABasicAnimation *animation = CABasicAnimation.animation;
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
}
@end
