//
//  LayerLabel.m
//  calayer
//
//  Created by xu qianlan on 2023/3/29.
//

#import "LayerLabel.h"

@implementation LayerLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    // we should really derive these from the UILabel settings too
    //but that's complicated, so for now we'll just hard-code them
    self.textLayer.alignmentMode = kCAAlignmentJustified;
    self.textLayer.wrapped = YES;
    //Reload the content of this layer. Calls the -drawInContext
    [self.layer display];
}

- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}
// 每一个UIView都是寄宿在一个CALayer的示例上。这个图层是由视图自动创建和管理的，那我们可以用别的图层类型替代它么？一旦被创建，我们就无法代替这个图层了。但是如果我们继承了UIView，那我们就可以重写+layerClass方法使得在创建的时候能返回一个不同的图层子类。UIView会在初始化的时候调用+layerClass方法，然后用它的返回类型来创建宿主图层。
+ (Class)layerClass {
    return CATextLayer.class;
}

- (void)setText:(NSString *)text {
    super.text = text;
    self.textLayer.string = text;
}

- (void)setTextColor:(UIColor *)textColor {
    super.textColor = textColor;
    self.textLayer.foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    super.font = font;
    CFStringRef stringRef = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(stringRef);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}
@end
