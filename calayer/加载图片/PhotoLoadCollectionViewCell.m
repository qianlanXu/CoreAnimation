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

#pragma mark - Setter
- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    // 使用后台线程加载图片来提升性能
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // 加载图片（耗时间的操作，会造成卡顿）
        __block UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 图片必须要在绘制之前解压，所以就强制了解压的及时性。
            // 将整张图片绘制到CGContext中，丢弃原始的图片，并且用一个从上下文内容中新的图片来代替。这样比绘制单一像素那样需要更加复杂的计算，但是因此产生的图片将会为绘制做优化，而且由于原始压缩图片被抛弃了，iOS就不能够随时丢弃任何解压后的图片来节省内存了。
            UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, YES, 0);
            [image drawInRect:self.imageView.bounds];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 在主线程设置图片
            self.imageView.image = image;
        });
    });
    
}

#pragma mark - Public Methods
+ (NSString *)identifier {
    return @"PhotoLoadCollectionViewCell";
}
@end
