//
//  DrawRect.m
//  calayer
//
//  Created by xu qianlan on 2023/3/21.
//

#import "DrawRect.h"
#import "CustomCircleView.h"
#import "CustomDrawRectView.h"

@interface DrawRect ()

@end

@implementation DrawRect

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomDrawRectView *view = [[CustomDrawRectView alloc] initWithFrame:CGRectMake(0, 100, 400, 700)];
    [self.view addSubview:view];
}



@end
