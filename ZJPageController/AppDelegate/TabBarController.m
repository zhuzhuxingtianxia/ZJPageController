//
//  TabBarController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/29.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "TabBarController.h"
#import "ZJNavigationController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildChildController];
}

-(void)buildChildController {
//    NSArray *titleArray = @[@"首页",@"购物车"];
    NSArray *classNames = @[@"MainViewController",@"CartViewController"];
    NSArray *imageArray = @[@"tabBar_home_normal",@"tabBar_cart_normal"];
    NSArray *imageSelectArray = @[@"tabBar_home_press",@"tabBar_cart_press"];
    for (int j=0;j<imageArray.count;j++) {
        NSString *className = classNames[j];
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:className];
        
        vc.tabBarItem.image = [[UIImage imageNamed:imageArray[j]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelectArray[j]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        vc.tabBarItem.title = titleArray[j];
        
        //设置tabbar的title的颜色，字体大小，阴影
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
//        [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
        
//        NSShadow *shad = [[NSShadow alloc] init];
//        shad.shadowColor = [UIColor whiteColor];
        // NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:kGlobalColor,NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
//        NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
//        [vc.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
        ZJNavigationController *navi = [[ZJNavigationController alloc] initWithRootViewController:vc];
        
        [self addChildViewController:navi];
    }

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
