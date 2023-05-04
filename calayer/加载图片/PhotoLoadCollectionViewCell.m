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
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        // 在主线程设置图片
        self.imageView.image = image;
    });
    
}

#pragma mark - Public Methods
+ (NSString *)identifier {
    return @"PhotoLoadCollectionViewCell";
}
@end
