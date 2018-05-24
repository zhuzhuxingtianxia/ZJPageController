//
//  ZJSegmentView.h
//  ZJPageController
//
//  Created by ZZJ on 2018/5/24.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJSegmentView;

@protocol ZJSegmentViewDelagate <NSObject>

- (void)segmentView:(ZJSegmentView *)view didSelectedIndex:(NSInteger)index ;
@end

@interface ZJSegmentView : UIView
@property (nonatomic, weak) id <ZJSegmentViewDelagate> delegate;
@property (nonatomic, strong) NSArray<NSString *> *datas;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat fontSize;

+ (instancetype)segmentViewWithDatas:(NSArray<NSString *> *)datas ;

- (void)setSelectedIndex:(NSInteger)selectedIndex animation:(BOOL)animation ;
- (void)reloadData;

- (void)selectedIndexWithBlock:(void(^)(NSInteger index))segmentBlock;

@end

///*******************************************************************
#pragma ZJSegmentCell
@interface ZJSegmentCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, assign) CGFloat fontSize;
@end

// 类内部使用的Model
@interface ZJSegmentModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) CGFloat fontSize;
@end
