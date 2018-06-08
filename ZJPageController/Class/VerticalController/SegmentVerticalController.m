//
//  SegmentVerticalController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "SegmentVerticalController.h"
#import "ZJSegmentView.h"
#import "NetWorkEngine.h"
#import "TitleCell.h"
#import "ImageCell.h"

@interface SegmentVerticalController ()<UITableViewDelegate,UITableViewDataSource,ZJSegmentViewDelagate>
@property (weak, nonatomic) IBOutlet ZJSegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray  *dataSoureArray;

@end

@implementation SegmentVerticalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"垂直滑动";
    [self buildView];
    [self loadData];
}

-(void)buildView {
    _segmentView.delegate = self;
    _segmentView.fontSize = 13;
    _segmentView.normalColor = [UIColor colorHexString:@"#333333"];
    _segmentView.selectedColor = [UIColor colorHexString:@"#ea333d"];
}

-(void)loadData {
    [NetWorkEngine simulation_PostWithURL:@"goodsApi" parameters:@{} response:^(id json) {
        if ([json isKindOfClass:[NSArray class]]) {
           NSArray *array = [TitleModel mj_objectArrayWithKeyValuesArray:json];
            self.dataSoureArray = [NSMutableArray array];
            NSMutableArray *titlesArray = [NSMutableArray array];
            for (TitleModel *model in array) {
                if (model.images.count > 0) {
                    NSMutableArray *groupArray = [NSMutableArray array];
                    
                    model.identifier = NSStringFromClass([TitleCell class]);
                    [titlesArray addObject:model.title];
                    
                    [groupArray addObject:model];
                    for (ImgModel *imgModel in model.images) {
                        imgModel.identifier = NSStringFromClass([ImageCell class]);
                        [groupArray addObject:imgModel];
                    }
                    
                    [self.dataSoureArray addObject:groupArray];
                }
                
            }
           
            _segmentView.dataSource = titlesArray;
            
            [self.tableView reloadData];
        }
        
    }];
}

#pragma mark -- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSoureArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataSoureArray[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.dataSoureArray[indexPath.section];
    NSObject *model = array[indexPath.row];
    return model.heightCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSArray *array = self.dataSoureArray[indexPath.section];
    NSObject *model = array[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
    cell.data = model;
    if ([model isKindOfClass:[ImgModel class]]) {
        ImgModel *imgModel = (ImgModel*)model;
        __weak typeof(self) weakSlef = self;
        imgModel.block = ^{
            [weakSlef.tableView reloadData];
        };
    }
    
    return cell;
}
#pragma mark -- UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView && (scrollView.isDragging || scrollView.isDecelerating)) {
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
        if (self.segmentView.selectedIndex != indexPath.section && indexPath.section < _dataSoureArray.count) {
            self.segmentView.selectedIndex = indexPath.section >= 0 ?indexPath.section : 0;
        }
    }
}

#pragma mark -- ZJSegmentViewDelagate
- (void)segmentView:(ZJSegmentView *)view didSelectedIndex:(NSInteger)index {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
