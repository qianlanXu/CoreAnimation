//
//  ViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/3/16.
//

#import "ViewController.h"
#import "CALayerViewController.h"
#import "ResizableImageWithCapInsets.h"
#import "DrawRect.h"
#import "CALayerDelegateViewController.h"
#import "Clock.h"
#import "zPosition.h"
#import "HitTestViewController.h"
#import "Corner.h"
#import "shadowPath.h"
#import "Mask.h"
#import "LCDClock.h"
#import "ShouldRasterize.h"
#import "AffineTransform.h"
#import "Transform3D.h"
#import "Outer.h"
#import "Solid.h"
#import "ShaperLayer.h"
#import "TextLayer.h"
#import "CubeViewController.h"
#import "ReplicatorLayer.h"
#import "EmitterLayer.h"
#import "AVPlayerViewController.h"
#import "TransactionViewController.h"
#import "Presentation.h"
#import "BasicAnimation.h"
#import "Ship.h"
#import "AnimationGroup.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUIComponents];
}

#pragma mark - customUI

- (void)createUIComponents {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.rowHeight = 45;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _titles = [[NSArray alloc] initWithObjects:@"CALayer", @"Resize", @"DrawRect", @"CALayerDelegateViewController", @"Clock", @"zPosition", @"hitTest",@"corner", @"shadowPath", @"Mask", @"LCD", @"ShouldRasterize", @"AffineTransform", @"Transform3D", @"Outer", @"Solid", @"ShaperLayer", @"TextLayer", @"CubeViewController", @"ReplicatorLayer", @"EmitterLayer", @"AVPlayer", @"Transaction", @"Presentation", @"BasicAnimation", @"Ship", @"AnimationGroup", nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [_titles objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CALayerViewController *viewController = [[CALayerViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 1) {
        ResizableImageWithCapInsets *viewController = [[ResizableImageWithCapInsets alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 2) {
        DrawRect *ViewController = [[DrawRect alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
    } else if (indexPath.row == 3) {
        CALayerDelegateViewController *viewController = [[CALayerDelegateViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 4) {
        Clock *viewController = [[Clock alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 5) {
        zPosition *viewController = [[zPosition alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 6) {
        HitTestViewController *viewController = [[HitTestViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 7) {
        Corner *viewController = [[Corner alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 8) {
        shadowPath *viewController = [[shadowPath alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 9) {
        Mask *viewController = [[Mask alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 10) {
        LCDClock *viewController = [[LCDClock alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 11) {
        ShouldRasterize *viewController = [[ShouldRasterize alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 12) {
        AffineTransform *viewController = [[AffineTransform alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 13) {
        Transform3D *viewController = [[Transform3D alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 14) {
        Outer *ViewController = [[Outer alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
    } else if (indexPath.row == 15) {
        Solid *viewController = [[Solid alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 16) {
        ShaperLayer *viewController = [[ShaperLayer alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 17) {
        TextLayer *viewController = [[TextLayer alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 18) {
        CubeViewController *viewController = [[CubeViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 19) {
        ReplicatorLayer *viewController = [[ReplicatorLayer alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 20) {
        EmitterLayer *viewController = [[EmitterLayer alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 21) {
        AVPlayerViewController *viewController = [[AVPlayerViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 22) {
        TransactionViewController *viewController = [[TransactionViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 23) {
        Presentation *viewController = [[Presentation alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 24) {
        BasicAnimation *viewController = [[BasicAnimation alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 25) {
        Ship *viewController = [[Ship alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 26) {
        AnimationGroup *viewController = [[AnimationGroup alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
@end
