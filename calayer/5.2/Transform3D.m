//
//  Transform3D.m
//  calayer
//
//  Created by xu qianlan on 2023/3/28.
//

#import "Transform3D.h"

@interface Transform3D ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UIView *secondLayerView;

@end

@implementation Transform3D

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 800)];
    _containerView.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:_containerView];
    // 用来做透视
    // m34的默认值是0，我们可以通过设置m34为-1.0 / d来应用透视效果，d代表了想象中视角相机和屏幕之间的距离，以像素为单位，
    // 通常500-1000就已经很好了，但对于特定的图层有时候更小后者更大的值会看起来更舒服，减少距离的值会增强透视效果，所以一个非常微小的值会让它看起来更加失真，然而一个非常大的值会让它基本失去透视效果
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    // 影响到所有的子图层。这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法
    // 灭点被设置在容器图层的中点，从而不需要再对子图层分别设置了。这意味着你可以随意使用position和frame来放置子图层，
    // 而不需要把它们放置在屏幕中点，然后为了保证统一的灭点用变换来做平移
    _containerView.layer.sublayerTransform = perspective;
    
    _layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    _layerView.backgroundColor = UIColor.whiteColor;
    _layerView.layer.contents = (__bridge id)[UIImage imageNamed:@"Snowman"].CGImage;
    [_containerView addSubview:_layerView];
    
    _secondLayerView = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 200, 200)];
    _secondLayerView.backgroundColor = UIColor.whiteColor;
    _secondLayerView.layer.contents = (__bridge id)[UIImage imageNamed:@"Snowman"].CGImage;
    // 背面不会被绘制
    _secondLayerView.layer.doubleSided = NO;
    [_containerView addSubview:_secondLayerView];
    
    // 在y轴上旋转一定的角度
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    _layerView.layer.transform = transform;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2 = CATransform3DRotate(transform2, M_PI, 0, 1, 0);
    _secondLayerView.layer.transform = transform2;
}

@end
