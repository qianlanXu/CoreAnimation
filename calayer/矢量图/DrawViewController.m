//
//  DrawViewController.m
//  calayer
//
//  Created by xu qianlan on 2023/4/18.
//

#import "DrawViewController.h"
#import "DrawView.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    DrawView *view = [[DrawView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
}



@end
