//
//  Transition.m
//  calayer
//
//  Created by xu qianlan on 2023/4/4.
//

#import "Transition.h"

@interface Transition ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, strong) UIButton *button;

@end

@implementation Transition

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:_imageView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 600, 50, 50);
    _button.backgroundColor = UIColor.orangeColor;
    [_button setTitle:@"change" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _images = @[[UIImage imageNamed:@"Cone"],
                [UIImage imageNamed:@"Snowman"],
                [UIImage imageNamed:@"Igloo"],
                [UIImage imageNamed:@"Ship"]];
}

- (void)didClickButton:(UIButton *)button {
    CATransition *transition = CATransition.animation;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.duration = 5.0;
    [_imageView.layer addAnimation:transition forKey:nil];

    // 当设置了CALayer的content属性的时候，CATransition的确是默认的行为。
    // 但是对于视图关联的图层，或者是其他隐式动画的行为，这个特性依然是被禁用的
    UIImage *currentImage = _imageView.image;
    NSUInteger index = [_images indexOfObject:currentImage];
    UIImage *image = [_images objectAtIndex:(index+1)%_images.count];
    _imageView.image = image;
    
    // 上面等效于下
    
//    [UIView transitionWithView:_imageView duration:5.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        UIImage *currentImage = self.imageView.image;
//        NSUInteger index = [self.images indexOfObject:currentImage];
//        UIImage *image = [self.images objectAtIndex:(index+1)%self.images.count];
//        self.imageView.image = image;
//    } completion:nil];
}

@end
