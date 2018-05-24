//
//  ViewController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/23.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ViewController.h"
#import "ZJPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)horizontalAction:(id)sender {
    //水平
    ZJPageViewController *page = [ZJPageViewController new];
    page.title = @"水平滚动";
    [self.navigationController pushViewController:page animated:YES];
}

- (IBAction)verticalAction:(id)sender {
    //竖直
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
