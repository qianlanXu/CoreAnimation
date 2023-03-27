//
//  HitTestViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/3/27.
//

#import "HitTestViewController.h"

@interface HitTestViewController ()

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) CALayer *blueLayer;
@end

@implementation HitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    _layerView = [[UIView alloc] initWithFrame:CGRectMake(50.f, 50.f, 200.f, 200.f)];
    _layerView.backgroundColor = UIColor.redColor;
    [self.view addSubview:_layerView];
    
    _blueLayer = CALayer.layer;
    _blueLayer.frame = CGRectMake(50.f, 50.f, 100.f, 100.f);
    _blueLayer.backgroundColor = UIColor.blueColor.CGColor;
    [_layerView.layer addSublayer:_blueLayer];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //get touch position relative to main view
//    CGPoint point = [touches.anyObject locationInView:self.view];
//    //convert point to the white layer's coordinates
//    point = [_layerView.layer convertPoint:point fromLayer:self.view.layer];
//    if([_layerView.layer containsPoint:point]) {
//        point = [_blueLayer convertPoint:point fromLayer:_layerView.layer];
//        if([_blueLayer containsPoint:point]) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Inside Blue Layer" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            [alert addAction:confirm];
//            [self presentViewController:alert animated:true completion:nil];
//        } else {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Inside Red Layer" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            [alert addAction:confirm];
//            [self presentViewController:alert animated:true completion:nil];
//        }
//    }
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self.view];
    CALayer *layer = [self.view.layer hitTest:point];
    if (layer == _layerView.layer) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Inside Red Layer" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
    } else if (layer == _blueLayer) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Inside Blue Layer" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirm];
        [self presentViewController:alert animated:true completion:nil];
    }
}


@end
