//
//  Clock.m
//  calayer
//
//  Created by xu qianlan on 2023/3/25.
//

#import "Clock.h"
#import "ClockView.h"

@interface Clock ()

@property (nonatomic, strong) ClockView *clock;

@end

@implementation Clock

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _clock = [[ClockView alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
    [self.view addSubview:_clock];
}

@end
