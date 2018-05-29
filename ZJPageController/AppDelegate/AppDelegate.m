//
//  AppDelegate.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/23.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "AppDelegate.h"
#import <MMDrawerController/MMDrawerController.h>

#import "TabBarController.h"
#import "LeftViewController.h"

@interface AppDelegate ()
/**
 *  MMDrawerController属性
 */
@property(nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self createMainView];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)createMainView {
    //1、初始化控制器
    UIViewController *mainVC = [[TabBarController alloc] init];
    UIViewController *leftVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([LeftViewController class])];
    
    UINavigationController *leftNvaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];
    //3、使用MMDrawerController
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:mainVC leftDrawerViewController:leftNvaVC];
    [self.drawerController setShowsShadow:NO];
   
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = self.window.bounds.size.width * 0.8;
    self.drawerController.maximumRightDrawerWidth = 200.0;
   
    [self.window setRootViewController:self.drawerController];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
