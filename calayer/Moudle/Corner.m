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
@end

@implementation Corner

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _viewA = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    _viewA.backgroundColor = UIColor.yellowColor;
    _viewA.layer.cornerRadius = 10;
    [self.view addSubview:_viewA];
    
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
