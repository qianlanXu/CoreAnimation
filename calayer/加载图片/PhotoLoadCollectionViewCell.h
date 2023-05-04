//
//  PhotoLoadCollectionViewCell.h
//  calayer
//
//  Created by xu qianlan on 2023/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoLoadCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imagePath;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
