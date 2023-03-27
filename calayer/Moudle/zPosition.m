//
//  zPosition.m
//  calayer
//
//  Created by xu qianlan on 2023/3/27.
//

#import "zPosition.h"

@interface zPosition ()

@property (nonatomic, strong) UIView *greenView;

@property (nonatomic, strong) UIView *redView;

@end

@implementation zPosition

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _greenView = [[UIView alloc] init];
    _greenView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:_greenView];
    
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:_redView];
    
    _greenView.layer.zPosition = 1.0;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _greenView.frame = CGRectMake(50, 50, 100, 100);
    _redView.frame = CGRectMake(100, 100, 100, 100);
}

@end
