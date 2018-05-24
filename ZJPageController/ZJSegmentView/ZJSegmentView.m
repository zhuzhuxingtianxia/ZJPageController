//
//  ZJSegmentView.m
//  ZJPageController
//
//  Created by ZZJ on 2018/5/24.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ZJSegmentView.h"

@interface ZJSegmentView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);

@end
@implementation ZJSegmentView
+ (instancetype)segmentViewWithDatas:(NSArray<NSString *> *)datas {
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:datas.count];
    
    BOOL isDefault = YES;
    for (NSString *str in datas) {
        ZJSegmentModel *model = [[ZJSegmentModel alloc]init];
        model.title = str;
        
        if (isDefault) {
            model.selected = YES;
            isDefault = NO;
        }
        [tmpArr addObject:model];
    }
    
    ZJSegmentView *segment = [[ZJSegmentView alloc]init];
    segment.dataSources = [NSMutableArray arrayWithArray:tmpArr];
    
    return segment;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor yellowColor];
        _selectedColor = [UIColor redColor];
        _normalColor = [UIColor blackColor];
        _fontSize = 12.0;
        [self.collection registerClass:[ZJSegmentCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJSegmentCell class])];
    }
    
    return self;
}
- (void)reloadData {
    
    [self.collection reloadData];
}

- (void)selectedIndexWithBlock:(void(^)(NSInteger index))block {
    
    _selectBlock = block;
}

#pragma mark - setters
- (void)setDatas:(NSArray<NSString *> *)datas {
    _datas = datas;
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:datas.count];
    
    BOOL isDefault = YES;
    for (NSString *str in datas) {
        ZJSegmentModel *model = [[ZJSegmentModel alloc]init];
        model.title = str;
        model.fontSize = self.fontSize;
        if (isDefault) {
            model.selected = YES;
            isDefault = NO;
        }
        [tmpArr addObject:model];
    }
    
    self.dataSources = [NSMutableArray arrayWithArray:tmpArr];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    if (self.dataSources.count > 0) {
        for (ZJSegmentModel *model in self.dataSources) {
            model.fontSize = fontSize;
        }
    }
}

- (void)setDataSources:(NSMutableArray *)dataSources {
    _dataSources = dataSources;
    
    [self.collection reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animation:(BOOL)animation {
    _selectedIndex = selectedIndex;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    
    [self moveLineToIndexPath:path animation:animation];
    if(self.dataSources.count > 0){
     [self.collection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
    }
    
    for (ZJSegmentModel *model in self.dataSources) {
        model.selected = NO;
    }
    
    ZJSegmentModel *model = [self.dataSources objectAtIndex:selectedIndex];
    model.selected = YES;
    
    [self.collection reloadData];
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self setSelectedIndex:selectedIndex animation:YES];
}
#pragma mark - Getter
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = _selectedColor;
        
        [self.collection addSubview:_line];
    }
    
    return _line;
}

#pragma mark - UICollectionView
- (UICollectionView *)collection {
    if (_collection == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 4;
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        collection.delegate = self;
        collection.dataSource = self;
        collection.backgroundColor = self.backgroundColor;
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = NO;
        [self addSubview:collection];
        
        _collection = collection;
    }
    
    return _collection;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJSegmentCell class]) forIndexPath:indexPath];
    
    cell.selectedColor = self.selectedColor;
    cell.normalColor = self.normalColor;
    cell.fontSize = self.fontSize;
    
    ZJSegmentModel *model = [self.dataSources objectAtIndex:indexPath.row];
    cell.title = model.title;
    cell.isSelected = model.selected;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath  {
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    [self setSelectedIndex:indexPath.row animation:YES];
    
    // 代理回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)]) {
        
        [self.delegate segmentView:self didSelectedIndex:indexPath.row];
    }
    // block 回调
    if (self.selectBlock) {
        self.selectBlock(indexPath.row);
    }
}
#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJSegmentModel *model = [self.dataSources objectAtIndex:indexPath.row];
    
    return CGSizeMake(model.width, self.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 4, 0, 4);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
    [self moveLineToIndexPath:path animation:YES];
}

#pragma mark - 移动横线
- (void)moveLineToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation {
    
    ZJSegmentCell *cell = (ZJSegmentCell *)[self.collection cellForItemAtIndexPath:indexPath];
    
    CGRect lineBounds = self.line.bounds;
    lineBounds.size.width = cell.bounds.size.width;
    
    CGPoint lineCenter = self.line.center;
    lineCenter.x = cell.center.x;
    
    if (animation) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.line.bounds = lineBounds;
            self.line.center = lineCenter;
        }];
    } else {
        
        self.line.bounds = lineBounds;
        self.line.center = lineCenter;
    }
    
}
#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collection.backgroundColor = self.backgroundColor;
    self.collection.frame = self.bounds;
    
    ZJSegmentModel *model = [self.dataSources firstObject];
    
    self.line.frame = CGRectMake(4, CGRectGetHeight(self.frame) - 2, model.width, 2);
    
    [self setSelectedIndex:self.selectedIndex animation:NO];
}

@end

///**************************************************
#pragma ZJSegmentCell

@interface ZJSegmentCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ZJSegmentCell
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    self.titleLabel.textColor = isSelected ? _selectedColor : _normalColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.backgroundColor = self.backgroundColor;
    self.titleLabel.frame = self.bounds;
    self.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
    self.titleLabel.text = _title;
    
}
@end


@implementation ZJSegmentModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _selected = NO;
        _fontSize = 12.0;
    }
    
    return self;
}

- (CGFloat)width {
    if (_width <= 0) {
        CGFloat wid = [self.title boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]} context:nil].size.width;
        
        _width = wid + 10;
    }
    
    return _width;
}
@end



