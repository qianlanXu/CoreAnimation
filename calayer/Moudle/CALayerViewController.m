//
//  CALayerViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/3/16.
//

#import "CALayerViewController.h"

@interface CALayerViewController ()

@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    CALayer *colorLayer = [CALayer new];
    colorLayer.backgroundColor = UIColor.greenColor.CGColor;
    colorLayer.frame = CGRectMake(50, 200, 200, 200);
    // 图层必须添加在图层上
    [self.view.layer addSublayer:colorLayer];
    
    // 如果你没有使用ARC（自动引用计数），你就不需要__bridge这部分
    UIImage *image = [UIImage imageNamed:@"1"];
    colorLayer.contents = (__bridge id)image.CGImage;
    
    colorLayer.contentsGravity = kCAGravityResizeAspectFill;
//    contentsRect属性是一个可以让图层边框显示图片的一部分区域。它不是按点来计算的，它使用了单位坐标，单位坐标指定在0到1之间。默认的contentsRect是｛0, 0,1,1｝，表示显示图片的全部区域。如果我们设定一个小一点的矩形，图片就会被裁减。如果给contentsRect设置一个负数的原点或是大于{1, 1}的尺寸也是可以的。这种情况下，最外面的像素会被拉伸以填充剩下的区域。

 //   colorLayer.contentsRect = CGRectMake(-1, -1, 1.5, 1.5);
    
    //contentsCenter,默认为{0,0,1,1}
    colorLayer.contentsCenter = CGRectMake(0, 0, 1, 1);
    
    //colorLayer.contentsScale = image.scale;
    
//    self.view.clipsToBounds = YES;
//    colorLayer.masksToBounds = YES;
}

@end
