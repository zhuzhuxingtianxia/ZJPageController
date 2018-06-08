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
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);

@end
@implementation ZJSegmentView
+ (instancetype)segmentViewWithDataSource:(NSArray<NSString *> *)dataSource {
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:dataSource.count];
    
    BOOL isDefault = YES;
    for (NSString *str in dataSource) {
        ZJSegmentModel *model = [[ZJSegmentModel alloc]init];
        model.title = str;
        
        if (isDefault) {
            model.selected = YES;
            isDefault = NO;
        }
        [tmpArr addObject:model];
    }
    
    ZJSegmentView *segment = [[ZJSegmentView alloc]init];
    segment.modelArray = [NSMutableArray arrayWithArray:tmpArr];
    
    return segment;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
       [self setup];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    _selectedColor = [UIColor redColor];
    _normalColor = [UIColor blackColor];
    _fontSize = 15.0;
    [self.collection registerClass:[ZJSegmentCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJSegmentCell class])];
}

- (void)reloadData {
    
    [self.collection reloadData];
}

- (void)selectedIndexWithBlock:(void(^)(NSInteger index))block {
    
    _selectBlock = block;
}

#pragma mark - setters
- (void)setDataSource:(NSArray<NSString *> *)dataSource {
    _dataSource = dataSource;
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:dataSource.count];
    
    BOOL isDefault = YES;
    for (NSString *str in dataSource) {
        ZJSegmentModel *model = [[ZJSegmentModel alloc]init];
        model.title = str;
        model.fontSize = self.fontSize;
        if (isDefault) {
            model.selected = YES;
            isDefault = NO;
        }
        [tmpArr addObject:model];
    }
    
    self.modelArray = [NSMutableArray arrayWithArray:tmpArr];
}

- (void)setModelArray:(NSMutableArray *)modelArray {
    _modelArray = modelArray;
    
    if (modelArray.count > 0) {
        [self createLineInitFrame];
    }else {
    
        [self.collection reloadData];
    }
    
}

-(void)createLineInitFrame{
    if (self.line.bounds.size.width <= 0) {
        ZJSegmentModel *model = [_modelArray firstObject];
        self.line.frame = CGRectMake(LineSpacing, CGRectGetHeight(self.frame) - 5, model.width, 2);
        [self setSelectedIndex:self.selectedIndex animation:NO];
        
    }
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self setSelectedIndex:selectedIndex animation:YES];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animation:(BOOL)animation {
    _selectedIndex = selectedIndex;
    
    if(self.modelArray.count > 0){
        NSIndexPath *path = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        
        [self moveLineToIndexPath:path animation:animation];
        
        [self.collection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animation];
    }
    
    for (ZJSegmentModel *model in self.modelArray) {
        model.selected = NO;
    }
    
    ZJSegmentModel *model = [self.modelArray objectAtIndex:selectedIndex];
    model.selected = YES;
    
    [self.collection reloadData];
    
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    if (self.modelArray.count > 0) {
        for (ZJSegmentModel *model in self.modelArray) {
            model.fontSize = fontSize;
        }
    }
}


#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collection.backgroundColor = self.backgroundColor;
    self.collection.frame = self.bounds;
    
    [self createLineInitFrame];
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
    
    return self.modelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJSegmentCell class]) forIndexPath:indexPath];
    
    cell.selectedColor = self.selectedColor;
    cell.normalColor = self.normalColor;
    cell.fontSize = self.fontSize;
    
    ZJSegmentModel *model = [self.modelArray objectAtIndex:indexPath.row];
    cell.model = model;
    
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
static CGFloat LineSpacing = 4.0;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.itemWidth > 0) {
        CGFloat itemWidth = self.itemWidth - (self.modelArray.count+1)*LineSpacing/self.modelArray.count;
        return CGSizeMake(itemWidth, self.bounds.size.height);
    }
    ZJSegmentModel *model = [self.modelArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.width, self.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, LineSpacing, 0, LineSpacing);
}

#pragma mark - 移动横线
- (void)moveLineToIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation {
    
    ZJSegmentCell *cell = (ZJSegmentCell *)[self.collection cellForItemAtIndexPath:indexPath];
    if(cell == nil) {
        [self.collection reloadData];
        [self.collection layoutIfNeeded];
        cell = (ZJSegmentCell *)[self.collection cellForItemAtIndexPath:indexPath];
    }
    UICollectionViewLayoutAttributes *pose = [self.collection.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect lineBounds = self.line.bounds;
    lineBounds.size.width = pose.bounds.size.width;
    
    CGPoint lineCenter = self.line.center;
    lineCenter.x = pose.center.x;
    
    if (animation) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.line.bounds = lineBounds;
            self.line.center = lineCenter;
        }];
    } else {
        
        self.line.bounds = lineBounds;
        self.line.center = lineCenter;
    }
    
}

@end

///**************************************************
#pragma ZJSegmentCell

@interface ZJSegmentCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ZJSegmentCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

-(void)setModel:(ZJSegmentModel *)model {
     self.titleLabel.textColor = model.selected ? _selectedColor : _normalColor;
    self.titleLabel.text = model.title;
}

-(void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    self.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.backgroundColor = self.backgroundColor;
    self.titleLabel.frame = self.bounds;
    
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

@end


@implementation ZJSegmentModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _selected = NO;
        _fontSize = 15.0;
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



