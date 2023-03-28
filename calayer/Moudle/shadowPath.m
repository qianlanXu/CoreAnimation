//
//  shadowPath.m
//  calayer
//
//  Created by xu qianlan on 2023/3/27.
//

#import "shadowPath.h"

@interface shadowPath ()

@property (nonatomic, strong) UIView *viewA;

@property (nonatomic, strong) UIView *viewB;

@end

@implementation shadowPath

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _viewA = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    _viewA.layer.contents = (__bridge id)[UIImage imageNamed:@"1"].CGImage;
    _viewA.layer.shadowOpacity = 0.5;
    _viewA.layer.contentsGravity = kCAGravityCenter;
    
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, nil, _viewA.layer.bounds);
    _viewA.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
    [self.view addSubview:_viewA];
    
    _viewB = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    _viewB.layer.contents = (__bridge id)[UIImage imageNamed:@"1"].CGImage;
    _viewB.layer.shadowOpacity = 0.5;
    _viewB.layer.contentsGravity = kCAGravityCenter;
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, nil, _viewB.layer.bounds);
    _viewB.layer.shadowPath = circlePath;
    
    CGPathRelease(circlePath);
    [self.view addSubview:_viewB];
}

@end
