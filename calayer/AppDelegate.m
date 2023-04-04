//
//  AppDelegate.m
//  calayer
//
//  Created by xu qianlan on 2023/3/16.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *oneViewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:oneViewController];
    
    
    UIViewController *secondViewController = [[ViewController alloc] init];
    _tabViewController = [[UITabBarController alloc] init];
    _tabViewController.viewControllers = @[navigationController, secondViewController];
    _tabViewController.delegate = self;
    
    self.window.rootViewController = _tabViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    CATransition *transition = CATransition.animation;
    transition.type = kCATransitionFromBottom;
    [_tabViewController.view.layer addAnimation:transition forKey:nil];
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
