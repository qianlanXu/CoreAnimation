//
//  AffineTransform.m
//  calayer
//
//  Created by xu qianlan on 2023/3/28.
//

#import "AffineTransform.h"

@interface AffineTransform ()

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UIView *secondLayerView;

@end

@implementation AffineTransform

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.grayColor;
    _layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    _layerView.layer.contents = (__bridge id)[UIImage imageNamed:@"Snowman"].CGImage;
    [self.view addSubview:_layerView];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
    _layerView.layer.affineTransform = transform;
    
    // 一个变换的基础上做更深层次的变换
    _secondLayerView = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 200, 200)];
    _secondLayerView.layer.contents = (__bridge id)[UIImage imageNamed:@"Snowman"].CGImage;
    [self.view addSubview:_secondLayerView];
    
    //初始生成一个什么都不做的变换很重要--也就是创建一个CGAffineTransform类型的空值，矩阵论中称作单位矩阵
    CGAffineTransform transform2 = CGAffineTransformIdentity;
    
    // 变换的顺序会影响最终的结果，也就是说旋转之后的平移和平移之后的旋转
    // 缩小0.5
    transform2 = CGAffineTransformScale(transform2, 0.5, 0.5);
    // 旋转45度
    transform2 = CGAffineTransformRotate(transform2, M_PI_4);
    // 向右平移200，实际上缩小后剩下100
    transform2 = CGAffineTransformTranslate(transform2, 200, 0);
    
    _secondLayerView.layer.affineTransform = CGAffineTransformConcat(transform, transform2);
}



@end
