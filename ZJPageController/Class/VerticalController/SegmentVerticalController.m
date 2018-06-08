//
//  SegmentVerticalController.m
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "SegmentVerticalController.h"
#import <SDWebImage/SDWebImageManager.h>
#import "ZJSegmentView.h"
#import "NetWorkEngine.h"
#import "TitleCell.h"
#import "ImageCell.h"

@interface SegmentVerticalController ()<UITableViewDelegate,UITableViewDataSource,ZJSegmentViewDelagate>
@property (weak, nonatomic) IBOutlet ZJSegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray  *dataSoureArray;
@property(nonatomic,strong)NSMutableArray *cellHeights;

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
            [self cellheights:self.dataSoureArray];
            _segmentView.dataSource = titlesArray;
            
            [self.tableView reloadData];
        }
        
    }];
}

-(void)cellheights:(NSArray*)array {
    [self.cellHeights removeAllObjects];
    for (int i = 0; i< array.count; i++) {
        NSArray *subArray = array[i];
        NSMutableArray *subCellHeights = [NSMutableArray array];
        for (NSInteger j = 0; j<subArray.count; j++) {
            [subCellHeights addObject:@(90)];
        }
        [self.cellHeights addObject:subCellHeights];
    }
    __weak typeof(self) weakSlef = self;
    for (int i = 0; i< array.count; i++) {
        NSArray *subArray = array[i];
        NSMutableArray *subCellHeights = self.cellHeights[i];
        for (NSInteger j = 0; j<subArray.count; j++) {
            id model = subArray[j];
            if ([model isKindOfClass:[TitleModel class]]) {
                
                [subCellHeights replaceObjectAtIndex:j withObject:@(24)];
                [self.tableView reloadData];
                
            }else if ([model isKindOfClass:[ImgModel class]]){
                [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:((ImgModel*)model).photo] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    if (image) {
                        CGFloat cellH = ([UIScreen mainScreen].bounds.size.width - 10) * (image.size.height / image.size.width);
                        NSLog(@"cellH = %.2f",cellH);
                        [subCellHeights replaceObjectAtIndex:j withObject:@(cellH)];
                        [weakSlef.tableView reloadData];
                    }
                    
                }];
            }
        }
    }
    
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
    NSArray *subCellHeights = self.cellHeights[indexPath.section];
    NSNumber *number = subCellHeights[indexPath.row];
    
    return number.floatValue+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSArray *array = self.dataSoureArray[indexPath.section];
    NSObject *model = array[indexPath.row];
    UITableViewCell *cell;
    if ([model.identifier isEqualToString:NSStringFromClass([ImageCell class])]) {
        cell = [ImageCell shareCell:tableView model:model];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
        cell.data = model;
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

-(NSMutableArray *)cellHeights{
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
    }
    return _cellHeights;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
