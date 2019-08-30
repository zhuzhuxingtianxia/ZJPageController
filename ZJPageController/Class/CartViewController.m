//
//  CartViewController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/29.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "CartViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface CartViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *blendView;

@end

@implementation CartViewController
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationItem.title = @"购物车页面";
         self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"抽屉" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _label.text = @"这是优惠券";
}

-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}
- (IBAction)sliderChange:(UISlider *)sender {
    [self.label setValue:@(sender.value) forKey:@"progress"];
    [self.blendView setValue:@(sender.value) forKey:@"progress"];
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
