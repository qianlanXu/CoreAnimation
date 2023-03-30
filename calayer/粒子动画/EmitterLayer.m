//
//  EmitterLayer.m
//  calayer
//
//  Created by xu qianlan on 2023/3/30.
//

#import "EmitterLayer.h"

@interface EmitterLayer ()

@property (nonatomic, strong) UIView *containerView;
@end

@implementation EmitterLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    [self.view addSubview:_containerView];
    
    CAEmitterLayer *emitter = CAEmitterLayer.layer;
    // 控制着在视觉上粒子图片是如何混合的
    // kCAEmitterLayerAdditive，它实现了这样一个效果：合并例子重叠部分的亮度使得看上去更亮
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width * 0.5, emitter.frame.size.height * 0.5);
    
    //属性在CAEmitterCell中也有的这些属性会以相乘的方式作用在一起，这样你就可以用一个值来加速或者扩大整个例子系统
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"Spark"].CGImage;
    // The number of emitted objects created every second
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    // 就是说例子的透明度每过一秒就是减少0.4，这样就有发射出去之后逐渐小时的效果
    cell.alphaSpeed = -0.4;
    // 粒子速度
    cell.velocity = 50;
    cell.velocityRange = 50;
    // M_PI * 2.0这意味着粒子可以从360度任意位置反射出来
    cell.emissionRange = M_PI * 2.0;
    emitter.emitterCells = @[cell];
    emitter.frame = self.view.bounds;
    [_containerView.layer addSublayer:emitter];
}



@end
