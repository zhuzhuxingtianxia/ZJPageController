//
//  LeftViewController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/28.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

// !!!: 事件操作
- (IBAction)pushToOtherController:(id)sender {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
     UIViewController* centerController = self.mm_drawerController.centerViewController;
    if ([centerController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController*)centerController;
        [nav pushViewController:vc animated:YES];
    }else if(centerController.navigationController){
        [centerController.navigationController pushViewController:vc animated:YES];
    }else if ([centerController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabbarVC = (UITabBarController*)centerController;
        UIViewController *selectedController = tabbarVC.selectedViewController;
        if ([selectedController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)selectedController pushViewController:vc animated:YES];
        }else{
            [selectedController.navigationController pushViewController:vc animated:YES];
        }
        
    }
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
