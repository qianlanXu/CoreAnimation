//
//  Mask.m
//  calayer
//
//  Created by xu qianlan on 2023/3/27.
//

#import "Mask.h"

@interface Mask ()

@end

@implementation Mask

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Igloo"]];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(100, 100, 200, 200);
    
    CALayer *maskLayer = CALayer.layer;
    maskLayer.frame = imageView.layer.bounds;
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"Cone"].CGImage;
    
    imageView.layer.mask = maskLayer;
    
}


@end
