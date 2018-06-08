//
//  MainViewController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/28.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "MainViewController.h"
#import "ZJPageViewController.h"
#import "SegmentVerticalController.h"
#import "ZJSegmentView.h"
#import <Masonry/Masonry.h>
#import "UIViewController+MMDrawerController.h"

@interface MainViewController ()<ZJSegmentViewDelagate>
@property (nonatomic, strong) ZJSegmentView *segmentView;
@end

@implementation MainViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
   self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationItem.title = @"主页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"抽屉" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    
    
    NSArray *titles = @[@"推荐",@"机器人争霸",@"热点",];
    self.segmentView.dataSource = titles;
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        
    }];
}

#pragma mark -- ZJSegmentViewDelagate
- (void)segmentView:(ZJSegmentView *)view didSelectedIndex:(NSInteger)index {
    
}
- (ZJSegmentView *)segmentView {
    if (_segmentView == nil) {
        _segmentView = [[ZJSegmentView alloc]init];
        _segmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _segmentView.delegate = self;
        _segmentView.fontSize = 18;
        _segmentView.normalColor = [UIColor greenColor];
        _segmentView.selectedColor = [UIColor redColor];
        _segmentView.selectedIndex = 0;
        _segmentView.itemWidth = 414/3.0;
        [self.view addSubview:_segmentView];
    }
    
    return _segmentView;
}

- (IBAction)horizontalAction:(id)sender {
    //水平
    ZJPageViewController *page = [ZJPageViewController new];
    page.title = @"水平滚动";
    [self.navigationController pushViewController:page animated:YES];
}

- (IBAction)verticalAction:(id)sender {
    //竖直
    SegmentVerticalController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SegmentVerticalController class])];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)leftBtn{
    //这里的话是通过遍历循环拿到之前在AppDelegate中声明的那个MMDrawerController属性，然后判断是否为打开状态，如果是就关闭，否就是打开(初略解释，里面还有一些条件)
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
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
