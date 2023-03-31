//
//  TransactionViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/3/31.
//

#import "TransactionViewController.h"

@interface TransactionViewController ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 300, 700)];
    [self.view addSubview:_containerView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"test" forState:UIControlStateNormal];
    _button.backgroundColor = UIColor.redColor;
    _button.frame = CGRectMake(100, 650, 100, 50);
    [_button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_button];
    
    _colorLayer = CALayer.layer;
    _colorLayer.backgroundColor = UIColor.yellowColor.CGColor;
    _colorLayer.frame = CGRectMake(0, 0, 300, 600);
    [_containerView.layer addSublayer:_colorLayer];
}

- (void)didClickButton:(UIButton *)button {
    // CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。但是可以用+begin和+commit分别来入栈或者出栈。
    // 首先起一个新的事务，于是修改时间就不会有别的副作用。因为修改当前事务的时间可能会导致同一时刻别的动画（如屏幕旋转），所以最好还是在调整动画之前压入一个新的事务。
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    // 这些系统的 block 不会造成循环引用的原因是，这是个类方法，block 不被 self 持有 ,而是其他负责的对象持有,同时不产生循环引用,block 持有了 self, block 运行结束会被释放,同时释放掉对 self 的持有, 所以不存在self 和 block 的循环引用问题,不需要weak 弱引用
    
    // 注意旋转动画要比颜色渐变快得多，这是因为完成块是在颜色渐变的事务提交并出栈之后才被执行,用默认的事务做变换，默认的时间也就变成了0.25秒
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
        
    }];
    CGFloat r = arc4random()/(CGFloat)INT_MAX;
    CGFloat g = arc4random()/(CGFloat)INT_MAX;
    CGFloat b = arc4random()/(CGFloat)INT_MAX;
    
    //隐式动画：当你改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来。相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。之所以叫隐式是因为我们并没有指定任何动画的类型。我们仅仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画。
    _colorLayer.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0].CGColor;
    [CATransaction commit];
}

@end
