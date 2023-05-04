//
//  PhotoLoad.m
//  calayer
//
//  Created by xu qianlan on 2023/4/24.
//

#import "PhotoLoad.h"
#import "PhotoLoadCollectionViewCell.h"

@interface PhotoLoad () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *imagePaths;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PhotoLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagePaths = [NSBundle.mainBundle pathsForResourcesOfType:@".png" inDirectory:@"Vacation Photos"];
    [self createView];
}

- (void)createView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 40;
    layout.minimumInteritemSpacing = 40;
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = UIColor.redColor;
    [_collectionView registerClass:PhotoLoadCollectionViewCell.class forCellWithReuseIdentifier:PhotoLoadCollectionViewCell.identifier];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagePaths.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoLoadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoLoadCollectionViewCell.identifier forIndexPath:indexPath];
    cell.imagePath = _imagePaths[indexPath.row];
    return cell;
}
@end
