//
//  ZJBlendView.h
//  ZJPageController
//
//  Created by ZZJ on 2018/9/25.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJBlendView : UIView
//范围：0.0 - 1.0
@property (nonatomic, assign)IBInspectable CGFloat progress;
//填充颜色
@property (nonatomic, copy)IBInspectable   UIColor *fillColor;

@end

@interface ZJBlendLabel : UILabel
//范围：0.0 - 1.0
@property (nonatomic, assign)IBInspectable CGFloat progress;
/*
 设置bgFillColor后，填充色为白色，设置fillColor无效
 */
//背景填充颜色
@property (nonatomic, copy)IBInspectable   UIColor *bgFillColor;

//填充颜色
@property (nonatomic, copy)IBInspectable   UIColor *fillColor;


@end
