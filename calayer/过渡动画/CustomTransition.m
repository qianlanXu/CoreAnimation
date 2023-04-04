//
//  CustomTransition.m
//  calayer
//
//  Created by xu qianlan on 2023/4/4.
//

#import "CustomTransition.h"

@interface CustomTransition ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation CustomTransition

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 600, 50, 50);
    _button.backgroundColor = UIColor.orangeColor;
    [_button setTitle:@"change" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
}

- (void)didClickButton:(UIButton *)button {
    // 对当前视图self.view状态截图
    // 把这个截屏视图coverView置于原始视图self.view之上，就可以遮住真实视图self.view的所有变化，于是重新创建了一个简单的过渡效果
    
    // 创建画布
    // 参数: 指定将来创建出来的bitmap的大小
    // 设置透明YES代表不透明，NO代表透明
    // 代表缩放,0代表不缩放
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    
    // 将view的layer渲染到当前的绘制的上下文中。
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 获取图片
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    // 在coverView中显示出来
    UIImageView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    CGFloat r = arc4random()/(CGFloat)INT_MAX;
    CGFloat g = arc4random()/(CGFloat)INT_MAX;
    CGFloat b = arc4random()/(CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    // 我们改变原始视图的背景色的时候对截图快速转动并且淡出
    [UIView animateWithDuration:5.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
    
    UIGraphicsEndImageContext();
}

@end
