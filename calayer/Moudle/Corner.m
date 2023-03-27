//
//  Corner.m
//  calayer
//
//  Created by xu qianlan on 2023/3/27.
//

#import "Corner.h"

@interface Corner ()

@property (nonatomic, strong) UIView *viewA;

@property (nonatomic, strong) UIView *viewB;

@property (nonatomic, strong) UIView *subViewA;

@property (nonatomic, strong) UIView *subViewB;

@property (nonatomic, strong) UIView *shadowView;

@end

@implementation Corner

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 150, 150)];
    // 阴影继承自内容的外形
    _shadowView.layer.shadowColor = UIColor.blueColor.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0, -3);
    _shadowView.layer.shadowOpacity = 0.5;
    _shadowView.layer.shadowRadius = 5.f;
    [self.view addSubview:_shadowView];
    
    _viewA = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    _viewA.backgroundColor = UIColor.yellowColor;
    // 边框由边界和角半径决定
    _viewA.layer.cornerRadius = 10;
    // 会把阴影裁剪掉，需要一个shadowView因为是对内容加阴影
    _viewA.clipsToBounds = YES;
    _viewA.layer.borderWidth = 3;
    
    [_shadowView addSubview:_viewA];
    
    _viewB = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    _viewB.backgroundColor = UIColor.orangeColor;
    _viewB.layer.cornerRadius = 10;
    _viewB.layer.masksToBounds = YES;
    [self.view addSubview:_viewB];
    
    _subViewA = [[UIView alloc] initWithFrame:CGRectMake(-25, -25, 50, 50)];
    _subViewA.backgroundColor = UIColor.redColor;
    [_viewA addSubview:_subViewA];
    
    _subViewB = [[UIView alloc] initWithFrame:CGRectMake(-25, -25, 50, 50)];
    _subViewB.backgroundColor = UIColor.redColor;
    [_viewB addSubview:_subViewB];
}



@end
