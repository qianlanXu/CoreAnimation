//
//  PhotoLoadCollectionViewCell.m
//  calayer
//
//  Created by xu qianlan on 2023/4/24.
//

#import "PhotoLoadCollectionViewCell.h"

@interface PhotoLoadCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PhotoLoadCollectionViewCell

+ (Class)layerClass {
    return CATiledLayer.class;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUIComponents];
    }
    return self;
}

- (void)createUIComponents {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_imageView];
}

#pragma mark - Overrides
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageWithContentsOfFile:_imagePath];
    CGFloat aspectRatio = image.size.height / image.size.width;
    CGRect imageRect = CGRectZero;
    imageRect.size.width = self.layer.bounds.size.width;
    // tileSize属性单位是像素，而不是点，所以为了保证瓦片和表格尺寸一致，需要乘以屏幕比例因子。
    imageRect.size.height = self.layer.bounds.size.height * aspectRatio;
    imageRect.origin.y = (self.layer.bounds.size.height - imageRect.size.height) * 0.5;
    CGContextRef context = UIGraphicsGetCurrentContext();
    // draw file
    UIGraphicsPushContext(context);
    [image drawInRect:imageRect];
    UIGraphicsPopContext();
}


#pragma mark - Public Methods
+ (NSString *)identifier {
    return @"PhotoLoadCollectionViewCell";
}
@end
