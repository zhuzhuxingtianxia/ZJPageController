//
//  UIView+Appertain.h
//  ZJPageController
//
//  Created by ZZJ on 2018/6/8.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellProtocol<NSObject>

@optional
/**
 *  选择中某个Item的操作
 *
 *  @param data      该Item携带的数据
 *  @param indexPath 该Item的IndexPath
 */
- (void)cellSelectWithData:(id)data withIndexPath:(NSIndexPath *)indexPath;

@end

//NSObject添加附加属性
@interface NSObject(Appertain)
@property (nonatomic,copy)NSString *identifier;

@end

//UIView添加附加属性
@interface UIView (Appertain)
@property (nonatomic,strong)id data;
@property (nonatomic,assign)CGFloat  heightCell;
@property (nonatomic,weak)NSIndexPath *indexPathValue;
@property (nonatomic,assign)NSInteger  cellType;

//与上面的事件代理一起使用
@property (nonatomic, weak) id<CellProtocol> aDelegate;
@end
