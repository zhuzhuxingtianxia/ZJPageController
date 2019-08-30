//
//  ZJPageViewController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/24.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ZJPageViewController.h"
#import "ZJSegmentView.h"
#import "UIColor+HexConvert.h"
#import <Masonry/Masonry.h>
//状态栏高
#define statusBarH CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)

@interface ZJPageViewController ()<ZJSegmentViewDelagate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) ZJSegmentView *segmentView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ZJPageViewController
+ (ZJPageViewController *)segmentOnViewController:(UIViewController *)viewController childControllers:(NSArray<UIViewController *> *)controllers setmentTitles:(NSArray<NSString *> *)titles {
    
    ZJPageViewController *segment = [[ZJPageViewController alloc]init];
    
    [segment.dataSource addObjectsFromArray:controllers];
    segment.segmentTitles = titles;
    [viewController addChildViewController:segment];
    [viewController.view addSubview:segment.view];
    return segment;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSArray *titles = @[@"推荐",@"机器人争霸",@"热点",@"电视剧",@"资讯",@"儿童",@"直播中心",@"远大前程",@"订阅",@"网络游戏",];
    for (int i = 0; i < titles.count; i++) {
        
        UIViewController *con = [[UIViewController alloc]init];
        [self.dataSource addObject:con];
        con.title = titles[i];
        con.view.backgroundColor = [UIColor randColor];
        
    }
    self.segmentTitles = titles;
    self.segmentView.dataSource = titles;
    self.selectedIndex = 1;
    [self.view setNeedsUpdateConstraints];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.segmentView.selectedIndex = _selectedIndex;
}

-(void)updateViewConstraints {
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if(self.navigationController.navigationBarHidden){
            make.top.mas_equalTo(statusBarH);
        }else{
            //可用于判断坐标原点是否在导航栏下面
            BOOL topBar = self.navigationController.navigationBar.translucent;
            if(topBar){
                make.top.mas_equalTo(44+statusBarH);
            }else{
                make.top.mas_equalTo(0);
                
            }
        }
        
        make.height.mas_equalTo(40);
    }];
    
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentView.mas_bottom);
    }];
    
    [super updateViewConstraints];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    NSAssert(self.dataSource.count > 0, @"Must have one childViewCpntroller at least");
    NSAssert(self.segmentTitles.count == self.dataSource.count, @"The childViewController's count doesn't equal to the count of segmentTitles");
    
    UIViewController *vc = [self.dataSource objectAtIndex:self.selectedIndex];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
//    self.segmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.segmentView];
}
#pragma mark -- UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self.dataSource objectAtIndex:index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == self.dataSource.count - 1 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index++;
    
    return [self.dataSource objectAtIndex:index];
}
/*
 - (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController  {
 
 return 2;
 }
 - (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
 
 return 2;
 }
 */
#pragma mark -- UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    
    NSInteger index = [self.dataSource indexOfObject:nextVC];
    
    _selectedIndex = index;
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        self.segmentView.selectedIndex = _selectedIndex ;
    }
}

/*
// 根据orientation切换UIPageViewControllerSpineLocation
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
}
// 返回支持的方法
- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController{
    
}
// 优先使用的方向
-(UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController{
    
}
*/
 
#pragma mark -- ZJSegmentViewDelagate
- (void)segmentView:(ZJSegmentView *)view didSelectedIndex:(NSInteger)index {
    UIViewController *vc = [self.dataSource objectAtIndex:index];
    
    if (index > _selectedIndex) {
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        
        [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    _selectedIndex = index;
}

#pragma mark -- UIViewController发生改变的一些方法
//这些方法未曾使用过
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"-----viewWillTransitionToSize");
    //    [self.segmentView reloadData];
}
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"-----willTransitionToTraitCollection");
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //处理逻辑，有坑：https://www.jianshu.com/p/4cc4638f44e4
}

#pragma mark -- getter
- (ZJSegmentView *)segmentView {
    if (_segmentView == nil) {
        _segmentView = [[ZJSegmentView alloc]init] ;
        _segmentView.delegate = self;
        _segmentView.normalColor = [UIColor greenColor];
        _segmentView.selectedColor = [UIColor redColor];
//        _segmentView.selectedIndex = 1;
        [self.view addSubview:_segmentView];
    }
    
    return _segmentView;
}
- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:10.0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        for (UIView *subView in _pageViewController.view.subviews) {
            if ([subView isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView*)subView;
                scrollView.delegate = self;
                NSLog(@"找到scrollView");
            }
        }
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
