//
//  ZJBlendView.m
//  ZJPageController
//
//  Created by ZZJ on 2018/9/25.
//  Copyright © 2018年 Jion. All rights reserved.
//

#import "ZJBlendView.h"
@interface ZJBlendView ()


@end
@implementation ZJBlendView

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_fillColor) {
        
        [_fillColor setFill];
        CGRect lyricRect = CGRectMake(0, 0, self.frame.size.width * _progress, self.frame.size.height);
        UIRectFillUsingBlendMode(lyricRect, kCGBlendModeSourceIn);
         
    }
    
}

@end


@implementation ZJBlendLabel

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_bgFillColor) {
        [_bgFillColor setFill];
        CGRect lyricRect = CGRectMake(0, 0, self.frame.size.width * _progress, self.frame.size.height);
        //背景变为目的色,线条自动变为白色（比如图标线条原为蓝色，会自动变为白色）
        UIRectFillUsingBlendMode(lyricRect, kCGBlendModeSourceOut);
    }
    
    if (_fillColor) {
        
        [_fillColor setFill];
        CGRect lyricRect = CGRectMake(0, 0, self.frame.size.width * _progress, self.frame.size.height);
        UIRectFillUsingBlendMode(lyricRect, kCGBlendModeSourceIn);
        
    }
    
}

@end

