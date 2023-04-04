//
//  SceneDelegate.m
//  calayer
//
//  Created by xu qianlan on 2023/3/16.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabViewController;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = [[UIWindowScene alloc] initWithSession:session connectionOptions:connectionOptions];
    self.window = [[UIWindow alloc]initWithWindowScene:windowScene];
        
    ViewController *mainVC = [[ViewController alloc]init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    navigationVC.tabBarItem.title = @"吧唧";
    navigationVC.tabBarItem.image = [UIImage imageNamed:@"Ship"];
    navigationVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6.0, 0.0, -6.0,0.0);
    [navigationVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 15)];
    
    UIViewController *secondViewController = [[ViewController alloc] init];
    secondViewController.tabBarItem.title = @"猫咪";
    secondViewController.tabBarItem.image = [UIImage imageNamed:@"Ship"];

    _tabViewController = [[UITabBarController alloc] init];
    _tabViewController.viewControllers = @[navigationVC, secondViewController];
    _tabViewController.delegate = self;
    
    
    self.window.rootViewController = _tabViewController;
    [self.window makeKeyAndVisible];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    CATransition *transition = CATransition.animation;
    transition.type = kCATransitionFromBottom;
    transition.subtype = kCATransitionPush;
    transition.duration = 5.0;
    [_tabViewController.view.layer addAnimation:transition forKey:nil];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
