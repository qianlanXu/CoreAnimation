//
//  Outer.m
//  calayer
//
//  Created by xu qianlan on 2023/3/28.
//

#import "Outer.h"

@interface Outer ()

@property (nonatomic, strong) UIView *outer;

@property (nonatomic, strong) UIView *inner;

@end

@implementation Outer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _outer = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    _outer.backgroundColor = UIColor.blueColor;
    [self.view addSubview:_outer];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, -M_PI_4, 0, 1, 0);
    _outer.layer.transform = transform;
    
    _inner = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _inner.backgroundColor = UIColor.grayColor;
    [self.view addSubview:_inner];
    CATransform3D innerTransform = CATransform3DIdentity;
    innerTransform.m34 = -1.0 / 500.0;
    innerTransform = CATransform3DRotate(innerTransform, -M_PI_4, 0, 1, 0);
    _inner.layer.transform = innerTransform;
}



@end
