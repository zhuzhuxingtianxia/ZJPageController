//
//  ViewController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/23.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ViewController.h"
#import "ZJPageViewController.h"
#import "ZJSegmentView.h"
#import <Masonry/Masonry.h>
@interface ViewController ()<ZJSegmentViewDelagate>
@property (nonatomic, strong) ZJSegmentView *segmentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *titles = @[@"推荐",@"机器人争霸",@"热点",];
    self.segmentView.datas = titles;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
