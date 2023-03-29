//
//  Solid.m
//  calayer
//
//  Created by xu qianlan on 2023/3/28.
//

#import "Solid.h"

@interface Solid ()

@property (nonatomic, strong) UILabel *labelA;

@property (nonatomic, strong) UILabel *labelB;

@property (nonatomic, strong) UIButton *buttonC;

@property (nonatomic, strong) UILabel *labelD;

@property (nonatomic, strong) UILabel *labelE;

@property (nonatomic, strong) UILabel *labelF;

@property (nonatomic, strong) NSMutableArray *faces;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIButton *buttonU;

@end

@implementation Solid

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    self.view.backgroundColor = UIColor.whiteColor;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    _containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    _buttonU = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonU.frame = CGRectMake(50, 500, 100, 100);
    [_buttonU addTarget:self action:@selector(didClickButtonU:) forControlEvents:UIControlEventTouchUpInside];
    _buttonU.backgroundColor = UIColor.redColor;
    [self.view addSubview:_buttonU];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 100);
    label.text = @"oo";
    [_buttonU addSubview:label];
   
}

- (void)initViews {
    _faces = [NSMutableArray array];
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:_containerView];
    
    _labelA = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _labelA.text = @"A";
    _labelA.textAlignment = NSTextAlignmentCenter;
    _labelA.backgroundColor = UIColor.redColor;
    [_faces addObject:_labelA];
    
    _labelB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _labelB.text = @"B";
    _labelB.textAlignment = NSTextAlignmentCenter;
    _labelB.backgroundColor = UIColor.orangeColor;
    [_faces addObject:_labelB];
    
    _buttonC = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [_buttonC setTitle:@"C" forState:UIControlStateNormal];
    [_buttonC addTarget:self action:@selector(didClickButtonC:) forControlEvents:UIControlEventTouchUpInside];
    _buttonC.backgroundColor = UIColor.yellowColor;
    [_faces addObject:_buttonC];
    
    _labelD = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _labelD.text = @"D";
    _labelD.textAlignment = NSTextAlignmentCenter;
    _labelD.backgroundColor = UIColor.greenColor;
    [_faces addObject:_labelD];
    
    _labelE = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _labelE.text = @"E";
    _labelE.textAlignment = NSTextAlignmentCenter;
    _labelE.backgroundColor = UIColor.blueColor;
    [_faces addObject:_labelE];
    
    _labelF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _labelF.text = @"F";
    _labelF.textAlignment = NSTextAlignmentCenter;
    _labelF.backgroundColor = UIColor.purpleColor;
    [_faces addObject:_labelF];
    
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    UIView *face = _faces[index];
    [_containerView addSubview:face];
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width * 0.5, containerSize.height * 0.5);
    face.layer.transform = transform;
}

- (void)didClickButtonC:(UIButton *)button {
    NSLog(@"CCCCCCCCCCCCCC");
}

- (void)didClickButtonU:(UIButton *)button {
    NSLog(@"dddddddddd");
}
@end
