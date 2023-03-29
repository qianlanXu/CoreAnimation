//
//  TextLayer.m
//  calayer
//
//  Created by xu qianlan on 2023/3/29.
//

#import "TextLayer.h"
#import "LayerLabel.h"

@interface TextLayer ()

@property (nonatomic, strong) UIView *labelView;

@property (nonatomic, strong) LayerLabel *label;

@end

@implementation TextLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 300, 600)];
    _labelView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:_labelView];
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing  elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet  lobortis";
    NSAttributedString *text1 = [[NSAttributedString alloc] initWithString:@"一键登录（全屏）" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    CATextLayer *textLayer = [self createTextLayer];
    // id类型。这样你既可以用NSString也可以用NSAttributedString来指定文本了
    textLayer.string = text1;
    textLayer.frame = _labelView.bounds;
    [_labelView.layer addSublayer:textLayer];
    
    
    
    _label = [[LayerLabel alloc] initWithFrame:CGRectMake(50, 700, 300, 100)];
    _label.text = @"我是一只小猫咪";
    _label.textColor = UIColor.orangeColor;
    _label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_label];
    
}

- (CATextLayer *)createTextLayer {
    CATextLayer *textLayer = CATextLayer.layer;
    
    // 默认是1.0 这些文本有一些像素化了。这是因为并没有以Retina的方式渲染，第二章提到了这个contentScale属性，用来决定图层内容应该以怎样的分辨率来渲染。contentsScale并不关心屏幕的拉伸因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，UIScreen.mainScreen.scale是3.0
    textLayer.contentsScale = UIScreen.mainScreen.scale;
    
    textLayer.foregroundColor = UIColor.blackColor.CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    // When true the string is wrapped to fit within the layer bounds.
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    return textLayer;
}
@end
