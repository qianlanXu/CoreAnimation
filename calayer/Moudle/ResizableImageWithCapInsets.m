//
//  ResizableImageWithCapInsets.m
//  calayer
//
//  Created by xu qianlan on 2023/3/20.
//

#import "ResizableImageWithCapInsets.h"
#import "BezierPath.h"

@interface ResizableImageWithCapInsets ()

@end

@implementation ResizableImageWithCapInsets

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self stretch];
    
    
}

- (void)resize {
    UIImage *image = [UIImage imageNamed:@"2"];
    UIEdgeInsets tileSets = {
        .left = 50,
        .top = 17,
        .right = 10,
        .bottom = 10
    };
    
    UIImage *tileImage = [image resizableImageWithCapInsets:tileSets resizingMode:UIImageResizingModeTile];
    
    
    UIImageView *tileView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 300, 200)];
    tileView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:tileView];
    
    
    tileView.image = tileImage;
}

- (void)bezierPath {
    BezierPath *view = [[BezierPath alloc] init];
    [self.view addSubview:view];
    view.frame = CGRectMake(100, 100, view.frame.size.width, view.frame.size.height);
}

- (void)stretch {
    UIImage *stretchImage = [[UIImage imageNamed:@"vip_border"] stretchableImageWithLeftCapWidth:0 topCapHeight:102.f];
    UIImageView *view = [[UIImageView alloc] initWithImage:stretchImage];
    view.backgroundColor = UIColor.greenColor;
    view.frame = CGRectMake(50, 100, 300, 300);
    [self.view addSubview:view];
}

@end
