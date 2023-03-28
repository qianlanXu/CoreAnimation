//
//  ShouldRasterize.m
//  calayer
//
//  Created by xu qianlan on 2023/3/28.
//

#import "ShouldRasterize.h"

@interface ShouldRasterize ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel *label;

@end

@implementation ShouldRasterize

// ??没出现子视图透明度和父视图不一致的情况

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.grayColor;
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 100, 200, 200);
    _button.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_button];
    
    _label = [[UILabel alloc] init];
    _label.text =  @"label";
    _label.frame = CGRectMake(20, 20, 100, 100);
    [_button addSubview:_label];
    
    
    _button.alpha = 0.5;
    
}

@end
