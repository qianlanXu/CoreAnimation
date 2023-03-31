//
//  AVPlayerViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/3/31.
//

#import <AVFoundation/AVFoundation.h>
#import "AVPlayerViewController.h"

@interface AVPlayerViewController ()

// 这样其实是为了可以使用自动布局限制使得图层在最中间；否则，一旦设备被旋转了我们就要手动重新放置位置，因为Core Animation并不支持自动大小和自动布局
// 因为AVPlayerLayer是CALayer的子类，它继承了父类的所有特性。我们并不会受限于要在一个矩形中播放视频
@property (nonatomic, strong) UIView *containerView;

@end

@implementation AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 300, 400)];
    [self.view addSubview:_containerView];
    
    
    AVPlayer *player = [AVPlayer playerWithURL:[NSBundle.mainBundle URLForResource:@"Ship" withExtension:@"mp4"]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = _containerView.bounds;
    
    [_containerView.layer addSublayer:playerLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;
    
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 10;
    playerLayer.borderColor = UIColor.redColor.CGColor;
    playerLayer.borderWidth = 2;
    
    [player play];
    
    
}



@end
